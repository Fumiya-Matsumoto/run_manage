class AddTimesToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :time, :float
    add_column :posts, :time_s, :float
    add_column :posts, :time_r, :float
  end
end
