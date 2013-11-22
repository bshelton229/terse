class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :developer_strategy

  def create
    if user = User.from_github_auth(auth)
      session[:user_id] = user.id
    end
    redirect_to root_path
  end

  # Developer endpoint
  def developer_strategy;create;end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
    def auth
      request.env['omniauth.auth']
    end
end
