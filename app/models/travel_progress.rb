class TravelProgress < ApplicationRecord
  belongs_to :user

  ROUTE = [
    ["東京都", 0],
    ["神奈川県", 30],
    ["静岡県", 100],
    ["愛知県", 250],
    ["三重県", 330],
    ["京都府", 420],
    ["大阪府", 470],
    ["兵庫県", 520]
  ].freeze

  # レベル計算
  def level
    case total_distance
    when 0...50
      1
    when 50...150
      2
    when 150...300
      3
    when 300...500
      4
    else
      5
    end
  end

  # レベルコメント
  def level_comment
    case level
    when 1
      "まだまだこれからだよ！一緒にがんばろう！"
    when 2
      "いい調子！このまま続けよう！"
    when 3
      "すごい！旅がどんどん進んでる！"
    when 4
      "もうベテランの旅人だね！"
    else
      "伝説の旅人！尊敬するよ！"
    end
  end

  # レベルアップ判定
  def level_up?
    last_level.present? && level > last_level
  end

  # 現在地
  def current_location
    return "東京都" if total_distance.nil?

    ROUTE.reverse_each do |pref, distance|
      return pref if total_distance >= distance
    end

    "東京都"
  end

  # 次の県
  def next_prefecture
    return nil if total_distance.nil?

    ROUTE.each_cons(2) do |current, nxt|
      return nxt[0] if total_distance < nxt[1]
    end

    nil
  end

  # 次の県までの距離
  def distance_to_next
    return 0 if total_distance.nil?

    ROUTE.each_cons(2) do |current, nxt|
      if total_distance < nxt[1]
        return (nxt[1] - total_distance).round(1)
      end
    end

    0
  end

  # ★ 全 Exercise から距離を再計算
  def recalc_total_distance!
    total = user.exercises.sum(:distance)
    update!(total_distance: total)
  end

  # ★ 進捗率（最大100%）
  def progress_percentage
    return 0 if total_distance.nil?

    goal = ROUTE.last[1]   # 520km
    percent = (total_distance / goal) * 100
    [percent.round, 100].min
  end
end
