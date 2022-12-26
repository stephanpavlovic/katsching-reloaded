class AddSlugToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :slug, :string, index: true
    add_column :groups, :slug, :string, index: true
  end
end
