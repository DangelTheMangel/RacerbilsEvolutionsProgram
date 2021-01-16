//populationSize: Hvor mange "controllere" der genereres, controller = bil & hjerne & sensorer
int       populationSize  = 200;    

//hvilken generation du er på
static public int       Generation = 1;
//stats om tid og hvornår de er alle sat til det højste en int kan være fordi tiderne skal helst være hurtiger end det
public int       fastesGeneration = 0;
public int       fastesTime = Integer.MAX_VALUE;
public int       thisGenTime = Integer.MAX_VALUE;
public int       lastGenTime = Integer.MAX_VALUE;

//antal gange brugerne har gemt csv filnen 
int timesSaved = 0;
//om du ville have imigranter med ( dette bliver slået til efter noget tid)
boolean immigrate = true;

//denne tjekker om du er igang med at indlæse en ny csv fil
public boolean procsseing = false;

//CarSystem: Indholder en population af "controllere" 
CarSystem carSystem       = new CarSystem(populationSize);

//det her i denne klasse alle funktionerne med generationerne er 
Algoritme al = new Algoritme(carSystem);

// her bliver alle knapperne lavet
Knap btnSave = new Knap(this, 560, 650, 190, 30, "Save CSV File");
Knap btnRetry = new Knap(this, 30, 650, 190, 30, "Retry generation ");

Knap btnOpen = new Knap(this, 780, 650, 190, 30, "Continue training...");
Knap btnSwicht = new Knap(this, 250, 650, 190, 30, "Change track... ");

//her bliver csv filen lavet
static public Table bilerLegacy;

//dette er grafen
Graph graph;
//trackImage: RacerBanen , Vejen=sort, Udenfor=hvid, Målstreg= 100%grøn 
PImage    trackImage;

void setup() {
  //sætter vinduet størrelse
  size(1000, 700);
  
  //loader billede
  trackImage = loadImage("track.png");
  
  //laver en ny tabel
  bilerLegacy = new Table();
  //tilføjer alle colonerne
  bilerLegacy.addColumn("Generation");
  bilerLegacy.addColumn("Laptime");
  for (int i = 0; i<carSystem.CarControllerList.get(0).hjerne.weights.length -1; ++i) {
    bilerLegacy.addColumn("weight " + (i +1));
  }
  
  //laver grafen 
  graph = new Graph(this, 500, 350, 500, 250, 1, bilerLegacy);
}


void draw() {
  
  //tjekker om der bliver loaded csv fil
  if (procsseing) {
    
    //skriver at man skal vente fordi der bliver loaded dette ses nomal ikke fordi ens pc er så hurtig men vis du har en langsom en så komme du ikke tænker "hvad sker der"
    textSize(64);
    fill(0);
    text("procsseing pleas wait", width/2-textWidth("procsseing pleas wait")/2, height/2);
    fill(255);
    textSize(66);
    text("procsseing pleas wait", width/2-textWidth("procsseing pleas wait")/2, height/2);
    
  } else {
    //fjerne hvad der var på sidste billede
    clear();
    
    //tegner banen
    fill(255);
    rect(-1, 50, 501, 700);
     
     //tjekker vis billede er null vis den er loader den det nomale billede 
     //(grunden til dette er at vi kan ikek chace vis det er en forkert fil du har klikket på når du loader et ny billede)
    if (trackImage == null) {
     
      trackImage = loadImage("track.png");
    }
    image(trackImage, 0, 80, 491, 439);

    //køre getParrents som finder mulig forældre og når den har nok laver en ny generation
    al.getParrents();
    
    //vært 200 frame fjerne det dem der har stået stille for længe
    if (frameCount%200==0 && !al.parrentListIsFull) {
      al.removeBadOnes();
      if (immigrate) {
        if (Generation == 1) {
          for (int i = 0; i <populationSize/10; ++i)
            al.DumDumRemix(carSystem.CarControllerList.get((int)random(0, carSystem.CarControllerList.size() -1)), carSystem.CarControllerList.get((int)random(0, carSystem.CarControllerList.size() -1)));
        } else {
          //bilerLegacy
          CarController carcon1 = new CarController();
          CarController carcon2 = new CarController();
          carConIndput(carcon1);
          carConIndput(carcon2);

          for (int i = 0; i <populationSize/10; ++i)
            al.DumDumRemix(carcon1, carcon2);
        }
      }
    }
    // viser bilerne 
    carSystem.updateAndDisplay();
    
    //vært 200 frame fjerne den alle dårlige biler og lader indvandre komme 
    al.killDumOne();




    //tegner interfacet
    graphics();
  }
  
  //tjekker om knapperne er bliver klikket
  
  //det er denne som loader det du er nådet til
  if (btnOpen.klikket) {
    selectInput("Select a csv file to process:", "continueTraining");
    print("færdig");
    procsseing = false;
    btnOpen.registrerRelease();
  }
  
  //denne der ændre banen
  if (btnSwicht.klikket) {
    selectInput("Select a png file to process:", "changeTrack");

    btnSwicht.registrerRelease();
  }
  
  //denne der gammer csv filen
  if (btnSave.klikket) {
    String s = "EvoltionData" + "D"+ day() + "M"+month()+"Y"+year() + "("+timesSaved+")";
    timesSaved++;
    saveTable(bilerLegacy, "data/"+s +".csv");
    print("gemt!");
    btnSave.registrerRelease();
  }
  
  //denne der starter generation forfra
  if (btnRetry.klikket) {
    if (Generation == 1) {
      carSystem.CarControllerList.clear();
      al.borneBassinet.clear();
      al.tiderBorneBassinet.clear();
      for (int i=0; i<populationSize; i++) { 
        CarController controller = new CarController();
        carSystem.CarControllerList.add(controller);
      }
    } else {
      restart();
    }

    btnRetry.registrerRelease();
  }
}

