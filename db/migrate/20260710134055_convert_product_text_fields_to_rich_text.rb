class ConvertProductTextFieldsToRichText < ActiveRecord::Migration[7.1]
  class MigrationProduct < ActiveRecord::Base
    self.table_name = "products"

    def self.polymorphic_name
      "Product"
    end

    has_rich_text :short_description
    has_rich_text :description
  end

  def up
    rename_column :products, :short_description, :short_description_legacy
    rename_column :products, :description, :description_legacy

    MigrationProduct.reset_column_information
    MigrationProduct.find_each do |product|
      product.short_description = product.short_description_legacy
      product.description = product.description_legacy
      product.save!(validate: false)
    end

    remove_column :products, :short_description_legacy
    remove_column :products, :description_legacy
  end

  def down
    add_column :products, :short_description_legacy, :string, default: "", null: false
    add_column :products, :description_legacy, :string, default: "", null: false

    MigrationProduct.reset_column_information
    MigrationProduct.find_each do |product|
      product.update_column(:short_description_legacy, product.short_description.to_plain_text)
      product.update_column(:description_legacy, product.description.to_plain_text)
    end

    rename_column :products, :short_description_legacy, :short_description
    rename_column :products, :description_legacy, :description
  end
end
