class ResolutionsController < ApplicationController
  def show
  end

  def index
  end

  def new
    @resolution = Resolution.new
  end

  def create
    if current_user
      current_user.resolutions.where(resolution_params).first_or_create
      flash[:notice] = "Resolution created!"
      redirect_to dashboard_path
    end
  end

  def edit
    @resolution = Resolution.find(params[:id])
  end

  def update
    resolution = Resolution.find(params[:id])
    if resolution.update(resolution_params)
      flash[:notice] = "Resolution Updated Successfully"
      redirect_to dashboard_path
    else
      flash.now[:notice] = "Please try again"
      render :edit
    end
  end

  def destroy
    resolution = Resolution.find(params[:id])
    resolution.destroy
    flash[:notice] = "Resolution is gone forever!"
    redirect_to dashboard_path
  end

  def complete
    resolution = Resolution.find(params[:id])
    resolution.update(finished: true)
    flash[:notice] = "Congratulations, your resolution is complete!"
    redirect_to user_path(current_user)
  end

  def again
    resolution = Resolution.find(params[:id])
    resolution.update(finished: false)
    flash[:notice] = "Your resolution is now active again"
    redirect_to dashboard_path
  end

  private

  def resolution_params
    params.require(:resolution).permit(:user_id, :title, :description, :motive_image, :finished)
  end
end
