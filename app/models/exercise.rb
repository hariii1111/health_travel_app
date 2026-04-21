class Exercise < ApplicationRecord
  belongs_to :user

  validates :minutes, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_validation :calculate_values
  after_create :add_exp_to_character
  after_save :recalc_and_update_level
  after_destroy :recalc_and_update_level

  # ★ ここに formatted_time を入れる
  def formatted_time
    hours = minutes / 60
    mins  = minutes % 60

    if hours > 0
      "#{hours}時間#{mins}分"
    else
      "#{mins}分"
    end
  end

  private

  def calculate_values
    self.mets ||= 3.0
    self.calories = (mets * 60 * (minutes.to_f / 60)).round(1)
    self.distance = (calories * 0.02).round(2)
  end

  def add_exp_to_character
    cs = user.character_status
    gained_exp = (minutes.to_f * 0.5).round(1)
    cs.update(exp: cs.exp + gained_exp)
  end

  def update_character_level
    user.character_status.sync_level_from_travel
  end

  def recalc_and_update_level
    user.travel_progress.recalc_total_distance!
    update_character_level
  end
end
