class StoreController < ApplicationController

  def index
    @products = Product.all

    #  Count number of times user hits store#index,
    #  for "Playtime"
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] = session[:counter] + 1
  end

end
