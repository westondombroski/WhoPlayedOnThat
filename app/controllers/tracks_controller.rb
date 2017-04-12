class TracksController < ApplicationController

#takes search term from the form and submits to spotify api
  def search
    @search_term = params[:q]
    @tracks = Track.get_tracks_by_name(@search_term)
  end

  def index
    query = params[:q]
    response = HTTParty.get("https://api.spotify.com/v1/search?q=#{query}&type=track")
    @tracks = response['tracks']['items']
  end

#takes spotify_id of track clicked on tracks#index page and submits to quantone api
  def show
    track_id = params[:id]
    response = Track.get_track_musicians_by_track_id(track_id)
    @track = response['Results'][0]['Participations']
  end
end
