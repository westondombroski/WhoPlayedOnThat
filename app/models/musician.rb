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
  def self.collect_and_return_tracks_spotify_ids tracks
    spotify_ids = []
    spotify_uris = []
    tracks.each do |track|
      all_the_ids = track['Identifiers']
      all_the_ids.each do |id|
        if id['AdditionalInformation'] && id['IdentifierType'] == 'Spotify'
          then  spotify_ids << id['Value'][14..-1]
                spotify_uris << id['Value']
        end
      end
    end
    return [spotify_ids, spotify_uris]
  end

  #get multiple tracks by spotify ids
  def self.get_tracks_by_spotify_ids spotify_ids
    base_uri "https://api.spotify.com/v1/tracks"
    format :json
    get("", query: { ids: spotify_ids }, headers: { 'client_id' => ENV["SPOTIFY_CLIENT_ID"], 'client_secret' => ENV["SPOTIFY_CLIENT_SECRET"] })
  end

  #create empty playlist to be filled with tracks
  def self.create_playlist user_id            #hard-coded work-around, wasn't able to successfully grab the user id
    base_uri "https://api.spotify.com/v1/users/#{user_id}/playlists"
    format :json
    post("",  headers: { 'client_id' => ENV["SPOTIFY_CLIENT_ID"], 'client_secret' => ENV["SPOTIFY_CLIENT_SECRET"],
                         'scope' => 'playlist-modify-public playlist-modify-private playlist-read-private user-read-private user-read-email' },
              body: { 'description'=> 'New playlist description', 'name': 'WhoPlayedOnThat2', 'public': false })
  end

  #fill empty playlist with tracks from musician search results
  def self.fill_playlist (spotify_uris, playlist_id, user_id)
    base_uri "https://api.spotify.com/v1/users/#{user_id}/playlists/6pSLtQ0RmtEuLX02USeuLN/tracks"   #yet another hard-coded work-around, this time with the playlist id in
    post("", query: { 'uris' => spotify_uris }, headers: { 'client_id' => ENV["SPOTIFY_CLIENT_ID"], 'client_secret' => ENV["SPOTIFY_CLIENT_SECRET"] })
  end

end
