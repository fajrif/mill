class CreateProductOpenings < ActiveRecord::Migration[7.1]
  def change
    create_table :product_openings do |t|
      t.references :product, null: false, foreign_key: true
      t.string :title, null: false

      t.timestamps
    end
  end
end
