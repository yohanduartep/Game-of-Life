//Giga performance improvement. It even flickers. I wont use time libs and fix that for now.
#include <stdio.h>
#include <stdlib.h>

#define ROWS 50
#define COLS 185

int grid[ROWS][COLS];
int next_grid[ROWS][COLS];

void initialize_grid(){
    for(int i = 0; i < ROWS; i++){
        for(int j = 0; j < COLS; j++){
            grid[i][j] = rand() % 2;
        }
    }
}

int count_neighbors(int x, int y){
    int sum = 0;
    for(int dx = -1; dx <= 1; dx++){
        for(int dy = -1; dy <= 1; dy++){
            if (dx != 0 || dy != 0){
                sum += grid[(x + dx + ROWS) % ROWS][(y + dy + COLS) % COLS];
            }
        }
    }
    return sum;
}

void update_grid(){
    for(int i = 0; i < ROWS; i++){
        for(int j = 0; j < COLS; j++){
            int n = count_neighbors(i, j);
            if(grid[i][j]){
                if(n == 2 || n == 3){
                    next_grid[i][j] = 1;
                }else{
                    next_grid[i][j] = 0;
                }
            }else{
                if(n == 3){
                    next_grid[i][j] = 1;
                }else{
                    next_grid[i][j] = 0;
                }
            }
        }
    }
    for(int i = 0; i < ROWS; i++){
        for(int j = 0; j < COLS; j++){
            grid[i][j] = next_grid[i][j];
        }
    }
}

void print_grid(){
    system("clear");
    for(int i = 0; i < ROWS; i++){
        for(int j = 0; j < COLS; j++){
            if(grid[i][j]){
                putchar('*');
            }else{
                putchar(' ');
            }
        }
        putchar('\n');
    }
}

int main(){
    initialize_grid();
    system("clear");
    while(1){
        print_grid();
        update_grid();
    }
    return 0;
}

