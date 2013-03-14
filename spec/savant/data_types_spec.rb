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
        float(:song_duration)        { songs.duration }
        boolean(:artist_deceased)    { artists.deceased }
        date(:album_released_on)     { albums.released_on }
        datetime(:artist_created_at) { artist.created_at }
        #time(:artist_
      end

    end
  end

  it "returns strings" do
    pending
  end

  it "returns integers" do
    pending
  end

  it "returns floats" do
    pending
  end

  it "returns booleans" do
    pending
  end

  it "returns times" do
    pending
  end

  it "returns dates" do
    pending
  end

  it "returns datetimes" do
    pending
  end

end
