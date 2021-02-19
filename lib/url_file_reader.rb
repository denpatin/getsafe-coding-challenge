# frozen_string_literal: true

class UrlFileReader
  class AbsentFileError < StandardError; end

  class EmptyFileError < StandardError; end

  def self.call(filename)
    new(filename).call
  end

  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def call
    raise AbsentFileError unless File.exist?(filename)
    raise EmptyFileError if File.zero?(filename)

    parse_file_to_array
  end

  private

  def parse_file_to_array
    File.readlines(filename).map(&:chomp)
  end
end
