keys = Rails.application.secrets

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, keys.['spotify_client_id'], keys.['spotify_client_secret'], scope: 'playlist-read-private user-read-private user-read-email'
end
