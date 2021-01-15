//populationSize: Hvor mange "controllere" der genereres, controller = bil & hjerne & sensorer
int       populationSize  = 200;    
static public int       Generation = 1;
public int       fastesGeneration = 0;
public int       fastesTime = Integer.MAX_VALUE;
public int       thisGenTime = Integer.MAX_VALUE;
public int       lastGenTime = Integer.MAX_VALUE;

//CarSystem: Indholder en population af "controllere" 
CarSystem carSystem       = new CarSystem(populationSize);
Algoritme al = new Algoritme(carSystem);
static public Table bilerLegacy;

//trackImage: RacerBanen , Vejen=sort, Udenfor=hvid, Målstreg= 100%grøn 
PImage    trackImage;

void setup() {
  size(500, 600);
  trackImage = loadImage("track.png");
  bilerLegacy = new Table();
  bilerLegacy.addColumn("Generation");
  bilerLegacy.addColumn("Laptime");
  bilerLegacy.addColumn("Vægt1");
  bilerLegacy.addColumn("Vægt2");
  bilerLegacy.addColumn("Vægt3");
  bilerLegacy.addColumn("Vægt4");
  bilerLegacy.addColumn("Vægt5");
  bilerLegacy.addColumn("Vægt6");
  bilerLegacy.addColumn("Vægt7");
  bilerLegacy.addColumn("Vægt8");
  bilerLegacy.addColumn("Vægt9");
}

void draw() {
  clear();
  fill(255);
  rect(0,50,1000,1000);
  image(trackImage,0,80);
  text("Generation: " +Generation + "Gen Fastesets time: " + thisGenTime
  + "\nlastGenTime"+ lastGenTime+ 
  "\nFastes time: " +fastesTime + " Fastes Generation: " + fastesGeneration + 
  "\nAntal godkendte: " + al.borneBassinet.size()
  , 20,20  );
  al.getParrents();
if (frameCount%200==0 && !al.parrentListIsFull) {
  al.removeBadOnes();
         for(int i = 0 ; i <10;++i)
       al.DumDumRemix(carSystem.CarControllerList.get((int)random(0,carSystem.CarControllerList.size() -1)),carSystem.CarControllerList.get((int)random(0,carSystem.CarControllerList.size() -1)));
    }
  carSystem.updateAndDisplay();
  al.killDumOne();
  
  //TESTKODE: Frastortering af dårlige biler, for hver gang der går 200 frame - f.eks. dem der kører uden for banen
  /* if (frameCount%200==0) {
      println("FJERN DEM DER KØRER UDENFOR BANEN frameCount: " + frameCount);
      for (int i = carSystem.CarControllerList.size()-1 ; i >= 0;  i--) {
        SensorSystem s = carSystem.CarControllerList.get(i).sensorSystem;
        if(s.whiteSensorFrameCount > 0){
          carSystem.CarControllerList.remove(carSystem.CarControllerList.get(i));
         }
      }
    }*/
    //
}

void mousePressed(){
    //al.DumDumRemix(carSystem.CarControllerList.get((int)random(0,carSystem.CarControllerList.size() -1)),carSystem.CarControllerList.get((int)random(0,carSystem.CarControllerList.size() -1)));
    saveTable(bilerLegacy, "data/new.csv");
    print("gemt!");
}
