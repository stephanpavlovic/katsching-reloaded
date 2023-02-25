class AddExistingUsersToRepetitions < ActiveRecord::Migration[7.0]
  def change
    Repetition.all.each do |repetition|
      repetition.update(user: repetition.original_transaction.user)
    end
  end
end
