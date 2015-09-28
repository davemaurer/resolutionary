class GoalsController < ApplicationController
  def index
  end

  def new
    @resolution = Resolution.find(params[:resolution_id])
    @goal = Goal.new
  end

  def create
    resolution.goals.where(goal_params).first_or_create
    redirect_to dashboard_path
  end

  private

  def resolution
    @resolution ||= Resolution.find(params[:resolution_id])
  end

  def goal_params
    params.require(:goal).permit(:resolution_id, :name, :completed)
  end
end
