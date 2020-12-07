require 'spec_helper'

describe Oktakit::Client::Events do
  describe '#list_events' do
    it 'returns array of events' do
      VCR.use_cassette('list_events') do
        resp, = client.list_events
        expect(resp).to(be_a(Array))
      end
    end
  end
end
