module Analyzable
	def average_price(products = [])
		total_price =
			products.inject(0) { |sum,p| sum + p.price.to_f }
		(total_price / products.size).round(2)
	end

	def print_report(products = [])
		products.map do |product|
			"Id: #{product.id} | " \
			"Brand: #{product.brand} | " \
			"Name: #{product.name} | " \
			"Price: #{product.price}\n"
		end.to_s
	end

	def count_by_brand(products = [])
		brand_name = products[0].brand
		{ brand_name => products.size }
	end

	def count_by_name(products = [])
		hash_name = products[0].name
		{ hash_name => products.size }
	end
end
