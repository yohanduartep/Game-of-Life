//Great performance. Also has some flickers. Also want to try time on this one.
public class game{
    static final int ROWS = 50;
    static final int COLS = 185;
    static int[][] grid = new int[ROWS][COLS];
    static int[][] next = new int[ROWS][COLS];

    public static void main(String[] args) throws Exception{
        initializeGrid();

        while(true){
            printGrid();
            updateGrid();
        }
    }

    static void initializeGrid(){
        for(int i = 0; i < ROWS; i++){
            for(int j = 0; j < COLS; j++){
                if(Math.random() < 0.5){
                    grid[i][j] = 1;
                } else {
                    grid[i][j] = 0;
                }
            }
        }
    }

    static int countNeighbors(int x, int y){
        int sum = 0;
        for(int dx = -1; dx <= 1; dx++){
            for(int dy = -1; dy <= 1; dy++){
                if(!(dx == 0 && dy == 0)){
                    sum += grid[(x + dx + ROWS) % ROWS][(y + dy + COLS) % COLS];
                }
            }
        }
        return sum;
    }

    static void updateGrid(){
        for(int i = 0; i < ROWS; i++){
            for(int j = 0; j < COLS; j++){
                int n = countNeighbors(i, j);
                int cell = grid[i][j];
                if((cell == 1 && (n == 2 || n == 3)) || (cell == 0 && n == 3)){
                    next[i][j] = 1;
                }else{
                    next[i][j] = 0;
                }
            }
        }
        int[][] temp = grid;
        grid = next;
        next = temp;
    }

    static void printGrid(){
        try{
            new ProcessBuilder("clear").inheritIO().start().waitFor();
        }catch(Exception e){
            e.printStackTrace();
        }

        System.out.flush();
        for(int i = 0; i < ROWS; i++){
            StringBuilder line = new StringBuilder();
            for (int j = 0; j < COLS; j++){
                if(grid[i][j] == 1){
                    line.append('*');
                }else{
                    line.append(' ');
                }
            }
            System.out.println(line);
        }
    }
}

