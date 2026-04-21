class UsersController < ApplicationController
  before_action :authenticate_user!

  # マイページ（ユーザー情報＋累計データ）
  def mypage
    @user = current_user
    @progress = current_user.travel_progress
    @exercises = current_user.exercises

    @total_minutes = @exercises.sum(:minutes)
    @total_distance = @exercises.sum(:distance)
    @level = @progress.level
  end

  # ダッシュボード（旅の進捗＋今日のデータ）
  def dashboard
  @travel_progress = current_user.travel_progress
  @progress = @travel_progress   # ← これが必須！

  @today_minutes = current_user.exercises.where(created_at: Time.zone.today.all_day).sum(:minutes)
  @today_distance = current_user.exercises.where(created_at: Time.zone.today.all_day).sum(:distance)
  @exercises = current_user.exercises.order(created_at: :desc)
  end

  def home
  @user = current_user
  end
end