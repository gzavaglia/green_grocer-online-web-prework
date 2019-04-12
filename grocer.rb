require 'pry'
def consolidate_cart(cart)
  hash = {}
  cart.each do |item_hash|
    item_hash.each do |name, price_hash|
      if hash[name].nil?
        hash[name] = price_hash.merge({:count => 1})
      else
        hash[name][:count] += 1
      end
    end
  end
  hash
end

def apply_coupons(cart, coupons)
  hash = cart
  coupons.each do |coupon_hash|
    # add coupon to cart
    item = coupon_hash[:item]

    if !hash[item].nil? && hash[item][:count] >= coupon_hash[:num]
      temp = {"#{item} W/COUPON" => {
        :price => coupon_hash[:cost],
        :clearance => hash[item][:clearance],
        :count => 1
        }
      }
      
      if hash["#{item} W/COUPON"].nil?
        hash.merge!(temp)
      else
        hash["#{item} W/COUPON"][:count] += 1
        #hash["#{item} W/COUPON"][:price] += coupon_hash[:cost]
      end
      
      hash[item][:count] -= coupon_hash[:num]
    end
  end
  hash
end

def apply_clearance(cart)
  cart.each do |item, price_hash|
    if price_hash[:clearance] == true
      price_hash[:price] = (price_hash[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(items, coupons)
  cart = consolidate_cart(items)
  cart1 = apply_coupons(cart, coupons)
  cart2 = apply_clearance(cart1)
  
  total = 0
  
  cart2.each do |name, price_hash|
    total += price_hash[:price] * price_hash[:count]
  end
  
  total > 100 ? total * 0.9 : total
  
end



# def consolidate_cart(cart)
#   array_of_stuff = []
#   shopping_bag = {}
#   count = 0 
#   cart.each do |item_hash|
#     item_hash.each do |item_name, price|
#       item_hash[item_name][:count] = 0
#       array_of_stuff << item_name
#       count = array_of_stuff.count(item_name)
#       item_hash[item_name][:count] = count
      
#       if !shopping_bag.has_key?(item_name)
#         shopping_bag[item_name]={}
#       end #end if 
      
#       shopping_bag[item_name] = price
      
#       if !shopping_bag[item_name][:count]
#         shopping_bag[item_name][:count]
#       end 
#       shopping_bag[item_name][:count] = count
  
#     end #end item hash do
#     end #end cart do 
#     shopping_bag 
# end

# def apply_coupons(cart, coupons)
#     item_name = cart.keys.join 
#     info_hash = {}
#     cart["#{item_name} W/COUPON"] = {}
#     coupons.each do |coupons_hash|
#       coupons_hash.each do |key, value|
#         if value == item_name
#           cart["#{item_name} W/COUPON"][:price] = coupons_hash[:cost]
#           cart["#{item_name} W/COUPON"][:clearance] = cart[item_name][:clearance]
#           #cart["#{item_name} W/COUPON"][:count] = 0
#           #coupon_count = cart[item_name][:count]/coupons_hash[:num]
#           if cart[item_name][:count] >= coupons_hash[:num]
#             coupon_count = cart[item_name][:count]/coupons_hash[:num]
#           cart["#{item_name} W/COUPON"][:count] = coupon_count
#           cart[item_name][:count] = cart[item_name][:count] - coupons_hash[:num]*coupon_count
#           end 
#         end #end if 
#       end #end coupons_hash do 
#     end #end coupons do 
# cart 
# end

# def apply_clearance(cart)
#   cart.each do |item_name, item_hash|
#     if item_hash[:clearance] == true 
#       item_hash[:price] = item_hash[:price]-item_hash[:price]*0.2 
#     end #end if 
   
#   end #end do 
  
# end

# def checkout(cart, coupons)
# if cart.size == 1 
#   consolidate_cart(cart)
# end 
# end
