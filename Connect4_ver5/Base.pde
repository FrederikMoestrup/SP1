class Base {

  // Display base
  void display() {

    strokeWeight(4);

    //grid
    for (int i=1; i < rowLength; i++) {
      line(i*width/rowLength, 0, i*width/rowLength, height);
    }
    for (int i=1; i < columnLength; i++) {
      line(0, i*height/columnLength, width, i*height/columnLength);
    }

    //frame
    line(0, 0, 0, height);
    line(0, 0, width, 0);
    line(0, height, width, height);
    line(width, 0, width, height);
  }

  //Returns string that is printed in main and tells which player's turn it is
  String newTurnMsg() {

    prevTurn=playerTurn;

    return "It's player "+playerTurnShow+"'s turn.";
  }
}
