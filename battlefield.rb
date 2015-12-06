class Battlefield

	attr_accessor :matrix, :width, :height

	def initialize(w, h)
		@width, @height = w, h
		@matrix = {}
		draw_matrix()
	end

	def create_cell(cell, position)
		self.matrix[position] = cell
	end

	def hit(key)
		if self.matrix[key] != nil
			cell = self.matrix[key].decrease_health
			if cell.destroyed?
				self.matrix[key] = nil
			end
			return true
		else
			return false
		end
	end

	def has_block?(key)
		self.matrix.has_key?(key)
	end

	def has_cell?
		self.matrix.select{|k, v| !v.nil?}.size > 0
	end

	private
	def draw_matrix
		(1..width).each do |w|
			('A'..height).each do |h|
				self.matrix["#{h}#{w}"] = nil
			end
		end
	end
end