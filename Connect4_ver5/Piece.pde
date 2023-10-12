class Piece {

  //x and y positions of all pieces
  float[][] xpos = new float [rowLength][columnLength];
  float[][] ypos = new float [rowLength][columnLength];

  //Player info
  int playerNum;
  color playerColor;
  boolean isHuman;

  //Variables used by computer to place pieces
  int randNum;
  int canWinSum;
  int theyCanWinSum;
  boolean onlyOneWin;

  //Size of a piece
  float pieceSize = min(width/(rowLength+3), width/(columnLength+3));


  //Constructor
  Piece(int playerNum, color playerColor, boolean isHuman) {
    //x and y position for center of each space on the board
    for (int j = 0; j < columnLength; j++) {
      for (int i = 0; i < rowLength; i++) {
        xpos[i][j] = (2*i+1)*width/(2*rowLength);
      }
    }

    for (int i = 0; i < rowLength; i++) {
      for (int j = 0; j < columnLength; j++) {
        ypos[i][j] = (2*j+1)*height/(2*columnLength);
      }
    }

    this.playerColor=playerColor;
    this.playerNum=playerNum;
    this.isHuman=isHuman;
  }

  //Displays pieces that are placed
  void display() {
    for (int k = 0; k < playerAmount; k++) {
      for (int i = 0; i < rowLength; i++) {
        for (int j = 0; j < columnLength; j++) {
          if (takenBy[k][i][j]==1 && playerNum==k) {
            fill(playerColor);
            ellipse(xpos[i][j], ypos[i][j], pieceSize, pieceSize);
          }
        }
      }
    }
  }

  //Used by human player to place piece
  // If mouse is pressed in an available column -> place piece

  void place() {
    // Place a player 1 piece if available space in column
    for (int k=0; k < playerAmount; k++) {
      if (this.isHuman==true && this.playerNum==k && playerTurn==k) {
        for (int i = 0; i < rowLength; i++) {
          if ((i*width/rowLength<mouseX) && (mouseX<((i+1)*width/rowLength)) && pressMouse && columnStackNum[i] < columnLength ) {
            takenBy[k][i][columnLength-1-columnStackNum[i]] = 1;

            for (int kk = 0; kk < playerAmount; kk++) {
              canWin[kk][i][columnLength-1-columnStackNum[i]]=0;
            }

            columnStackNum[i]+=1;
            playerTurn = (playerTurn + 1) % playerAmount;
            playerTurnShow = playerTurn + 1;
            pressMouse = false;
          } else if ((i*width/rowLength<mouseX) && (mouseX<((i+1)*width/rowLength)) && pressMouse && columnStackNum[i] >= columnLength ) {
            pressMouse = false;
          }
        }
      }
    }
  }


  //Removes illegal moves from ArrayList
  void removeIllegalMoves() {
    for (int i=0; i < rowLength; i++) {
      for (int j=0; j < legalMovesLeft; j++) {
        if (columnStackNum[i] == columnLength  && legalMoves.get(j)==i) {
          columnStackNum[i]+=1;
          legalMovesLeft -= 1;
          legalMoves.remove(j);
        }
      }
    }
  }


  //Used by computer player to place piece

  //Priority 1: Make winning move
  //Priority 2: Block other player's winning move
  //Otherwise make random legal move

  void placedByComputer(int k) {

    canWinSum=0;
    theyCanWinSum=0;
    for (int i = 0; i < rowLength; i++) {
      for (int j = 0; j < columnLength; j++) {
        canWinSum+=canWin[k][i][j];
        for (int kk=0; kk < playerAmount; kk++) {
          theyCanWinSum+=canWin[kk][i][j];
        }
      }
    }

    if (this.isHuman==false && this.playerNum==k && playerTurn==k && !gameOver) {
      //println(legalMoves);
      if (legalMoves.isEmpty()) {
        println("List is empty");
      }

      //Priority 1
      else if (canWinSum>0) {
        //println("Hihi");
        onlyOneWin=true;
        for (int i = 0; i < rowLength; i++) {
          for (int j = 0; j < columnLength; j++) {
            if (canWin[k][i][j]==1 && onlyOneWin) {
              takenBy[k][i][j]=1;
              for (int kk = 0; kk < playerAmount; kk++) {
                canWin[kk][i][j]=0;
              }
              onlyOneWin=false;
              columnStackNum[i]+=1;
              playerTurn = (playerTurn + 1) % playerAmount;
              playerTurnShow = playerTurn + 1;
            }
          }
        }
      }

      //Priority 2
      else if (theyCanWinSum>0) {
        //println("Haha");
        onlyOneWin=true;

        //Players right after first
        for (int c=k+1; c < playerAmount; c++) {
          for (int i = 0; i < rowLength; i++) {
            for (int j = 0; j < columnLength; j++) {
              if (canWin[c][i][j]==1 && onlyOneWin) {
                takenBy[k][i][j]=1;
                for (int kk = 0; kk < playerAmount; kk++) {
                  canWin[kk][i][j]=0;
                }
                onlyOneWin=false;
                columnStackNum[i]+=1;
                playerTurn = (playerTurn + 1) % playerAmount;
                playerTurnShow = playerTurn + 1;
              }
            }
          }
        }

        //Rest of the players
        for (int c=0; c < k; c++) {
          for (int i = 0; i < rowLength; i++) {
            for (int j = 0; j < columnLength; j++) {
              if (canWin[c][i][j]==1 && onlyOneWin) {
                takenBy[k][i][j]=1;
                for (int kk = 0; kk < playerAmount; kk++) {
                  canWin[kk][i][j]=0;
                }
                onlyOneWin=false;
                columnStackNum[i]+=1;
                playerTurn = (playerTurn + 1) % playerAmount;
                playerTurnShow = playerTurn + 1;
              }
            }
          }
        }

        //Otherwise random
      } else if (!legalMoves.isEmpty()) {
        //println("This is random");
        randNum = legalMoves.get((int) random(0, legalMovesLeft));
        takenBy[k][randNum][columnLength-1-columnStackNum[randNum]] = 1;

        for (int kk = 0; kk < playerAmount; kk++) {
          canWin[kk][randNum][columnLength-1-columnStackNum[randNum]]=0;
        }

        columnStackNum[randNum]+=1;
        playerTurn = (playerTurn + 1) % playerAmount;
        playerTurnShow = playerTurn + 1;
        //println("It's player "+playerTurnShow+"'s turn.");
      }
    }
  }


  //Make a line. Method is used if we connect 4 pieces
  void makeLine(int p1x, int p1y, int p2x, int p2y) {
    strokeWeight(20);
    line(xpos[p1x][p1y], ypos[p1x][p1y], xpos[p2x][p2y], ypos[p2x][p2y]);
    strokeWeight(4);
  }
}
