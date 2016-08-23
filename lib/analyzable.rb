module Analyzable
	def average_price(products = [])
		total_price =
			products.inject(0) { |sum,product| sum + product.price.to_f }
		unless products.size == 0
			(total_price / products.size).round(2)
		end
	end

	def print_report(products = [])

		puts "Inventory by Brand:"
		brands = count_by_brand(products)

		unless brands.nil?
			if brands.is_a? Hash
				brands.map { |key, value| puts "  - #{key}: #{value}"}
			else
				brands.map { |count| count.map { |key, value| puts "  - #{key}: #{value}"} }
			end
		end

		puts "Inventory by Name:"
		name = count_by_name(products)

		unless name.nil?
			if name.is_a? Hash
				name.map { |key, value| puts "  - #{key}: #{value}"}
			else
				name.map { |count| count.map { |key, value| puts "  - #{key}: #{value}"} }
			end
		end

		average_price(products).to_s
	end

	def count_by_brand(products = [])

		count = products
				.group_by(&:brand)
				.map { |brand, matches| { brand => matches.size } }

		unless count.empty? 
			count.size == 1 ? count[0] : count
		end
	end

	def count_by_name(products = [])

		count = products
				.group_by(&:name)
				.map { |brand, matches| { brand => matches.size } }

		unless count.empty? 
			count.size == 1 ? count[0] : count
		end
	end
end
