require 'spec_helper'

describe Oktakit::Client::SystemLog do
  describe '#list_logs' do
    it 'returns array of logs' do
      VCR.use_cassette 'list_logs' do
        resp, = client.list_logs
        expect(resp).to be_a(Array)
      end
    end
  end
end
