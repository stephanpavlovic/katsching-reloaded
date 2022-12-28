class AddSharedFlagToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :shared, :boolean, default: false
  end
end
