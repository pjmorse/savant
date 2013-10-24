require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => ':memory:'
)

ActiveRecord::Base.silence do
  ActiveRecord::Migration.verbose = false

  ActiveRecord::Schema.define do
    create_table "albums", :force => true do |t|
      t.string   "name"
      t.integer  "artist_id"
      t.date     "released_on"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
      t.decimal  "cost"
    end

    create_table "artists", :force => true do |t|
      t.text     "name"
      t.boolean  "deceased"
      t.datetime "created_at",  :null => false
      t.datetime "updated_at",  :null => false
    end

    create_table "songs", :force => true do |t|
      t.string   "name"
      t.float    "duration_in_seconds"
      t.integer  "album_id"
      t.datetime "created_at",  :null => false
      t.datetime "updated_at",  :null => false
    end
  end
end
