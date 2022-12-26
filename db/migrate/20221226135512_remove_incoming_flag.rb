class RemoveIncomingFlag < ActiveRecord::Migration[7.0]
  def change
    remove_column :transactions, :incoming, :boolean
    add_column :transactions, :date, :date
    add_column :transactions, :name, :string
    add_column :transactions, :category, :string
  end
end
