#!bin/rails runner

# Creates 20 random objects.

count = SqlInjectionObject.count

(count...5).each do |_n|
  SqlInjectionObject.create title: Forgery('address').country, text: Forgery('address').street_address
end
