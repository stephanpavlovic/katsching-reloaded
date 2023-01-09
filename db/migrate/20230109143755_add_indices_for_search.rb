class AddIndicesForSearch < ActiveRecord::Migration[7.0]
  def change
    add_index :transactions, :name
    add_index :transactions, :category
  end
end
