# frozen_string_literal: true

require 'fileutils'
require 'open-uri'

class ImageDownloader
  def self.call(url)
    new(url).call
  end

  attr_reader :url

  def initialize(url)
    @url = url
  end

  def call
    save_image(storage_path)
  end

  private

  def storage_path
    uri = URI @url
    dir = File.dirname(uri.hostname + uri.path)
    FileUtils.mkdir_p(dir).first
  end

  def save_image(dir)
    img_name = File.basename(@url)
    file = File.join(dir, img_name)
    img = URI.parse(@url).open
    File.open(file, 'wb') { |f| f.write(img.read) }
    true
  rescue StandardError
    false
  end
end
