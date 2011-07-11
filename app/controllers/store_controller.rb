class StoreController < ApplicationController

  skip_before_filter :authorize

  def index
    @products = Product.all
    @cart     = current_cart

    #  Count number of times user hits store#index,
    #  for "Playtime"
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] = session[:counter] + 1
  end

end
