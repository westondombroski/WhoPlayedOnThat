class TracksController < ApplicationController
  def index
    @search_term = params[:q]
    @tracks = Track.get_tracks_by_name(@search_term)
  end
end
