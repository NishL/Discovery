class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @products = Product.all
    respond_with(@products)
  end

  def show
    respond_with(@product)
  end

  def new
    @product = current_user.products.build    
  end

  def edit
  end

  def create
    @product = current_user.products.build(product_params)
     if @product.save
      redirect_to @product, notice: "Product was added successfully."
    else
      render action: "new"
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Product was successfully updated."
    else 
      render action: "edit"
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url
  end

  private
    def set_product
      @product = Product.find(params[:id])
      redirect_to products_path, notice: "Not authorized to edit this product" if @pin.nil?
    end

    #Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:description, image:)
    end
end
