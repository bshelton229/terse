module UrlsHelper
  def short_url(url)
    root_url + url.slug
  end
end
