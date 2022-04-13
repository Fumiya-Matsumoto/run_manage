class CreateObjectives < ActiveRecord::Migration[6.1]
  def change
    create_table :objectives do |t|
      t.integer :user_id
      t.integer :year
      t.integer :month
      t.string :content
      t.text :todo_content

      t.timestamps
    end
  end
end
