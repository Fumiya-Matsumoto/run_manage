class AddPaceToPostRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :post_records, :pace, :float
  end
end
