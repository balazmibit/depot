class CombineItemsInCart < ActiveRecord::Migration
  def change
  end
  
  def self.up
    #nahrad viac poloziek pre jediny produkt v kosiku jedinou polozkou
    Cart.all.each do |cart|
      #spocitaj pocet kazdeho z produktov v kosiku
      sums = cart.line_items.group(:product_id).sum(:quantity)
      
      sums.each do |product_id, quantity|
        if quantity > 1
          #odober samostatne polozky
          cart.line_items.group(:product_id => product_id).delete_all
          
          #nahradi ich jedinou polozkou
          cart.line_item.create(:product_id => product_id, :quantity => quantity)
        end
      end
    end
   end
   
   def self.down
     #rozdel polozky s mnozstvom > 1 na viac samostatnych poloziek
     LineItem.where("quantity > 1").each do |line_item|
       # pridaj samostatne polozky
       line_item.quantity.times do
         LineItem.create  :cart_id => line_item.cart_id,
                          :product_id => line_item.product_id, :quantity => 1
       end
       
       # odober povodnu polozku
       line_item.destroy
     end
   end
end 