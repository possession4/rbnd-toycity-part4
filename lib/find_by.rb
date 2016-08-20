class Module
  def create_finder_methods(*attributes)
    # Your code goes here!
    # Hint: Remember attr_reader and class_eval

	attributes.each do |attribute|
		find_by_methods = %Q{
			def self.find_by_#{attribute}(value)
				self.all.find { |i| i.#{attribute} == value }
			end
		}
		class_eval(find_by_methods)
	end
  end
end
