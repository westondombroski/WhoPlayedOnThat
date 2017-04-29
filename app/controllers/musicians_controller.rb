class MusiciansController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    response = Musician.get_tracks_by_participant_id(params[:id])             #get all the musicians tracks from Quantone
    tracks = response['Results'][0...15]
    spotify_tracks = Musician.collect_and_return_tracks_spotify_ids(tracks)   #iterate throught them to grab Spotify id's
    @spots_ids = spotify_tracks[0][0...50].join(",")                          #spotify_ids for GET tracks
    @@spots_uris = spotify_tracks[1].join(",")                                #spotify_uris for POST tracks to playlist
    musician_tracks = Musician.get_tracks_by_spotify_ids(@spots_ids)          #then grab tracks from spotify  this is the part that I can't get to work!!!
    @musician_tracks = musician_tracks['tracks']
  end

  def create
     if session[:uid] == nil                                                  #no user, no playlist
       redirect_to :back, alert: "Whoa! You gotta login to Spotify first!"
     else
       playlist = Musician.create_playlist('1299547338')                     #create empty playlist
       Musician.fill_playlist(@@spots_uris, playlist['id'], playlist['owner']['id'])                                   #fill empty playlist with tracks from musician show page
       redirect_to :back, alert: "Playlist Created!"
     end
  end
end
