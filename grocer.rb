require 'pry'
def consolidate_cart(cart)
  array_of_stuff = []
  shopping_bag = {}
  count = 0 
  cart.each do |item_hash|
    item_hash.each do |item_name, price|
      item_hash[item_name][:count] = 0
      array_of_stuff << item_name
      count = array_of_stuff.count(item_name)
      item_hash[item_name][:count] = count
      
      if !shopping_bag.has_key?(item_name)
        shopping_bag[item_name]={}
      end #end if 
      
      shopping_bag[item_name] = price
      
      if !shopping_bag[item_name][:count]
        shopping_bag[item_name][:count]
      end 
      shopping_bag[item_name][:count] = count
  
    end #end item hash do
    end #end cart do 
    shopping_bag 
end

def apply_coupons(cart, coupons)
    item_name = cart.keys.join 
    info_hash = {}
    cart["#{item_name} W/COUPON"] = {}
    coupons.each do |coupons_hash|
      coupons_hash.each do |key, value|
        if value == item_name
          cart["#{item_name} W/COUPON"][:price] = coupons_hash[:cost]
          cart["#{item_name} W/COUPON"][:clearance] = cart[item_name][:clearance]
          #cart["#{item_name} W/COUPON"][:count] = 0
          #coupon_count = cart[item_name][:count]/coupons_hash[:num]
           if cart[item_name][:count] >= coupons_hash[:num]
            coupon_count = cart[item_name][:count]/coupons_hash[:num]
           cart["#{item_name} W/COUPON"][:count] = coupon_count
           cart[item_name][:count] = cart[item_name][:count] - coupons_hash[:num]*coupon_count
          end 
        end #end if 
      end #end coupons_hash do 
    end #end coupons do 
 cart 
end

def apply_clearance(cart)
  cart.each do |item_name, item_hash|
    if item_hash[:clearance] == true 
      item_hash[:price] = item_hash[:price]-item_hash[:price]*0.2 
    end #end if 
   
  end #end do 
  
end

def checkout(cart, coupons)
if cart.size == 1 
  consolidate_cart(cart)
end 
end
