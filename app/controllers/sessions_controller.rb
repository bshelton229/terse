class SessionsController < ApplicationController
  def create
    if user = User.from_github_auth(auth)
      session[:user_id] = user.id
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
    def auth
      request.env['omniauth.auth']
    end
end
