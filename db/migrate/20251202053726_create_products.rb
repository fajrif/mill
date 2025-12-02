class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name, null: false, default: ""
      t.string :caption, null: false, default: ""
      t.string :short_description, null: false, default: ""
      t.string :description, null: false, default: ""
      t.timestamps
    end
    add_index :products, :name, unique: true
  end
end
