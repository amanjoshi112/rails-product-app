class ProductsController < ApplicationController
  def index
    @products=Product.all 
      #Product.paginate(:page => params[:page], :per_page=>5)
  end

  def show
    @product = Product.find(params[:id])
  end
end
