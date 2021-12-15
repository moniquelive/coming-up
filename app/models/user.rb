class User < ApplicationRecord
  has_many :ideas
  has_many :stars

  after_initialize :ensure_session_token

  def self.find_or_create_from_auth_hash(auth)
    where(twitch_id: auth.uid).first_or_initialize.tap do |user|
      user.twitch_id = auth.uid
      user.twitch_name = auth.info.name
      user.twitch_avatar = auth.info.image
      user.twitch_access_token = auth.credentials.token
      user.twitch_refresh_token = auth.credentials.refresh_token
      user.save!
    end
  end

  def reset_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end
end
