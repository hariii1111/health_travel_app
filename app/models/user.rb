class User < ApplicationRecord
  has_many :exercises, dependent: :destroy
  has_one :travel_progress, dependent: :destroy
  has_one :character_status, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable


  after_create :create_travel_progress
  after_create :create_character_status

  private

  def create_travel_progress
    TravelProgress.create(user: self, total_distance: 0)
  end

  def create_character_status
    CharacterStatus.create(
      user: self,
      level: 1,
      exp: 0,
      total_exp: 0,
      last_level: 1
    )
  end
end
