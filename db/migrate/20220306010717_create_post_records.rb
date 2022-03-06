class CreatePostRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :post_records do |t|
      t.integer :post_id
      t.time :time
      t.float :distance_km
      t.integer :distance_m
      t.integer :type
      t.integer :number
      t.integer :time_hour
      t.integer :time_minute
      t.integer :time_second
      t.integer :pace_minute
      t.integer :pace_second
      t.integer :pace_undersecond

      t.timestamps
    end
  end
end
