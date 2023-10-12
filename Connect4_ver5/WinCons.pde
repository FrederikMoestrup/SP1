class WinCons {


  //win conditions

  //horizontal
  void checkWinConsHorizontal(int k) {
    for (int i = 0; i < rowLength-3; i++) {
      for (int j = 0; j < columnLength; j++) {
        if (takenBy[k][i][j]==1 && takenBy[k][i+1][j]==1 && takenBy[k][i+2][j]==1 && takenBy[k][i+3][j]==1 && !gameOver) {
          gameOver=true;
          playerTurnShow=k+1;
          println("Player "+playerTurnShow+" wins!");
          playerPieces[k].makeLine(i, j, i+3, j);
        }
      }
    }
  }


  //vertical
  void checkWinConsVertical(int k) {
    for (int i = 0; i < rowLength; i++) {
      for (int j = 0; j < columnLength-3; j++) {
        if (takenBy[k][i][j]==1 && takenBy[k][i][j+1]==1 && takenBy[k][i][j+2]==1 && takenBy[k][i][j+3]==1 && !gameOver) {
          gameOver=true;
          playerTurnShow=k+1;
          println("Player "+playerTurnShow+" wins!");
          playerPieces[k].makeLine(i, j, i, j+3);
        }
      }
    }
  }

  //diagonal
  void checkWinConsDiagonal(int k) {
    // "\"
    for (int i = 0; i < rowLength-3; i++) {
      for (int j = 0; j < columnLength-3; j++) {
        if (takenBy[k][i][j]==1 && takenBy[k][i+1][j+1]==1 && takenBy[k][i+2][j+2]==1 && takenBy[k][i+3][j+3]==1 && !gameOver) {
          gameOver=true;
          playerTurnShow=k+1;
          println("Player "+playerTurnShow+" wins!");
          playerPieces[k].makeLine(i, j, i+3, j+3);
        }
      }
    }
    // "/"
    for (int i = 0; i < rowLength-3; i++) {
      for (int j = 0; j < columnLength-3; j++) {
        if (takenBy[k][i+3][j]==1 && takenBy[k][i+2][j+1]==1 && takenBy[k][i+1][j+2]==1 && takenBy[k][i][j+3]==1 && !gameOver) {
          gameOver=true;
          playerTurnShow=k+1;
          println("Player "+playerTurnShow+" wins!");
          playerPieces[k].makeLine(i+3, j, i, j+3);
        }
      }
    }
  }


  //draw
  void checkWinConsDraw() {
    sum=0;
    for (int k = 0; k < playerAmount; k++) {
      for (int i = 0; i < rowLength; i++) {
        for (int j = 0; j < columnLength; j++) {
          sum+=takenBy[k][i][j];
        }
      }
    }
    if (sum==sumMax && !gameOver) {
      gameOver=true;
      println("It's a draw!");
    }
  }



  //Spot win

  //horizontal
  void spotWinHorizontal(int k) {
    for (int i = 0; i < rowLength-3; i++) {
      for (int j = 0; j < columnLength; j++) {
        if (takenBy[k][i][j]==0 && takenBy[k][i+1][j]==1 && takenBy[k][i+2][j]==1 && takenBy[k][i+3][j]==1 && columnStackNum[i]==columnLength-j-1 && !gameOver) {
          canWin[k][i][j]=1;
        }
        if (takenBy[k][i][j]==1 && takenBy[k][i+1][j]==0 && takenBy[k][i+2][j]==1 && takenBy[k][i+3][j]==1 && columnStackNum[i+1]==columnLength-j-1 && !gameOver) {
          canWin[k][i+1][j]=1;
        }
        if (takenBy[k][i][j]==1 && takenBy[k][i+1][j]==1 && takenBy[k][i+2][j]==0 && takenBy[k][i+3][j]==1 && columnStackNum[i+2]==columnLength-j-1 && !gameOver) {
          canWin[k][i+2][j]=1;
        }
        if (takenBy[k][i][j]==1 && takenBy[k][i+1][j]==1 && takenBy[k][i+2][j]==1 && takenBy[k][i+3][j]==0 && columnStackNum[i+3]==columnLength-j-1 && !gameOver) {
          canWin[k][i+3][j]=1;
        }
      }
    }
  }

  //vertical
  void spotWinVertical(int k) {
    for (int i = 0; i < rowLength; i++) {
      for (int j = 0; j < columnLength-3; j++) {
        if (takenBy[k][i][j]==0 && takenBy[k][i][j+1]==1 && takenBy[k][i][j+2]==1 && takenBy[k][i][j+3]==1 && columnStackNum[i]==columnLength-j-1 && !gameOver) {
          canWin[k][i][j]=1;
        }
        if (takenBy[k][i][j]==1 && takenBy[k][i][j+1]==0 && takenBy[k][i][j+2]==1 && takenBy[k][i][j+3]==1 && columnStackNum[i]==columnLength-j-1-1 && !gameOver) {
          canWin[k][i][j+1]=1;
        }
        if (takenBy[k][i][j]==1 && takenBy[k][i][j+1]==1 && takenBy[k][i][j+2]==0 && takenBy[k][i][j+3]==1 && columnStackNum[i]==columnLength-j-2-1 && !gameOver) {
          canWin[k][i][j+2]=1;
        }
        if (takenBy[k][i][j]==1 && takenBy[k][i][j+1]==1 && takenBy[k][i][j+2]==1 && takenBy[k][i][j+3]==0 && columnStackNum[i]==columnLength-j-3-1 && !gameOver) {
          canWin[k][i][j+3]=1;
        }
      }
    }
  }

  //diagonal
  void spotWinDiagonal(int k) {
    // "\"
    for (int i = 0; i < rowLength-3; i++) {
      for (int j = 0; j < columnLength-3; j++) {
        if (takenBy[k][i][j]==0 && takenBy[k][i+1][j+1]==1 && takenBy[k][i+2][j+2]==1 && takenBy[k][i+3][j+3]==1 && columnStackNum[i]==columnLength-j-1 && !gameOver) {
          canWin[k][i][j]=1;
        }
        if (takenBy[k][i][j]==1 && takenBy[k][i+1][j+1]==0 && takenBy[k][i+2][j+2]==1 && takenBy[k][i+3][j+3]==1 && columnStackNum[i+1]==columnLength-j-1-1 && !gameOver) {
          canWin[k][i+1][j+1]=1;
        }
        if (takenBy[k][i][j]==1 && takenBy[k][i+1][j+1]==1 && takenBy[k][i+2][j+2]==0 && takenBy[k][i+3][j+3]==1 && columnStackNum[i+2]==columnLength-j-2-1 && !gameOver) {
          canWin[k][i+2][j+2]=1;
        }
        if (takenBy[k][i][j]==1 && takenBy[k][i+1][j+1]==1 && takenBy[k][i+2][j+2]==1 && takenBy[k][i+3][j+3]==0 && columnStackNum[i+3]==columnLength-j-3-1 && !gameOver) {
          canWin[k][i+3][j+3]=1;
        }
      }
    }
    // "/"
    for (int i = 0; i < rowLength-3; i++) {
      for (int j = 0; j < columnLength-3; j++) {
        if (takenBy[k][i+3][j]==0 && takenBy[k][i+2][j+1]==1 && takenBy[k][i+1][j+2]==1 && takenBy[k][i][j+3]==1 && columnStackNum[i+3]==columnLength-j-1 && !gameOver) {
          canWin[k][i+3][j]=1;
        }
        if (takenBy[k][i+3][j]==1 && takenBy[k][i+2][j+1]==0 && takenBy[k][i+1][j+2]==1 && takenBy[k][i][j+3]==1 && columnStackNum[i+2]==columnLength-j-1-1 && !gameOver) {
          canWin[k][i+2][j+1]=1;
        }
        if (takenBy[k][i+3][j]==1 && takenBy[k][i+2][j+1]==1 && takenBy[k][i+1][j+2]==0 && takenBy[k][i][j+3]==1 && columnStackNum[i+1]==columnLength-j-2-1 && !gameOver) {
          canWin[k][i+1][j+2]=1;
        }
        if (takenBy[k][i+3][j]==1 && takenBy[k][i+2][j+1]==1 && takenBy[k][i+1][j+2]==1 && takenBy[k][i][j+3]==0 && columnStackNum[i]==columnLength-j-3-1 && !gameOver) {
          canWin[k][i][j+3]=1;
        }
      }
    }
  }
}
