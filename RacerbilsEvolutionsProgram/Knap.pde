class Knap {
  //kanppens poston og størrelse
  float positionX, positionY, sizeX, sizeY;
  
  //musen postion
  float mouseX, mouseY;
  
  //texten på knappen
  String text;
  
  //om den er klikket
  boolean klikket = false;

  //pde
  PApplet p;
  
  
  //når knappen bliver lavet
  Knap(PApplet papp, int posX, int posY, int sizeX, int sizeY, String text ) {
    p = papp;
    positionX = posX;
    positionY = posY;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.text = text;
  }
  
  //tjeker om knappen er klikket 
  void klik() {
    if (p.mousePressed &&
      mouseX > positionX &&
      mouseX < positionX + sizeX &&
      mouseY > positionY &&
      mouseY < positionY + sizeY) {
    }
  }
  
  // tegner teksten på knappen
  void setTekst(String tekst) {
    p.fill(0);

    p.text(tekst, positionX +(sizeX/16), positionY + (sizeY/2));
  }
  
  
  //tegner knappen
  void tegnKnap() {
    p.stroke(1, 46, 74, 100);
    if (klikket) {
      p.fill(255);
    } else {
      p.fill(200, 200, 200, 100);
    }

    p.rect(positionX, positionY, sizeX, sizeY);
    setTekst(text);
  }

  boolean erKlikket() {
    return klikket;
  }
   
   //register klikket på knappen
  void registrerKlik(float mouseX, float mouseY) {
    this.mouseX = mouseX;
    this.mouseY = mouseY;
    if (mouseX > positionX &&
      mouseX < positionX + sizeX &&
      mouseY > positionY &&
      mouseY < positionY + sizeY) {
      klikket = true;
    }
  }
  
  //siger knappen ikke er klikket længere
  void registrerRelease() {
    klikket = false;
  }
}
