require 'hpricot'
require 'net/http'
require 'open-uri'

module Parse
  module Page
    
    def parse_page(url)
      parsed_url = URI.parse(url)
      url = "http://#{url}" unless url =~ %r(^http://)

      page = open(url) { |f| Hpricot(f) }
      results = {}
      results[:title] = self.parse_title(page)
      results[:description] = self.parse_description(page)
      results[:images] = self.parse_images(page, parsed_url)

      results
    end

    def self.parse_title(doc)
      (doc/"head/title").inner_html
    end

    def self.parse_description(doc)
      desc = (doc/"head/meta[@name='description']")
      return false unless desc.present?
      desc.first.attributes['content']
    end

    def self.parse_images(doc, url)
      images = (doc/"img")
      valid_images = []
      images.each do |image|
        image_url = self.concat_url(url, image.attributes['src'])
        valid_images << image_url if self.is_valid_image? image_url
      end

      valid_images
    end

    def self.is_valid_image?(image_url)
      min_image_size = 3500
      url = URI.parse(image_url)
      response = nil

      Net::HTTP.start(url.host, url.port) { |http| response = http.request_head(url.path) }
      return false unless response and response['content-length'].present?

      response['content-length'].to_i >= min_image_size
    end

    def self.concat_url(parsed_url, path)
      return path if path =~ %r(^http://)
      base_url = "#{parsed_url.scheme}://#{parsed_url.host}"
      base_url += parsed_url.path unless path =~ %r(^/)
      base_url += path
    end

  module_function :parse_page

  end
end
