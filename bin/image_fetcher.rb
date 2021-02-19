#!/usr/bin/env ruby
# frozen_string_literal: true

require '../lib/url_file_reader'
require '../lib/image_url_validator'
require '../lib/image_downloader'

begin
  class NoArgumentError < StandardError; end

  unless (file = ARGV[0])
    raise NoArgumentError
  end

  urls = UrlFileReader.call(file)
  valid_urls, invalid_urls = urls.partition { |url| ImageUrlValidator.call(url) }
  fetched_urls, unfetched_urls = valid_urls.partition do |url|
    ImageDownloader.call(url)
  end

  puts 'Image Fetcher processed URLs as follows:'
  printf("%-20s", 'Downloaded:'); puts fetched_urls.count
  printf("%-20s", 'Invalid:'); puts invalid_urls.count
  printf("%-20s", 'Valid yet failed:'); puts unfetched_urls.count

rescue NoArgumentError
  puts 'File with URLs wan\'t passed as an argument to the script!'
rescue UrlFileReader::AbsentFileError
  puts 'The argument file doesn\'t exist!'
rescue UrlFileReader::EmptyFileError
  puts 'The argument file is empty!'
rescue StandardError => e
  puts "Rescued: #{e.inspect}"

ensure
  puts "\n---\nTest assignment for Getsafe"
end
