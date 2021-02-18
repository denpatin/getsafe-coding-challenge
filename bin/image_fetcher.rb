#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'
require 'open-uri'

IMAGE_EXTENSIONS = %w[jpg jpeg].freeze

def valid_url?(url)
  !!(url =~ URI::DEFAULT_PARSER.make_regexp(%w[http https]))
end

def valid_image_url?(url)
  IMAGE_EXTENSIONS.include? File.extname(url)[1..]
end

def resource_by_url(url)
  URI.parse(url).open
rescue StandardError
  nil
end

def accessible_url?(url)
  res = resource_by_url(url)
  return false if res.nil?

  res.status.first == '200'
end

def directory_hierarchy_by(url)
  uri = URI(url)
  dir = File.dirname(uri.hostname + uri.path)
  FileUtils.mkdir_p(dir).first
end

def save_image_from_url(url, dir)
  img = File.basename(url)
  file = File.join(dir, img)
  File.open(file, 'wb') { |f| f.write(resource_by_url(url).read) }
end

unless (file = ARGV[0])
  puts 'No arguments!'
  exit 1
end

unless File.exist?(file)
  puts 'File doesn\'t exist!'
  exit 2
end

if File.zero?(file)
  puts 'Input file is empty!'
  exit 3
end

urls = File.readlines(file).map(&:chomp)
urls.each do |url|
  unless valid_url?(url)
    puts "Invalid URL: #{url}!"
    next
  end

  unless valid_image_url?(url)
    puts "Invalid image URL: #{url}!"
    next
  end

  unless accessible_url?(url)
    puts "Inaccessible URL: #{url}!"
    next
  end

  dir = directory_hierarchy_by(url)
  save_image_from_url(url, dir)
end
