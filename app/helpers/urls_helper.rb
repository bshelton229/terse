module UrlsHelper
  # Return the full url for the slug
  def short_url(url)
    resolve_url(slug: url.slug)
  end
end
