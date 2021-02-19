# frozen_string_literal: true

require 'open-uri'

class ImageUrlValidator
  ALLOWED_EXTENSIONS = %w[jpg jpeg].freeze

  def self.call(url)
    new(url).call
  end

  attr_reader :url

  def initialize(url)
    @url = url
  end

  def call
    valid_url? && valid_image_url? && accessible_url?
  end

  private

  def valid_url?
    (@url =~ URI::DEFAULT_PARSER.make_regexp(%w[http https])) != nil
  end

  def valid_image_url?
    ALLOWED_EXTENSIONS.any? { |ext| @url.end_with? ext }
  end

  def accessible_url?
    URI.parse(@url).open.status.first == '200'
  rescue StandardError
    false
  end
end
