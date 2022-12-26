class CreateRepetitions < ActiveRecord::Migration[7.0]
  def change
    create_table :repetitions do |t|
      t.string :timing
      t.boolean :active, default: true
      t.datetime :next_iteration

      t.timestamps
    end
  end
end
