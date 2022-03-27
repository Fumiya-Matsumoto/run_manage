class AddDistanceToPostRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :post_records, :distance, :float
  end
end
