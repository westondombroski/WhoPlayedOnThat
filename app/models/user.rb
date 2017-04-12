class User < ApplicationRecord

  def self.create_with_omniauth(auth)
    create! do |user|
      user.uid = auth.uid
      user.nickname = auth.info.name
      user.image = auth.info.image
      user.url = auth.info.urls['spotify']
      user.access_token = auth.credentials.token
      user.refresh_token = auth.credentials.refresh_token
    end
  end

end
