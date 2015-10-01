class DashboardController < ApplicationController
  def show
    @resolutions = current_user.current_resolutions
  end
end
