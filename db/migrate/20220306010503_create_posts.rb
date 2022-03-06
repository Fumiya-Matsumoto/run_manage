class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :content
      t.string :practice_timezone
      t.string :weather
      t.string :place
      t.string :kind_of_practice
      t.string :strength
      t.integer :user_id
      t.date :practice_day
      t.integer :practice_day_year
      t.integer :practice_day_month
      t.integer :practice_day_day
      t.string :practice_day_of_week

      t.timestamps
    end
  end
end
