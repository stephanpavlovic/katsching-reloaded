class AddUserToRepetition < ActiveRecord::Migration[7.0]
  def change
    add_reference :repetitions, :user, null: true, foreign_key: true
  end
end
