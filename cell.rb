class Cell
	attr_accessor :type
	attr_reader :health

	def initialize(type)
		@type = type
		@health = type == 'Q' ? 2 : 1 
	end

	def decrease_health
		@health -= 1
		self
	end

	def destroyed?
		self.health < 1
	end
end
