module UrlsHelper
  # Return the full url for the slug
  def short_url(url)
    resolve_url(slug: url.slug)
  end

  def url_display_name(url)
    out = [link_to(url.full, url.full)]
    out << "(#{url.title})" if url.title.present?
    raw out.join ' '
  end
end
