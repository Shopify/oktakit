require 'oktakit/version'
require 'oktakit/client'

module Oktakit
  def self.new(**args)
    Client.new(**args)
  end
end
