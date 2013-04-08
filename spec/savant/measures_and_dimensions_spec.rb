require 'spec_helper'

describe "measure and dimension enumeration and metadata" do
  it "enumerates its measures" do
    fact = Class.new(::Savant::FactTable) do
      measures do
        integer(:song_count) { count(song_id) }
        integer(:album_count) { count distinct album_id }
      end
    end

    fact.measures.map(&:name).should =~ [:song_count, :album_count]
  end

  it "enumerates its dimensions" do
    fact = Class.new(::Savant::FactTable) do
      dimensions do
        integer(:song_id) { songs.id }
        integer(:album_id) { albums.id }
      end
    end

    fact.dimensions.map(&:name).should =~ [:song_id, :album_id]
  end


  it "has descriptions associated with its measures" do
    fact = Class.new(::Savant::FactTable) do
      measures do
        integer(:song_count, "Song Count") { count(song_id) }
        integer(:album_count, "Album Count") { count distinct album_id }
      end
    end

    fact.measures.map(&:description).should =~ ["Song Count", "Album Count"]
  end

  it "has descriptions associated with its dimensions" do
    fact = Class.new(::Savant::FactTable) do
      dimensions do
        integer(:song_id, "Song ID") { songs.id }
        integer(:album_id, "Album ID") { albums.id }
      end
    end

    fact.dimensions.map(&:description).should =~ ["Song ID", "Album ID"]
  end
end
