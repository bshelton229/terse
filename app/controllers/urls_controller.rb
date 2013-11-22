class UrlsController < ApplicationController
  def index
    @url = Url.new
    @user_urls = current_user.urls.top.page(params[:page]) if current_user

    respond_to do |format|
      format.html
    end
  end

  def create
    @url = Url.new(url_params)
    @url.user = current_user if current_user
    @url.save
    @user_urls = current_user.urls.top.page(params[:page]) if current_user

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def resolve
    @url = Url.redirect! params[:slug], request
    respond_to do |format|
      if @url
        format.html { redirect_to @url.full }
      else
        format.html { not_found }
      end
    end
  end

  private
    def url_params
      params.require(:url).permit(:full)
    end
end
