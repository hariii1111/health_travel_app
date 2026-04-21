class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @travel_progress = current_user.travel_progress

    today_records = current_user.exercises.where(created_at: Time.zone.today.all_day)
    @today_minutes = today_records.sum(:minutes)
    @today_distance = today_records.sum(:distance)
  end
end
