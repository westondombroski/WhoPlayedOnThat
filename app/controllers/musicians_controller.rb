class MusiciansController < ApplicationController
  def show
    participant_id = params[:id]
    response = Musician.get_track_by_participant_id(participant_id)
    @musicians = response['Results']
  end
end
