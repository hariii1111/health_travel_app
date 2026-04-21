module ApplicationHelper
  def minutes_to_hm(minutes)
    hours = minutes / 60
    mins  = minutes % 60

    if hours > 0
      "#{hours}時間#{mins}分"
    else
      "#{mins}分"
    end
  end
end
