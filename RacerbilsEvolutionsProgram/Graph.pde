class Graph {
  //sørger for at proccesing bliver brugt
  PApplet pApplet;
  
  //dette er tablen som dataen bliver trukket ud fra
  Table table;
  
  //postion og størrelse på grafen
  int xSize, ySize, posX, posY;
  
  //den største værdig i datasættet som i starten er den minhdste værdig man kan have som int
  int maxY = Integer.MIN_VALUE;
  
  //
  float xInt;
  float yInt;
  
  //det er denne som grafen starter ved
  int graphStart = 0;
  
  //hvilken colone som tallene tages fra
  int colon;
  

//du kan slå linjer til og fra
  boolean linesOn = true;
  
  //laver grafen
  Graph(PApplet app, int posX, int posY, int xSize, int ySize, int colon, Table table) {
    pApplet = app;
    this.colon = colon;
    this.table = table;
    this.xSize = xSize;
    this.ySize = ySize;
    this.posX = posX;
    this.posY = posY;
  }
  
  //laver grafen vært frame
  void drawGraph() {
    
    //vært 200 frame updatere den listen
    if(frameCount%200==0)
    table =bilerLegacy;
    
    //laver bagrunden
    fill(255);
    rect(posX, posY, xSize, ySize+30);


    //tjekker om der er nok eller for meget data til man kan tegne grafen
    if (table.getRowCount() >1 && table.getRowCount() < 490 ) {
      pApplet.fill(0);

      int x1, y1, x2, y2;
      x1 = 0;
      y1 = ySize;


      for (int i=0; i<table.getRowCount(); ++i) {
        //udrenger den største y værdig
        int maxList = 0;
        for (int j = 0; j < table.getRowCount(); ++j) {
          if (table.getInt(j, colon) > maxList) {
            maxList = table.getInt(j, colon);
            maxY = Math.max(maxList, maxY);
          }
        }
        //udrenger kordinaterne til vært punkt og tegner det samt lavere en linje imellem vært
        xInt = xSize/(table.getRowCount());
        yInt = (float) ySize/maxY;


        x2 = (int) xInt * i-graphStart;
        y2 = ySize - ((int) (table.getInt(i, colon) * yInt));
        pApplet.stroke(0);
        if (linesOn) {
          pApplet.line(posX + x1, posY + y1, posX + x2, posY + y2);
        }


        pApplet.ellipse(posX+x1, posY+y1, 2, 2);
        if (table.getRowCount() <100)
          text(table.getInt(i, 0), posX+x1, posY+y1);
        stroke(200, 0, 0, 100);
        int yline = posY+ySize - ((int) (fastesTime * yInt));
        line(posX, yline, posX+ xSize, yline);
        x1 = x2;
        y1 = y2;
      }
    } else {
      
      if (table.getRowCount() > 53) {
        //skriver vis der er for meget data
        textSize(16);
        fill(0);
        text("There is too much \ndata to display", posX+(xSize/2)-textWidth("There is too much \ndata to display")/2, posY + (ySize/2+32));
      } else {
        //har et ? når der ikke er noget data
        textSize(64);
        fill(0);
        text("?", posX+(xSize/2-textWidth("?")/2), posY + (ySize/2+32));
      }
    }
    textSize(10);
    drawAxis(false, posX, posX-12 + xSize, posY + ySize, posY + ySize);
    drawAxis(true, posX, posX, posY+12, posY+ySize);
    //skriver hvadd grafen forstilelr 
    text("on the x axis there is time and up on y there is LapTime in frames", posX + 5, posY + ySize+ 20);
  }
  
  //funktion der laver axsierne
  void drawAxis(boolean isyAxis, int x1, int x2, int y2, int y1) {
    pApplet.fill(23, 94, 150);
    pApplet.stroke(1, 46, 74);
    pApplet.line(x1, y1, x2, y2);
    
    if (isyAxis == true) {
      // Draw arrow at endde
      pApplet.triangle(x2  + 10, y2, x2 - 10, y2, x2, y2-10);
    } else {
      // Draw arrow at end
      pApplet.triangle(x2+ 10, y2, x2, y2 + 10, x2, y2-10);
    }
  }
}
