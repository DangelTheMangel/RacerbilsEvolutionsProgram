class Algoritme{
  CarSystem carSystem;
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
