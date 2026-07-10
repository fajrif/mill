class Admins::ProductOpeningsController < Admins::BaseController
  before_action :set_product
  before_action :set_product_opening, only: [:update, :destroy]

  def create
    @opening = @product.product_openings.new(product_opening_params)
    if @opening.save
      redirect_to admins_product_path(@product), :notice => "Successfully created opening."
    else
      redirect_to admins_product_path(@product), :alert => @opening.errors.full_messages.to_sentence
    end
  end

  def update
    if @opening.update(product_opening_params)
      redirect_to admins_product_path(@product), :notice => "Successfully updated opening."
    else
      redirect_to admins_product_path(@product), :alert => @opening.errors.full_messages.to_sentence
    end
  end

  def destroy
    @opening.destroy
    redirect_to admins_product_path(@product), :notice => "Successfully destroyed opening."
  end

  private

  def set_product
    @product = Product.friendly.find(params[:product_id])
  end

  def set_product_opening
    @opening = @product.product_openings.find(params[:id])
  end

  def product_opening_params
    params.require(:product_opening).permit(:title, :description)
  end
end
