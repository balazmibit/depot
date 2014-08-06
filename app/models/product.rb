class Product < ActiveRecord::Base
    #toto nefunguje podla knizky --- default_scope :order => :title
    default_scope { order(:title => :desc)}
    has_many :line_items
    before_destroy :ensure_not_referenced_by_any_line_item
    validates :title, :description, :image_url, :presence => true
    validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
    validates :title, :uniqueness => true
    validates :image_url, :format => {
      :with => %r{\.(gif|jpg|png)\z}i,
      :message => 'musi ist o adresu GIF, JPG alebo PNG.'
    }
    
    
    private
      
      # uisti sa, ze sa na tento produkt neodkazuju ziadne polozky 
      def ensure_not_referenced_by_any_line_item
        if line_items.empty?
          return true
        else
          errors.add(:base, 'Existuju polozky')
          return false
        end
      end
end
