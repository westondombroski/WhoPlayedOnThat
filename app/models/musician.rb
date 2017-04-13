class Musician < ApplicationRecord
  include HTTParty

  #get a musician's tracks by participants id (via click on participant name) - Quantone API (musicians#show)
  def self.get_tracks_by_participant_id(participant_id)
    base_uri "https://data.quantonemusic.com/v3/recordings"
    format :json
    get("", query: { participantIds: participant_id, depth: 'Identifiers' }, headers: { 'appid' => ENV["QUANTONE_APP_ID"], 'appkey' => ENV["QUANTONE_APP_KEY"] })
  end

  #get  tracks by ids to populate playlist - Spotify API (musician#show)
  def self.post_playlist_by_tracks_ids track_ids
    base_uri "https://api.spotify.com/v1/search"
    format :json
  end

  #collecting the spotify_ids from the Quantone results in order to populate playlist page
  def self.collect_and_return_tracks_by_spotify_ids tracks
    spotify_ids = []
    tracks.each do |track|
      all_the_ids = track['Identifiers']
      all_the_ids.each do |id|
        if id['AdditionalInformation'] && id['IdentifierType'] == 'Spotify'
          then spotify_ids << id['Value'][14..-1]
        end
      end
    end
    return spotify_ids
  end

  #get multiple tracks by spotify ids
  def self.get_tracks_by_spotify_ids spotify_ids
    base_uri "https://api.spotify.com/v1/tracks"
    format :json
    get("/", query: { id: spotify_ids }, headers: { 'client_id' => ENV["SPOTIFY_CLIENT_ID"], 'client_secret' => ENV["SPOTIFY_CLIENT_SECRET"] })
  end


end
