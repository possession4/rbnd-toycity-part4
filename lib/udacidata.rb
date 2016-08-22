require_relative 'find_by'
require_relative 'errors'
require 'csv'
class Udacidata
	@@data_path =
		File.dirname(__FILE__) + "/../data/data.csv"

	create_finder_methods :brand, :name
	# create_finder_methods :name

	def self.create(options={})

		product = Product.new(
			id: options[:id],
			brand: options[:brand],
			name: options[:name],
			price: options[:price])

		product_array = CSV.read(@@data_path)
		existing_product = product_array.find do |row|
			row[0] == product.id
			row[1] == product.brand
			row[2] == product.name
			row[3] == product.price
		end
	if (existing_product.to_a.empty?)
		CSV.open(@@data_path, "ab") do |csv|
		product_row = [
			product.id.to_s,
			product.brand.to_s,
			product.name.to_s,
			product.price.to_s ]
	    
	    csv << product_row
	    end
	end

	product
	end

	def self.all
		product_array = CSV.read(@@data_path)
		product_array.drop(1).map do |row|
			Product.new(
				id: row[0],
				brand: row[1],
				name: row[2],
				price: row[3])
	    end
	end

	def self.first(number = 1)
		if (number > 1 && number <= self.all.length)
			self.all.first(number)
		elsif (number < 1 || number > self.all.length)
			nil
		else
			self.all.first
		end
	end

	def self.last(number = 1)
		if (number > 1 && number <= self.all.length)
			self.all.last(number)
		elsif (number < 1 || number > self.all.length)
			nil
		else
			self.all.last
		end
	end

	def self.find(id)
		product =
			self.all.find { |product|  product.id == id }
		if product.nil?
			raise ProductNotFoundError, "Product ID #{id} not found." 
		end
		product
	end

	def self.destroy(id)
		deleted_product = self.find(id)
		if deleted_product.nil?
			raise ProductNotFoundError, "Product ID #{id} not found." 
		else
			product_array = CSV.read(@@data_path)
			new_product_array = product_array.delete_if do |prod|
				prod[0] == id.to_s
			end
			CSV.open(@@data_path, "wb") do |csv|
				new_product_array.each do |product_row|
					csv << product_row
				end
			end
		end
		deleted_product
	end

	def self.where(options = {})
		self.all.select do |p|
			p.brand == options[:brand] || p.name == options[:name]
		end		
	end

	def update(options = {})
		@price = options[:price] || self.price
		@brand = options[:brand] || self.brand
		@name = options[:name] || self.name

		product_array = CSV.read(@@data_path)

		product_array.map! do |arr|
			if arr[0] == @id.to_s
				arr[1] = @brand
				arr[2] = @name
				arr[3] = @price
				arr
			else
				arr	
			end
		end

		CSV.open(@@data_path, "wb") do |csv|
			product_array.each do |product_row|
				csv << product_row
			end
		end	

		self
	end

	def print_products(products =[])
		products.each do |product|
			print "ID: #{product.id}, BRAND: #{product.brand}"
		end
	end
end