//det er denne funktion der tager fil lokation loader bilelde ind i programet
void changeTrack(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel or wrong file format.");
  } else {
    try {
      println("User selected " + selection.getAbsolutePath());
      trackImage =loadImage(selection.getAbsolutePath());
    } 
    catch(Exception e) {
      println("Window was closed or the user hit cancel or wrong file format.");
      trackImage = loadImage("track.png");
    }
  }
}

//denne genstarter generationen
void restart() {
  carSystem.CarControllerList.clear();
  al.borneBassinet.clear();
  al.tiderBorneBassinet.clear();
  //slår indvandre 
  immigrate = false;
  //fyld bornelisten op

  //start gen
  al.getOldParrents();
  Generation--;
  al.startNewGen(false);
  //slår indvandre 
  al.updateDisplayFromTable();
  immigrate = true;
}

//denne loader tiligere data ind og generstaere sidste generation
void continueTraining(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel or wrong file format.");
  } else {
    try {
      println("User selected " + selection.getAbsolutePath());
      immigrate = false;
      procsseing = true;
      bilerLegacy = loadTable(selection.getAbsolutePath());
      Generation = bilerLegacy.getInt(bilerLegacy.getRowCount()-1, 0);
      restart();
      procsseing = false;
    }
    catch(Exception e) {
      println("Window was closed or the user hit cancel or wrong file format.");
    }
  }
}

//denne der laver indvandere der ligner tidliger vinder
void carConIndput(CarController carcon) {
  float[] newWeights = new float[8];
  int selected = (int)random(1, bilerLegacy.getRowCount());
  for (int i = 0; i<newWeights.length; ++i) {
    newWeights[i] = bilerLegacy.getFloat(selected, 2+i);
  }
  carcon.hjerne.weights = newWeights;
}

//funktion der tenger interfaces
void graphics() {

  //laver baerne
  fill(100);
  rect(-1, -1, width+2, 50);
  fill(150);
  rect(500, 50, 501, 700);
  fill(255);
  
  //laver overskriften
  textSize(60);
  text("Race Evolution", width/2- textWidth("Race evolution")/2, 40 );


  //stats screen 
  fill(255);
  textSize(25);
  text("Stats: ", 530, 80 );

  textSize(18);
  text("basic stats: ", 530, 130 );
  textSize(14);
  text("Generation: " +Generation +
    "\nPasses: " +al.borneBassinet.size()+"/10"+ "\nSize of Generation:" + carSystem.CarControllerList.size(), 540, 155 );

  textSize(18);
  text("Times: ", 765, 130 );
  textSize(14);
  String ft;
  
  //når der ikek er fundet data i nu så står der ? istedet for et meget stor tal
  if (fastesTime ==Integer.MAX_VALUE) {
    ft = "Fastest time: " +"?" + "\nFastest time Generation: " + "?";
  } else {
    ft = "Fastest time: " +fastesTime + "\nFastest time Generation: " + fastesGeneration;
  }
  String ftg;
  if (thisGenTime ==Integer.MAX_VALUE) {
    ftg =  "\n\n" + "The fastest time \nof this generation: "+ "?" ;
  } else {
    ftg =  "\n\n" + "The fastest time \nof this generation: "+thisGenTime ;
  }
  String ftl;
  if (lastGenTime ==Integer.MAX_VALUE) {
    ftl = "\n\n" + "Last generation \nfastest time:" + "?";
  } else {
    ftl = "\n\n" + "Last generation \nfastest time:" + lastGenTime;
  }

  String s = ft+ftg+ftl;
  text(s, 770, 160 );

  //tegner alel knapperne
  graph.drawGraph();
  btnSave.tegnKnap();
  btnRetry.tegnKnap();
  btnOpen.tegnKnap();
  btnSwicht.tegnKnap();
}
void mousePressed() {
  //giver alle kanpperne lokation på musen når du klikekr med den
  btnSave.registrerKlik((float)mouseX, (float)mouseY);
  btnRetry.registrerKlik((float)mouseX, (float)mouseY);
  btnOpen.registrerKlik((float)mouseX, (float)mouseY);
  btnSwicht.registrerKlik((float)mouseX, (float)mouseY);
}
