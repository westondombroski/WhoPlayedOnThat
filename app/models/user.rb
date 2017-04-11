class User < ApplicationRecord

  def self.create_with_omniauth(auth)
    create! do |user|
      user.uid = auth.id
      user.nickname = auth.display_name
      user.image = auth.images.url
      user.url = auth.external_urls.spotify
      user.access_token = auth.credentials.token
      user.refresh_token = auth.credentials.refresh_token
    end
  end
end
