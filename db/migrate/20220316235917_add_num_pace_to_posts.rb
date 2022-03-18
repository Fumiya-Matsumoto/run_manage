class AddNumPaceToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :num, :integer
    add_column :posts, :num_s, :integer
    add_column :posts, :num_r, :integer
    add_column :posts, :pace, :float
    add_column :posts, :pace_s, :float
    add_column :posts, :pace_r, :float
  end
end
