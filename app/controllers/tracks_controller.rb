class TracksController < ApplicationController

  #takes search term from the form and submits to spotify api
  def index
    @query = params[:q]
    response = Track.get_tracks_by_name(@query)
    @tracks = response['tracks']['items']
  end

  #takes spotify_id of track clicked on tracks#index page and submits to quantone api
  def show
    breadcrumbs.add 'tracks', tracks_path_url
    response = Track.get_track_musicians_by_track_id(params[:id])
    if response['Results'][0]
      @track = response['Results'][0]['Participations']
    else
      @track = nil
    end
  end
end
