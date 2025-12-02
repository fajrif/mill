class CreateFeatures < ActiveRecord::Migration[7.1]
  def change
    create_table :features do |t|
      t.string :name, null: false, default: ""
      t.string :caption, null: false, default: ""
      t.string :short_description, null: false, default: ""
      t.string :description, null: false, default: ""
    end
  end
end
