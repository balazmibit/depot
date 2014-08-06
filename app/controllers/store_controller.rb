class StoreController < ApplicationController
  def index
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] += 1
    # poziadame model Product o vypisanie vsetkym poloziek
    @products = Product.all
  end
  
end
