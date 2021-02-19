require 'spec_helper'
require 'url_file_reader'

RSpec.describe UrlFileReader do
  let(:filename) { 'spec/fixtures/links.txt' }

  subject { described_class.call(filename) }

  describe '.call' do
    let(:expected_result) do
      [
        "https://pbs.twimg.com/profile_images/868551323582595072/wlBZo5yL_400x400.jpg",
        "https://dpat.in/asset/images/me.jpg",
        "ololo",
        "http://kak.ya.kushayu/oh.exe",
        "https://lingvoforum.net/avs/avatar_39053_1383408399.jpeg"
      ]
    end

    it 'parses file contents to array' do
      expect(subject).to match_array expected_result
    end
  end

  context 'when file is not found' do
    let(:filename) { 'spec/fixtures/not_exists.txt' }

    it 'raises an error' do
      expect { subject }.to raise_error(UrlFileReader::AbsentFileError)
    end
  end

  context 'when file is empty' do
    let(:filename) { 'spec/fixtures/empty.txt' }

    it 'raises an error' do
      expect { subject }.to raise_error(UrlFileReader::EmptyFileError)
    end
  end
end
