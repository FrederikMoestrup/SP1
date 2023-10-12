//Amount of players (max 8)
int playerAmount=2;

//Player piece colors
color[] colorList = new color[8];

// Objects
Base myBase;
WinCons win;
Piece[] playerPieces = new Piece[playerAmount];

//Global variables

//True if the mouse is pressed
boolean pressMouse=false;

//True if the game is over. False if the game is still going
boolean gameOver=false;

//Player turn, The turn that is shown (not 0 based), and the previous turn.
int playerTurn;
int playerTurnShow;
int prevTurn;

//Length of rows and columns in the array of spaces on the board
int rowLength = 7*1;
int columnLength = 6*1;

//1 if a piece is placed on a space otherwise 0
int[][][] takenBy = new int [playerAmount][rowLength][columnLength];

//1 if if a winning move can be made on a space otherwise
int[][][] canWin = new int [playerAmount][rowLength][columnLength];

//Keeps track of the amount of pieces in each column
int[] columnStackNum = new int [rowLength];

//ArrayList of legal moves for the computer to pick from
ArrayList<Integer> legalMoves = new ArrayList();

//Amount of legal moves left
int legalMovesLeft = rowLength;

//sum used to check if it's a draw
int sum;
int sumMax = rowLength * columnLength ;


void setup() {
  size(700+70*4, 600+60*4);
  //Nothing has been placed yet
  for (int k = 0; k < playerAmount; k++) {
    for (int i = 0; i < rowLength; i++) {
      for (int j = 0; j < columnLength; j++) {
        takenBy[k][i][j] = 0;
        canWin[k][i][j] = 0;
      }
    }
  }

  //columnStuckNum is 0 and legalMoves are added to ArrayList
  for (int i = 0; i < columnStackNum.length; i++) {
    columnStackNum[i] = 0;
    legalMoves.add(i);
  }

  //Player piece colors
  colorList[0]=color(0, 0, 255);
  colorList[1]=color(255, 0, 0);
  colorList[2]=color(0, 255, 0);
  colorList[3]=color(0, 255, 255);
  colorList[4]=color(255, 0, 255);
  colorList[5]=color(255, 255, 0);
  colorList[6]=color(255, 140, 0);
  colorList[7]=color(34, 139, 34);

  // Initialize objects
  myBase = new Base();
  win = new WinCons();

  playerPieces[0] = new Piece(0, colorList[0], true);
  for (int k=1; k < playerAmount; k++) {
    playerPieces[k] = new Piece(k, colorList[k], false);
  }

  // Initialize turn counters
  prevTurn = -1;
  playerTurn=0;
  playerTurnShow=1;
}

void draw() {
  //White background
  background(255);
  //Displays base
  myBase.display();


  for (int k = 0; k < playerAmount; k++) {

    //Prints which player's turn it is 
    if (!gameOver && prevTurn!=playerTurn) {
      println(myBase.newTurnMsg());
    }
    
    //Finds winningmoves
    for (int g = 0; g < playerAmount; g++) {
      win.spotWinHorizontal(g);
      win.spotWinVertical(g);
      win.spotWinDiagonal(g);
    }

    //Removes illegal moves from ArrayList
    playerPieces[k].removeIllegalMoves();
    
    //Used by computer player to place piece
    playerPieces[k].placedByComputer(k);
    
    //Used by human player to place piece
    playerPieces[k].place();
    
    //Displays pieces that are placed
    playerPieces[k].display();



    //win conditions
    win.checkWinConsHorizontal(k);
    win.checkWinConsVertical(k);
    win.checkWinConsDiagonal(k);
    win.checkWinConsDraw();



    //Stops void draw() when the game is over
    if (gameOver) {
      noLoop();
    }
  }
}

//pressMouse true if mouse is pressed
void mousePressed() {
  if (!gameOver) {
    pressMouse=true;
  }
}
