class AddBestTimesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :time_800, :float
    add_column :users, :time_1000, :float
    add_column :users, :time_1500, :float
    add_column :users, :time_3000, :float
    add_column :users, :time_5000, :float
    add_column :users, :time_10000, :float
    add_column :users, :time_3000sc, :float
    add_column :users, :time_5km, :float
    add_column :users, :time_10km, :float
    add_column :users, :time_half, :float
    add_column :users, :time_marathon, :float
  end
end
