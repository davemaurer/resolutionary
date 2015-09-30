class RemindersController < ApplicationController
  def new
    @resolution = Resolution.find(params[:resolution_id])
    @reminder = Reminder.new
  end

  def create
    resolution = Resolution.find(params[:resolution_id])
    resolution.reminders.where(reminder_params).first_or_create
    flash[:notice] = "Reminder created for #{resolution.title}"
    redirect_to dashboard_path
  end

  def destroy
    resolution.reminder.find(params[:id]).destroy
    flash[:notice] = "Reminder removed"
    redirect_to dashboard_path
  end

  private

  def reminder_params
    params.require(:reminder).permit(:phone_number)
  end
end
