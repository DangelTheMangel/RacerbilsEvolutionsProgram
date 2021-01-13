//populationSize: Hvor mange "controllere" der genereres, controller = bil & hjerne & sensorer
int       populationSize  = 100;     

//CarSystem: Indholder en population af "controllere" 
CarSystem carSystem       = new CarSystem(populationSize);
public ArrayList<CarController> borneBassinet = new ArrayList<CarController>();


//trackImage: RacerBanen , Vejen=sort, Udenfor=hvid, Målstreg= 100%grøn 
PImage    trackImage;

void setup() {
  size(500, 600);
  trackImage = loadImage("track.png");
}

void draw() {
  clear();
  fill(255);
  rect(0, 50, 1000, 1000);
  image(trackImage, 0, 80);  
  if (frameCount%200==0) {
    al.removeBadOnes();
    for (int i = 0; i <10; ++i)
      al.DumDumRemix(carSystem.CarControllerList.get((int)random(0, carSystem.CarControllerList.size() -1)), carSystem.CarControllerList.get((int)random(0, carSystem.CarControllerList.size() -1)));

    for (int i = carSystem.CarControllerList.size()-1; i >= 0; i--) {
      SensorSystem s = carSystem.CarControllerList.get(i).sensorSystem;
      if (s.passeret) {
        borneBassinet.add(carSystem.CarControllerList.get(i));
      }
      if (borneBassinet.size=2) {
        println("afbryd");
      }
    }
    carSystem.updateAndDisplay();


    //her laver vi en ny gen
    if (frameCount%400==0) {
      println("FJERN DEM DER KØRER UDENFOR BANEN frameCount: " + frameCount);
      for (int i = carSystem.CarControllerList.size()-1; i >= 0; i--) {
        SensorSystem s = carSystem.CarControllerList.get(i).sensorSystem;
        if (s.whiteSensorFrameCount > 0) {
          carSystem.CarControllerList.remove(carSystem.CarControllerList.get(i));
        }
        int bedste1 = 99999;
        int bedste2 = 99999;

        if (s.lapTimeInFrames > bedste1 && s.lapTimeInFrames!=10000) {
          bedste2=bedste1;
          bedste1=s.lapTimeInFrames;
        }

        /*borneBassinet.add(s);
         
         if(borneBassinet.size()==3) {
         borneBassinet.remove(0);
         }*/
      }
    }
  }
