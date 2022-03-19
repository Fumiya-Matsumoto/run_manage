class ChangeDataTimeToPostRecords < ActiveRecord::Migration[6.1]
  def change
    change_column :post_records, :time, :float
  end
end
