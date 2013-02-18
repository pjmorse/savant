require 'spec_helper'

describe "basic aggregation" do
  before do

    class ArtistFact < ::Savant::FactTable
      data_source :artist_facts do
        Artist.joins {
          [ albums.songs, albums ]
        }
      end

      dimensions do
        integer(:year) { albums.year }
        integer(:song_id) { songs.id }
        integer(:album_id) { albums.id }

        integer(:album_name) { albums.name }
        string(:artist_name) { artists.name }
      end

      measures do
        integer(:song_count) { count(song_id) }
        integer(:album_count) { count distinct album_id }
      end
    end

  end

  it "counts songs by an artist" do
    artist = Artist.create(name: 'Johnny Cash')
    album = Album.create(name: 'Classic Cash', artist_id: artist.id)

    Song.create(name: 'Walk The Line', album_id: album.id)
    Song.create(name: 'Ring Of Fire', album_id: album.id)

    artist_fact = ArtistFact.grouped_by(:artist_name, :album_name)
    artist_fact.length.should == 1
  end
end
