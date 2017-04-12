class Track < ApplicationRecord
  include HTTParty


  #get all the tracks from the initial homepage search (via form) - Spotify API (tracks#index)
  def self.get_tracks_by_name track_name
    base_uri "https://api.spotify.com/v1/search"
    format :json
    get("", query: { q: track_name, type: "tracks, artists, albums" }, headers: { 'client_id' => ENV["SPOTIFY_CLIENT_ID"], 'client_secret' => ENV["SPOTIFY_CLIENT_SECRET"] })["tracks"]
  end


  #get a track's musicians by track_id (via click on track name) - Quantone API (tracks#show)
  def self.get_track_musicians_by_track_id track_id
    base_uri "https://data.quantonemusic.com/v3/recordings"
    format :json
    get("", query: { idType: 'Spotify', id: track_id, depth: 'participations' }, headers: { 'appid' => ENV["QUANTONE_APP_ID"], 'appkey' => ENV["QUANTONE_APP_KEY"] })
  end

  #get  tracks by ids to populate playlist - Spotify API (musician#show)
  def self.post_playlist_by_tracks_ids track_ids
    base_uri "https://api.spotify.com/v1/search"
    format :json
  end
end
