class AddSingerToSong < ActiveRecord::Migration
  def change
    add_column :songs, :singer, :string
  end
end

