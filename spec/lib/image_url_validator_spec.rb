require 'spec_helper'
require 'image_url_validator'

RSpec.describe ImageUrlValidator do
  let(:url_double) { double }

  before do
    allow(URI).to receive(:parse).with(url).and_return(url_double)
    allow(url_double).to receive_message_chain("open.status") { ['200', 'OK'] }
  end

  subject { described_class.call(url) }

  describe '.call' do
    let(:url) { 'https://example.com/hello.jpg' }

    it 'passes all checks' do
      expect(subject).to be_truthy
    end
  end

  context 'when URL is invalid' do
    let(:url) { 'ftp://example.com/hello.jpg' }

    it 'fails' do
      expect(subject).to be_falsey
    end
  end

  context 'when url isn\'t an image URL' do
    let(:url) { 'https://example.com/hello.txt' }

    it 'fails' do
      expect(subject).to be_falsey
    end
  end

  context 'when URL is inaccessible' do
    let(:url) { 'https://example.com/hello.jpg' }

    before do
      allow(url_double).to receive_message_chain("open.status") { ['404', 'NOT FOUND'] }
    end

    it 'passes all checks' do
      expect(subject).to be_falsey
    end
  end
end
