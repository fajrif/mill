class Admins::ProductsController < Admins::BaseController
	before_action :set_product, except: [:index, :new, :create]

  def index
		if params[:search].blank?
			criteria = Product.all
		else
      criteria = Product.where("name ILIKE ?", "%#{params[:search]}%")
		end

    @products = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
      format.js
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params_product)
    if @product.save
			redirect_to admins_product_path(@product), :notice => "Successfully created product."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product.update(params_product)
			redirect_to admins_product_path(@product), :notice  => "Successfully updated product."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to admins_products_url, :notice => "Successfully destroyed product."
  end

  private

  def params_product
    params.require(:product).permit(:image, :banner, :name, :short_description, :description, :caption)
  end

  def set_product
    @product = Product.friendly.find(params[:id])
  end
end
