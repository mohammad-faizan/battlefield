require './battlefield'
require './player'
require './game'

print 'Enter width and height of battlefield : '

input = gets.chomp.strip.split(' ')

if input.size < 2 or input.size > 2
	puts 'Invalid dimensions'
	exit(0)
end

width = input[0].to_i
height = input[1].to_s.strip.upcase

if width < 1 or width > 9
	puts 'Invalid battlefield width entered'
	exit(0)
end

if height < 'A' or height > 'Z'
	puts 'Invalid battlefield height entered'
	exit(0)
end

battlefield1 = Battlefield.new(width, height)
battlefield2 = Battlefield.new(width, height)
player1 = Player.new("Player-1", battlefield1)
player2 = Player.new("Player-2", battlefield2)

print "Enter number of battleships : "
input = gets.chomp.to_i

if input < 1 or input > (width * (height.ord - 65))
	puts 'Number of battleships must be less than area of battlefield'
	exit(0)
end

(1..input).each do |i|
	print "Enter Battleship #{i} details : "

	args = gets.chomp.strip.split(' ')

	if args.size < 5 or args.size > 5
		puts 'Invalid arguments please try again'
		redo
	end

	type = args[0].upcase
	w = args[1].to_i
	h = args[2].to_i
	p1_position = args[3].upcase
	p2_position = args[4].upcase

	unless ['P', 'Q'].include?(type)
		puts 'Type is not correct {P, Q} are valid types'
		redo
	end

	if w > width 
		puts 'Width is not correct must be less than battlefield width'
		redo
	end

	if h > (height.ord - 65)
		puts 'Height is not correct must be less than battlefield height'
		redo
	end

	unless battlefield1.has_block?(p1_position)
		puts 'Player 1 position is not correct'
		redo
	end

	unless battlefield2.has_block?(p2_position)
		puts 'Player 2 position is not correct'
		redo
	end

	player1.add_weapon(type, w, h, p1_position)
	player2.add_weapon(type, w, h, p2_position)

end

player1.add_target_points "A1 A2 A2 A3"
player2.add_target_points "A1 B1 C1 D1 D4 D4 D5 D5 A1"
Game.new(player1, player2).play

