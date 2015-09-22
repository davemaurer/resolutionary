class SessionsController < ApplicationController
  def create
    if user = User.from_omniauth(oauth_data)
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def oauth_data
    request.env['omniauth.auth']
  end
end
