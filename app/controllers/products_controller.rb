class ProductsController < ApplicationController

  def index
		@products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def show
		@product = Product.friendly.find(params[:id])
		# Other Products
    @products = Product.most_recent_products(@product.id, 3)
  end

end
