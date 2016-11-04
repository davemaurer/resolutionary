class DashboardController < ApplicationController
  def show
    @resolutions = current_user.current_resolutions
    @forgotten = current_user.forgotten_resolutions
  end
end
