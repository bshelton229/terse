class UrlsController < ApplicationController
  def index
    @url = Url.new
    @user_urls = current_user.urls.order("created_at DESC").limit(20) if current_user
  end

  def create
    @url = Url.new(url_params)
    @url.user = current_user if current_user
    respond_to do |format|
      if @url.save
        format.html { redirect_to root_path }
        format.js
      else
        format.html { redirect_to root_path }
      end
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
