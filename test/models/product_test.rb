require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
   test "TEST - Polia produktu nemozu byt prazdne" do
     product = Product.new
     assert product.invalid?
     assert product.errors[:title].any?
     assert product.errors[:description].any?
     assert product.errors[:price].any?
     assert product.errors[:image_url].any?
   end
   
   test "Cena tovaru musi byt zadana a kladna" do
     product = Product.new( :title        => "Nazov testovacej knihy",
                            :description  => "popis testovacej knihy",
                            :image_url    => "test.jpg")
     product.price = -12
     assert product.invalid?
     #assert_equal "cena musi byt vacsia alebo rovna ako 0.01",
     #             product.errors[:price].join(': ')
     
     product.price = 0
     assert product.invalid?
     #assert_equal "cena musi byt vacsia alebo rovna ako 0.01",
     #             product.errors[:price].join(': ')
                  
     product.price = 1
     assert product.valid?
   end
   
   def new_product(image_url)
     Product.new( :title => "testovaci nazov knihy",
                  :description => "testovaci popis knihy",
                  :price => 1,
                  :image_url => image_url )
   end
   
   test "image url" do
     ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
              http://a.b.c/x/y/z/fred.gif }
     bad = %w{ fred.doc fred.gif/more fred.gif.more }
     
     ok.each do |name|
       assert new_product(name).valid?, "#{name} by nemalo byt neplatne"
     end
     
     bad.each do |name|
       assert new_product(name).invalid?, "#{name} by namelo byt platne"
     end
   end
   
   test "testovanie jedinecnoti na pole title" do
     product = Product.new( :title => products(:ruby).title,
                            :description => "yyyy",
                            :price => 1,
                            :image_url => "fred.gif")
     assert !product.save
     assert_equal "has already been taken", product.errors[:title].join(';')
   end
end
