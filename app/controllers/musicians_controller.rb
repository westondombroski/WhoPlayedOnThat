class MusiciansController < ApplicationController
  def show
    breadcrumbs.add 'track', track_show_path_url
    response = Musician.get_tracks_by_participant_id(params[:id])
    tracks = response['Results'][0...3]
    s_tracks = Musician.collect_and_return_tracks_by_spotify_ids(tracks)
    spots_ids = s_tracks.join(",")
    @musician_tracks = Musician.get_tracks_by_spotify_ids(spots_ids)
  end

  def create

  end
end
