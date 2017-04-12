class Musician < ApplicationRecord
  include HTTParty

  #get a musician's tracks by participants id (via click on participant name) - Quantone API (musicians#show)
  def self.get_track_by_participant_id(participant_id)
    base_uri "https://data.quantonemusic.com/v3/recordings"
    format :json
    get("", query: { participantIds: participant_id }, headers: { 'appid' => ENV["QUANTONE_APP_ID"], 'appkey' => ENV["QUANTONE_APP_KEY"] })
  end

  #get  tracks by ids to populate playlist - Spotify API (musician#show)
  def self.post_playlist_by_tracks_ids track_ids
    base_uri "https://api.spotify.com/v1/search"
    format :json
  end
end
