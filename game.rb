class Game

	attr_accessor :player1, :player2, :turn

	def initialize(p1, p2)
		@player1 = p1
		@player2 = p2
		@turn = 1
	end

	def play
		while true do
			if turn == 1
				self.turn = 2 unless player1.hit(player2)
			else
				self.turn = 1 unless player2.hit(player1)
			end
		end
	end
end