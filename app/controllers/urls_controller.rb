class UrlsController < ApplicationController
  def index

  end

  private
    def url_params
      params.require(:url).permit(:full)
    end
end
