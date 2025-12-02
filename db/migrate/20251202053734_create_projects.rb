class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false, default: ""
      t.string :client_name, null: false, default: ""
      t.string :caption, null: false, default: ""
      t.string :short_description, null: false, default: ""
      t.string :description, null: false, default: ""
      t.timestamps
    end
    add_index :projects, :name, unique: true
  end
end
