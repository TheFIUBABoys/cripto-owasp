#!bin/rails runner

# Creates 20 random objects.

count = SqlInjectionObject.count

(count...20).each do |_n|
  SqlInjectionObject.create title: Forgery('email').body, text: Forgery('email').subject
end
