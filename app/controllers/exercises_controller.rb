class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:edit, :update, :destroy]

  def index
    @exercises = current_user.exercises.order(created_at: :desc)
  end

  def new
    @exercise = current_user.exercises.new
  end

  def create
    @exercise = current_user.exercises.new(exercise_params)
    if @exercise.save
      redirect_to exercises_path, notice: "運動記録を追加しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @exercise.update(exercise_params)
      redirect_to exercises_path, notice: "運動記録を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @exercise.destroy
    redirect_to exercises_path, notice: "運動記録を削除しました"
  end

  private

  def set_exercise
    @exercise = current_user.exercises.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:minutes, :mets)
  end
end
