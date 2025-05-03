#Slower than C and java, but considerable less "flickerish"
import os
import random

ROWS = 50
COLS = 185

grid = []
for i in range(ROWS):
    row = []
    for j in range(COLS):
        row.append(random.randint(0, 1))
    grid.append(row)

next_grid = []
for i in range(ROWS):
    row = []
    for j in range(COLS):
        row.append(0)
    next_grid.append(row)


def count_neighbors(x, y):
    count = 0
    for dx in [-1, 0, 1]:
        for dy in [-1, 0, 1]:
            if dx == 0 and dy == 0:
                continue
            nx = (x + dx) % ROWS
            ny = (y + dy) % COLS
            count += grid[nx][ny]
    return count

def update_grid():
    for i in range(ROWS):
        for j in range(COLS):
            n = count_neighbors(i, j)
            if grid[i][j] == 1:
                if n == 2 or n == 3:
                    next_grid[i][j] = 1
                else:
                    next_grid[i][j] = 0
            else:
                if n == 3:
                    next_grid[i][j] = 1
                else:
                    next_grid[i][j] = 0
    for i in range(ROWS):
        for j in range(COLS):
            grid[i][j] = next_grid[i][j]

def print_grid():
    os.system("clear")
    for i in range(ROWS):
        line = ""
        for j in range(COLS):
            if grid[i][j] == 1:
                line += "*"
            else:
                line += " "
        print(line)

while True:
    print_grid()
    update_grid()

