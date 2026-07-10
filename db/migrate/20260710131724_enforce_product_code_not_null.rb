class EnforceProductCodeNotNull < ActiveRecord::Migration[7.1]
  def up
    Product.where(code: nil).find_each do |product|
      product.update_column(:code, "PRD-#{product.id}")
    end

    change_column_null :products, :code, false
  end

  def down
    change_column_null :products, :code, true
  end
end
