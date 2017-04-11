class Track < ApplicationRecord
  include HTTParty

  base_uri "https://api.spotify.com/v1/"
  default_params client_id: ENV["SPOTIFY_CLIENT_ID"], client_secret: ENV["SPOTIFY_CLIENT_SECRET"]
  format :json

  def self.get_tracks_by_name name
      get("search", query: { q: name, type: "tracks, artists, albums" })["tracks"]
  end

  def self.get_tracks_by_ids (track_ids)
    get("")
  end
end
