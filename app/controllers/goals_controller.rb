class GoalsController < ApplicationController
  def index
  end

  def new
    @resolution = Resolution.find(params[:id])
    @goal = Goal.new
  end

  def create
    resolution = Resolution.find(params[:id])
    resolution.goals.where(goal_params).first_or_create
    redirect_to dashboard_path
  end

  private

  def goal_params
    params.require(:goals).permit(resolution_id, :name, completed)
  end
end
