module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Linkshot"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def page_description(page_description)
    base_description = "Linkshot: Share a set of linkss"
    if page_description.empty?
      base_description
    else
      "#{page_description}"
    end
  end

  def canonical_url(url)
    base_url = "https://linkshot.com"
    if url.empty?
      base_url
    else
      "#{url}"
    end
  end

  def og_image(og_image)
    base_og_image = "linkshot.png"
    if og_image.empty?
      base_og_image
    else
      "#{og_image}"
    end
  end  

  def get_host_without_www(url)
    uri = URI.parse(url)
    uri = URI.parse("http://#{url}") if uri.scheme.nil?
    host = uri.host.downcase
    host.start_with?('www.') ? host[4..-1] : host
  end

end
