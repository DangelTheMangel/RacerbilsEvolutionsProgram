class Algoritme{
  CarSystem carSystem;
  public ArrayList<CarController> borneBassinet = new ArrayList<CarController>();
  public boolean parrentListIsFull = false;
  
   Algoritme(CarSystem carSystem){
    this.carSystem = carSystem;
  }
  
  void killDumOne(){
    if (frameCount%200==0) {
      println("FJERN DEM DER KØRER UDENFOR BANEN frameCount: " + frameCount);
      for (int i = carSystem.CarControllerList.size()-1 ; i >= 0;  i--) {
        SensorSystem s = carSystem.CarControllerList.get(i).sensorSystem;
        if(s.whiteSensorFrameCount > 0){
          
          println("UDRYDDELSE AF: " + i );
          carSystem.CarControllerList.remove(carSystem.CarControllerList.get(i));
         }
      }
    }
  }
  
  void DumDumRemix(CarController CarCon1,CarController CarCon2){
   
    CarController controller = new CarController();
    NeuralNetwork babyBrian = controller.hjerne;
  
    
    for(int i = 0; i<babyBrian.weights.length -1 ;++i){
     if(Math.random() > .5){
     babyBrian.weights[i]=CarCon1.hjerne.weights[i];
     }else{
       babyBrian.weights[i]=CarCon2.hjerne.weights[i];
     }

    
    }
    //float list[] = controller.hjerne.weights[];
    mutate(controller);
    carSystem.CarControllerList.add(controller);
  }
  
  void getParrents(){
    if(!parrentListIsFull){
    for (int i = carSystem.CarControllerList.size()-1; i >= 0; i--) {
      CarController carCon = carSystem.CarControllerList.get(i);
      SensorSystem s = carSystem.CarControllerList.get(i).sensorSystem;
      float Greenish = carCon.sensorSystem.clockWiseRotationFrameCounter;
      if (s.passeret &&100 < Greenish  ) {
        int lapTime = carSystem.CarControllerList.get(i).sensorSystem.lapTimeInFrames ;
        
        if (lapTime < fastesTime){
        fastesTime = lapTime;
        fastesGeneration = Generation;
        }
        if (lapTime < thisGenTime){
        thisGenTime = lapTime;
        }
        
        
        borneBassinet.add(carSystem.CarControllerList.get(i));
        
        borneBassinet.get(borneBassinet.size()-1).lastLapTime = lapTime;
        
        println("Der er nu en mere i børnebassinet! og laptime var: " + borneBassinet.get(borneBassinet.size()-1).lastLapTime);}
         s.passeret = false;
      
      if (borneBassinet.size() == 10) {
        parrentListIsFull = true;
        break;
      }}
    }else{
    startNewGen();
    }
    
    
  }
  
  void startNewGen(){
  carSystem.CarControllerList.clear();
  for(int i = 0 ; i<100;++i){
    //skal skrives om så¨den gøre at de gode har bedre chance
  DumDumRemix(borneBassinet.get((int)random(0,borneBassinet.size())),borneBassinet.get((int)random(0,borneBassinet.size())));
  }
  
  for(int i = 0 ; i<borneBassinet.size();++i){
    println("parretn " + i + "lapTime: " + carSystem.CarControllerList.get(i).lastLapTime );
    float[] newWeights = borneBassinet.get(i).hjerne.weights;
    CarController controller = new CarController();
    controller.hjerne.weights = newWeights;
     carSystem.CarControllerList.add(controller);
  }
   for(int i = 0; i<borneBassinet.size();++i)
  addInfoToTable(borneBassinet.get(i));

  borneBassinet.clear();
  parrentListIsFull = false;
  lastGenTime = thisGenTime;
  thisGenTime = Integer.MAX_VALUE;
  Generation++;
  
  }
  
  void addInfoToTable(CarController CarCon1){
    ///virker ikke helt skal udaterets lidt (den smider det ind som int og ikke floats........)
TableRow newRow = bilerLegacy.addRow();
 newRow.setString(0,""+ Generation);
 newRow.setString(1, ""+CarCon1.sensorSystem.lapTimeInFrames);
 for(int i = 0; i<CarCon1.hjerne.weights.length  ;++i){
  newRow.setString(2+i, ""+CarCon1.hjerne.weights[i]);
  println("w:" +CarCon1.hjerne.weights[i] + i );
  }
  bilerLegacy.addRow(newRow);
  
  
}

  void removeBadOnes(){

     for(int i = 0 ; i <carSystem.CarControllerList.size()-1;++i){
       CarController carCon = carSystem.CarControllerList.get(i);
       float Greenish = carCon.sensorSystem.clockWiseRotationFrameCounter;
       if(10> Greenish){
        carSystem.CarControllerList.remove(i);
        i-- ;
        print(i)
        ;
       
       }
       
       
     }
      
    
}
  void printCarWeight(CarController CarCon1){
    for(int i = 0; i<CarCon1.hjerne.weights.length -1;++i){
      println(CarCon1.hjerne.weights[i]);
    }
  }
}

void mutate(CarController CarCon1){
 for(int i = 0; i<CarCon1.hjerne.weights.length -1 ;++i){
     if(Math.random() > .9){
     CarCon1.hjerne.weights[i] = random(-CarCon1.varians,CarCon1.varians);
     }
 
}




}
