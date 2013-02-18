class Artist < ActiveRecord::Base
  attr_accessible :name
  has_many :albums
  has_many :songs, through: :albums
end

class Album < ActiveRecord::Base
  attr_accessible :artist_id, :name, :released_on
  belongs_to :artist
  has_many :songs
end

class Song < ActiveRecord::Base
  attr_accessible :album_id, :duration_in_seconds, :name
  belongs_to :album
end
