MONIQUELIVE_ID = '4930146'

class User < ApplicationRecord
  has_many :ideas
  has_many :stars

  after_initialize :ensure_session_token

  def self.find_or_create_from_auth_hash(auth)
    where(twitch_id: auth.uid).first_or_initialize.tap do |user|
      user.twitch_id            = auth.uid
      user.twitch_name          = auth.info.name
      user.twitch_avatar        = auth.info.image
      user.twitch_access_token  = auth.credentials.token
      user.twitch_refresh_token = auth.credentials.refresh_token
      user.save!
      return user if user.twitch_id == MONIQUELIVE_ID

      user_follows_resp = follows_monique_since(user)
      if user_follows_resp.success? && user_follows_resp.data.size == 1
        user.follows_monique_since = user_follows_resp.data.first.followed_at
        user.save!
      end
    end
  end

  def twitch_old_timer?
    twitch_id == MONIQUELIVE_ID ||
      (follows_monique_since? && follows_monique_since <= 1.month.ago)
  end

  def reset_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  private

  def self.follows_monique_since(user)
    twitch_client = Twitch::Client.new(
      client_id:     ENV["TWITCH_CLIENT_ID"],
      client_secret: ENV["TWITCH_CLIENT_SECRET"],
      access_token:  user.twitch_access_token,
      refresh_token: user.twitch_refresh_token,
    )
    twitch_client.get_users_follows(
      from_id: user.twitch_id,
      to_id:   MONIQUELIVE_ID)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end
end
