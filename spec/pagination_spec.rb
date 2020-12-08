require 'spec_helper'
require 'byebug'

describe Oktakit do
  PAGED_APPS_APP_ID = '0oaYAubtaubhslaOg0x7'

  it 'should auto paginate' do
    VCR.use_cassette('pagination') do
      users, = client.list_users(paginate: true)
      expect(users.size).to(be == 10)
    end
  end

  it 'should send query parameters in each page request' do
    VCR.use_cassette('pagination_with_query_params') do
      users, = client.list_users_assigned_to_application(PAGED_APPS_APP_ID,
                                                         paginate: true, query: { expand: 'user', limit: '1' })
      users.each do |user|
        expect(user._embedded).not_to(be_nil, "User #{user.id} was expected to have expanded user profile in _embedded")
      end

      expect(users.size).to(be == 3)
    end
  end
end
