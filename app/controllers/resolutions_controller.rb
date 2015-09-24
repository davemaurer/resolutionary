class ResolutionsController < ApplicationController
  def show
  end

  def index
  end

  def new
    @resolution = Resolution.new
  end

  def create
    @resolution = Resolution.where(resolution_params).first_or_create
    flash[:notice] = "Resolution created!"
    redirect_to dashboard_path
  end

  def edit
  end

  private

  def resolution_params
    params.require(:resolution).permit(:title, :description, :motive_image)
  end
end
