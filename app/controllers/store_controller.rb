class StoreController < ApplicationController

  skip_before_filter :authorize

  def index
    if params[:set_locale]
      redirect_to store_path(:locale => params[:set_locale])
    else 
      @products = Product.all
      @cart     = current_cart
    end

    #  Count number of times user hits store#index,
    #  for "Playtime"
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] = session[:counter] + 1
  end

end
