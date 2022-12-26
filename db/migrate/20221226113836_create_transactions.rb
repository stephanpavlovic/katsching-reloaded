class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.boolean :incoming, default: true
      t.integer :amount_cents
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
