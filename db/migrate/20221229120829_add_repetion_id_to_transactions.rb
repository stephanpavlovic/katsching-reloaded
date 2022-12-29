class AddRepetionIdToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :repetition_id, :bigint, index: true
  end
end
