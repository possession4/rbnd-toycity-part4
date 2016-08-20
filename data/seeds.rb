require 'faker'

# This file contains code that populates the database with
# fake data for testing purposes

def db_seed
  20.times do |i|
  	Product.create(
  				id: (i + 1).to_s,
  				brand: Faker::Company.name,
  				name: Faker::Commerce.product_name,
  				price: Faker::Commerce.price)
  end
end
