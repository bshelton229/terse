class UrlsController < ApplicationController
  def index

  end

  def resolve
    @url = Url.find_by slug: params[:slug]
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
