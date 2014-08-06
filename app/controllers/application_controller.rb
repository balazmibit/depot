class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery
  
  private
  
    # metoda current_cart zacina tak ze s objektu session berie hodnotu ulozenu pod klucom :cart_id ,
    # pred tym ako sa pokusi vyhladat kosik odpovedajuci tomuto identifikacnemu cislu. 
    # Ak nie je prislusny kosik najdeny , potom tato metoda pokracuje vytvorenim noveho objektu typu Cart a jeho 
    # identifikacne cislo ulozi v session a potom novy kosik vrati.
    def current_cart
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
end
