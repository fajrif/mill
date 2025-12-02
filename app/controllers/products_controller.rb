class ProductsController < ApplicationController

  def index
		criteria = Product.all
    @products = criteria.page(params[:page]).per(12)

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def show
		@product = Product.friendly.find(params[:id])
		# Other Products
    @products = Product.most_recent_products(@product.id, 2)
  end

end
