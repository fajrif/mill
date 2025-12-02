class AddMoreSlugToTables < ActiveRecord::Migration[7.1]
  def change
		add_column :products, :slug, :string, null: false
    add_index :products, :slug, unique: true
		add_column :projects, :slug, :string, null: false
    add_index :projects, :slug, unique: true
		add_column :events, :slug, :string, null: false
    add_index :events, :slug, unique: true
  end
end
