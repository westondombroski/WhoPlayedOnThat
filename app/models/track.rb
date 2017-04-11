class Track < ApplicationRecord
  include HTTParty


  #get all the tracks from the initial homepage search (via form) - Spotify API (tracks#index)
  def self.get_tracks_by_name track_name
    base_uri "https://api.spotify.com/v1/search"
    default_params client_id: ENV["SPOTIFY_CLIENT_ID"], client_secret: ENV["SPOTIFY_CLIENT_SECRET"]
    format :json
    get("", query: { q: track_name, type: "tracks, artists, albums" })["tracks"]
  end


  #get a track's musicians by track_id (via click on track name) - Quantone API (tracks#show)
  def self.get_track_musicians_by_track_id track_id
    base_uri "https://data.quantonemusic.com/v3/recordings/#{track_id}"
    default_params client_id: ENV["QUANTONE_APP_ID"], client_secret: ENV["QUANTONE_APP_KEY"]
    format :json
    get("", query: { depth: participations })
    # result['participations']['ActivityLiteral']
    # result['participations']['ArtistsLiteral']
  end


  #get a musician's tracks by participants (via click on participant name) - Quantone API (musicians#show)
  def self.get_tracks_by_musician_name musician
    base_uri "https://data.quantonemusic.com/v3/recordings"
    default_params client_id: ENV["QUANTONE_APP_ID"], client_secret: ENV["QUANTONE_APP_KEY"]
    format :json
    get("", query: { participants: musician })
  end


  #get  tracks by ids to populate playlist - Spotify API (musician#show)
  def self.post_playlist_by_tracks_ids [track_ids]
    base_uri "https://api.spotify.com/v1/users/{user_id}/playlists"
    default_params client_id: ENV["SPOTIFY_CLIENT_ID"], client_secret: ENV["SPOTIFY_CLIENT_SECRET"]
    format :json
    post("")
  end
end
