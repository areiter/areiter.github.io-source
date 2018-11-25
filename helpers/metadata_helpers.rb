require 'active_support/core_ext/string/inflections'
require 'sanitize'

module MetadataHelpers
  def title
    page_title = Sanitize.fragment(current_page.data.title)
    return page_title if page_title.to_s.include?('Andreas Reiter')

    [(page_title || slug), 'Andreas Reiter'].join(' - ')
  end

  def slug
    template_name = File.basename(current_page.file_descriptor.relative_path).sub(/\..*/, '')
    template_name.gsub('-', ' ').humanize
  end

  def summary(path, html = true)
    path += '.html' unless path.end_with?('.html')
    page = sitemap.find_resource_by_path(path)

    html ? page.html_summary : page.text_summary
  end

  def source_url(page)
    'https://github.com/areiter/areiter.github.io-source'
  end
end