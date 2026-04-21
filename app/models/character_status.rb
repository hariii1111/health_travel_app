class CharacterStatus < ApplicationRecord
  belongs_to :user

  # 経験値テーブルはもう使わないが、残しても害はない
  LEVEL_EXP = {
    1 => 0,
    2 => 100,
    3 => 250,
    4 => 450,
    5 => 700
  }.freeze

  # レベルに応じた画像
  def image_path
    case level
    when 1
      "character/level1.png"
    when 2
      "character/level2.png"
    when 3
      "character/level3.png"
    when 4
      "character/level4.png"
    else
      "character/level5.png"
    end
  end

  # ★ 経験値は増やすだけ（レベルは変えない）
  def add_exp(minutes)
    gained = minutes * 0.5
    self.exp += gained
    self.total_exp += gained
    save
  end

  # ★ レベルは TravelProgress.level をコピーするだけ
  def sync_level_from_travel
    travel_level = user.travel_progress.level
    update(last_level: level, level: travel_level)
  end

  # レベルアップ判定（距離ベース）
  def level_up?
    last_level.present? && level > last_level
  end
end
