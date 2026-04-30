class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :logout]

  def index
    if user_signed_in?
      @progress = current_user.travel_progress
      @exercises = current_user.exercises.order(created_at: :desc)
    else
      @exercises = []
    end
  end

  def logout
  end
end
