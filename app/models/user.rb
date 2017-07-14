class User < ApplicationRecord
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.id).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oath_token = auth.credentials.token
      user.oath_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
