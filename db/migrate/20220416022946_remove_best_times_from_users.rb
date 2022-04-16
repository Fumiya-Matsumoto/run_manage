class RemoveBestTimesFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :time_800, :float
    remove_column :users, :time_1000, :float
    remove_column :users, :time_1500, :float
    remove_column :users, :time_3000, :float
    remove_column :users, :time_5000, :float
    remove_column :users, :time_10000, :float
    remove_column :users, :time_3000sc, :float
    remove_column :users, :time_5km, :float
    remove_column :users, :time_10km, :float
    remove_column :users, :time_half, :float
    remove_column :users, :time_marathon, :float
  end
end
