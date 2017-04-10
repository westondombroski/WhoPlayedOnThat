require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all)do
    @user = User.new(uid:"spotify_id", nickname:"bobify", image:"image_url", url:"spotify_url")
  end

  it "should have matching uid" do
    expect(@user.uid).to eq("spotify_id")
  end

  it "should have matching nickname" do
    expect(@user.nickname).to eq("bobify")
  end

  it "should have matching image" do
    expect(@user.image).to eq("image_url")
  end

  it "should have matching url" do
    expect(@user.url).to eq("spotify_url")
  end
end
