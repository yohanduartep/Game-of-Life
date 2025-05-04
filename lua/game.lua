--twice the size and much better performance :O
local rows = 50
local cols = 190
local grid = {}
local next_grid = {}

local function initialize_grid()
	for i = 1, rows do
		grid[i] = {}
		next_grid[i] = {}
		for j = 1, cols do
			grid[i][j] = math.random(0, 1)
			next_grid[i][j] = 0
		end
	end
end

local function count_neighbors(x, y)
	local sum = 0
	for dx = -1, 1 do
		for dy = -1, 1 do
			if not (dx == 0 and dy == 0) then
				local nx = (x + dx - 1) % rows + 1
				local ny = (y + dy - 1) % cols + 1
				if grid[nx][ny] == 1 then
					sum = sum + 1
				end
			end
		end
	end
	return sum
end

local function update_grid()
	for i = 1, rows do
		for j = 1, cols do
			local neighbors = count_neighbors(i, j)
			local state = grid[i][j]
			if state == 0 and neighbors == 3 then
				next_grid[i][j] = 1
			elseif state == 1 and (neighbors < 2 or neighbors > 3) then
				next_grid[i][j] = 0
			else
				next_grid[i][j] = state
			end
		end
	end
	for i = 1, rows do
		for j = 1, cols do
			grid[i][j] = next_grid[i][j]
		end
	end
end

local function print_grid()
	for i = 1, rows do
		for j = 1, cols do
			io.write(grid[i][j] == 1 and "*" or " ")
		end
		io.write("\n")
	end
end

math.randomseed(os.time())
initialize_grid()

while true do
	print_grid()
	update_grid()
end
