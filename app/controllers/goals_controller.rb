class GoalsController < ApplicationController
  def new
    @resolution = Resolution.find(params[:resolution_id])
    @goal = Goal.new
  end

  def create
    goal = resolution.goals.where(goal_params).first_or_create
    if goal.save
      flash[:notice] = "Goal created for #{resolution.title}"
      redirect_to dashboard_path
    else
      flash[:notice] = "Please try again"
      redirect_to dashboard_path
    end
  end

  def edit
    @resolution = Resolution.find(params[:resolution_id])
    @goal = Goal.find(params[:id])
  end

  def update
    goal = Goal.find(params[:id])
    if goal.update(goal_params)
      flash[:notice] = "Goal Updated Successfully"
      redirect_to dashboard_path
    else
      flash[:notice] = "Please try again"
      redirect_to dashboard_path
    end
  end

  def destroy
    resolution.goals.find(params[:id]).destroy
    flash[:notice] = "Goal removed"
    redirect_to dashboard_path
  end

  def goal_complete
    goal = resolution.goals.find(params[:id])
    goal.update(completed: true)
    flash[:notice] = "Congratulations on reaching your goal!"
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
