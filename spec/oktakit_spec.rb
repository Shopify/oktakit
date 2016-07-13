require 'spec_helper'

describe Oktakit do
  it 'has a version number' do
    expect(Oktakit::VERSION).not_to be nil
  end

  describe 'errors' do
    it 'raises a Oktakit::NotFound on 404 responses' do
      VCR.use_cassette '404' do
        expect { client.get('/users/-1') }.to raise_error(Oktakit::NotFound)
      end
    end
  end
end
