class Admin::ProductsController < AdminController

  def index
    @products = Product.includes(:photos, :category).all
  end

  def new
    @product = Product.new
    @photo = @product.photos.build #for multi-pics
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def create
    @product = Product.new(product_params)
    @product.category_id = params[:category_id]
    if @product.save!
      if params[:photos] != nil
        params[:photos]['avatar'].each do |a|
          @photo = @product.photoss.create(:avatar => a)
        end
      end
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def update
    @product = Product.find(params[:id])
    @product.category_id = params[:category_id]
    if params[:photos] != nil
     @product.photos.destroy_all #need to destroy old pics first


     params[:photos]['avatar'].each do |a|
       @picture = @product.photos.create(:avatar => a)
     end

     @product.update(product_params)
     redirect_to admin_products_path

    elsif @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :image)
  end
end
