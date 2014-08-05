class StoreController < ApplicationController
  def index
    # poziadame model Product o vypisanie vsetkym poloziek
    @products = Product.all
  end
end
