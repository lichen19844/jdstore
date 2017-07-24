class FavoritesController < ApplicationController

  def index
    @products = current_user.favorite_products.includes(:photos, :members)
  end

end
