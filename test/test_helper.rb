ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"
require "minitest/autorun"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  OmniAuth.config.test_mode          = true
  OmniAuth.config.mock_auth[:twitch] = OpenStruct.new(
    provider:    'twitch',
    uid:         '1',
    info:        OpenStruct.new(
      name:  'mockuser',
      image: 'mock_user_thumbnail_url'
    ),
    credentials: OpenStruct.new(
      token:         'mock_token',
      refresh_token: 'mock_refresh_token',
      secret:        'mock_secret'
    )
  )

  def create_twitch_user(since)
    User.create!(twitch_id: '1', follows_monique_since: since)
  end

  def create_idea
    Idea.create!(user: create_twitch_user(1.month.ago))
  end
end
