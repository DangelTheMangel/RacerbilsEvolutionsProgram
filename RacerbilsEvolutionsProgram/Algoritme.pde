class Algoritme{
  CarSystem carSystem;
 Algoritme(CarSystem carSystem){
    this.carSystem = carSystem;
  
  }
  
  void killDumOne(){
  
  }
  
  
  void DumDumRemix(CarController CarCon1,CarController CarCon2){
    CarController controller = new CarController();
    NeuralNetwork babyBrian = controller.hjerne;
    println("parrent 1: ");
    printCarWeight(CarCon1);
    println("parrent 2: ");
    printCarWeight(CarCon2);
    
    for(int i = 0; i<babyBrian.weights.length -1 ;++i){
     if(Math.random() > .5){
     babyBrian.weights[i]=CarCon1.hjerne.weights[i];
     }else{
       babyBrian.weights[i]=CarCon2.hjerne.weights[i];
     }
    println("child: ");
    printCarWeight(controller);
    }
    //float list[] = controller.hjerne.weights[];
    mutate(controller);
    carSystem.CarControllerList.add(controller);
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
 
}}
