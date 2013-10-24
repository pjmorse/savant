require 'spec_helper'

describe "data type coercion" do
  before do
    class TypeFact < ::Savant::FactTable
      data_source :type_facts do
        Artist.joins {
          [ albums.songs, albums ]
        }
      end

      dimensions do
        string(:artist_name)         { artists.name }
        integer(:artist_id)          { artists.id }
        float(:song_duration)        { songs.duration_in_seconds }
        boolean(:artist_deceased)    { artists.deceased }
        date(:album_released_on)     { albums.released_on }
        datetime(:artist_created_at) { artists.created_at }
        decimal(:album_cost)         { albums.cost }
      end

      measures do
        string(:measure_artist_name)         { artist_name }
        integer(:measure_artist_id)          { artist_id }
        float(:measure_song_duration)        { song_duration }
        boolean(:measure_artist_deceased)    { artist_deceased }
        date(:measure_album_released_on)     { album_released_on }
        datetime(:measure_artist_created_at) { artist_created_at }
        decimal(:measure_album_cost)         { album_cost }
      end
    end

    @artist = Artist.create(name: 'Johnny Cash', deceased: true)
    @album = Album.create(name: 'Classic Cash', artist_id: @artist.id, released_on: Date.yesterday, cost: 3.22)
    @song = Song.create(name: 'Walk The Line', album_id: @album.id, duration_in_seconds: 320.3)
  end

  it "returns strings" do
    TypeFact.grouped_by(:artist_name).first.measure_artist_name.should be_a String
  end

  it "returns integers" do
    TypeFact.grouped_by(:artist_id).first.measure_artist_id.should be_a Integer
  end

  it "returns floats" do
    TypeFact.grouped_by(:song_duration).first.measure_song_duration.should be_a Float
  end

  it "returns booleans" do
    TypeFact.grouped_by(:artist_deceased).first.measure_artist_deceased.should == true
  end

  it "returns dates" do
    TypeFact.grouped_by(:album_released_on).first.measure_album_released_on.should be_a Date
  end

  it "returns datetimes" do
    TypeFact.grouped_by(:artist_created_at).first.measure_artist_created_at.should be_a Time
  end

  it "returns decimals" do
    TypeFact.grouped_by(:album_cost).first.measure_album_cost.should be_a BigDecimal
  end

end
