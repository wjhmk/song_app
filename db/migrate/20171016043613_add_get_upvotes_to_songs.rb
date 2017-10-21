class AddGetUpvotesToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :get_upvotes, :integer
  end
end
