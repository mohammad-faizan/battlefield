require './cell'
class Player

	attr_accessor :name, :battlefield, :target_points

	def initialize(name, battlefield)
		@battlefield = battlefield
		@name = name
	end

	def add_weapon(type, w, h, position)
		cell = Cell.new(type)
		y, x = position.split('')
		x = x.to_i

		(0..(w - 1)).each do |i|
			self.battlefield.create_cell(cell, "#{y}#{x + i}")
		end

		(0..(h - 1)).each do |i|
			self.battlefield.create_cell(cell, "#{(y.ord + i).chr}#{x}")
		end
	end

	def hit(enemy)
		if self.target_points.empty? and enemy.target_points.size > 0
			puts "#{self.name} has no missiles to launch"
			return false
		elsif self.target_points.empty? and enemy.target_points.empty?
			puts "Game drawn!"
			exit(0)
		else
			on_target = false
			target = self.target_points.shift
			str = "#{self.name} launch a missile with target #{target} which got "
			if hit_enemy(enemy, target)
				on_target = true
				str << "hit"
			else
				str << "miss"
			end
			puts str

			if on_target
				unless enemy.has_guts?
					puts "#{self.name} won the battle"
					exit(0)
				end
			end

			return on_target
		end
	end

	def destroy_location(map)
		self.battlefield.hit(map)
	end

	def has_guts?
		self.battlefield.has_cell?
	end

	def add_target_points(str)
		self.target_points = str.split(' ').map{|a| a.upcase}
	end

	def to_s
		self.battlefield.matrix.to_s
	end

	private
	def hit_enemy(enemy, target)
		enemy.destroy_location(target)
	end

end