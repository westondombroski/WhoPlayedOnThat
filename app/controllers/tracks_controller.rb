class TracksController < ApplicationController

#takes search term from the form and submits to spotify api
  def search
    @search_term = params[:q]
    @tracks = Track.get_tracks_by_name(@search_term)
  end

  def index
    @tracks = Track.get_tracks_by_name(@search_term)
  end

#takes spotify_id of track clicked on tracks#index page and submits to quantone api
  def show

  end
end
