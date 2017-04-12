class MusiciansController < ApplicationController
  def show
    breadcrumbs.add 'Tracks', tracks_path_url
    breadcrumbs.add 'Track', track_show_path_url
    breadcrumbs.add 'Musician', musician_path_url
    participant_id = params[:id]
    response = Musician.get_track_by_participant_id(participant_id)
    @musicians = response['Results']
  end

  def create
  end
end
