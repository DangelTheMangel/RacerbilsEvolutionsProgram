class Algoritme {
  //det er samme carSystem som i main
  CarSystem carSystem;
  
  //listen med forældre
  public ArrayList<CarController> borneBassinet = new ArrayList<CarController>();
  //listen med forældre tider
  public ArrayList<Integer> tiderBorneBassinet = new ArrayList<Integer>();
  
  //den der siger om listen er fuld
  public boolean parrentListIsFull = false;

//når du laver klassen søger den for at den givet carsytem er lig med denne klasses
  Algoritme(CarSystem carSystem) {
    this.carSystem = carSystem;
  }

//fjerne alle dem der er kørt uden foran banen vært 200 frame
  void killDumOne() {
    if (frameCount%200==0) {
      println("FJERN DEM DER KØRER UDENFOR BANEN frameCount: " + frameCount);
      for (int i = carSystem.CarControllerList.size()-1; i >= 0; i--) {
        SensorSystem s = carSystem.CarControllerList.get(i).sensorSystem;
        if (s.whiteSensorFrameCount > 0) {

          println("UDRYDDELSE AF: " + i );
          carSystem.CarControllerList.remove(carSystem.CarControllerList.get(i));
        }
      }
    }
  }

  //det er denne tager for to forældre til at lave et "barn"
  void DumDumRemix(CarController CarCon1, CarController CarCon2) {

    CarController controller = new CarController();
    NeuralNetwork babyBrian = controller.hjerne;


    for (int i = 0; i<babyBrian.weights.length -1; ++i) {
      if (Math.random() > .5) {
        babyBrian.weights[i]=CarCon1.hjerne.weights[i];
      } else {
        babyBrian.weights[i]=CarCon2.hjerne.weights[i];
      }
    }
    //float list[] = controller.hjerne.weights[];
    mutate(controller);
    carSystem.CarControllerList.add(controller);
  }
  
  //finder forældrne oig sætter næste generation igang
  void getParrents() {
    if (!parrentListIsFull) {
      for (int i = carSystem.CarControllerList.size()-1; i >= 0; i--) {
        CarController carCon = carSystem.CarControllerList.get(i);
        SensorSystem s = carSystem.CarControllerList.get(i).sensorSystem;
        float Greenish = carCon.sensorSystem.clockWiseRotationFrameCounter;
        if (s.passeret &&60 < Greenish  ) {
          int lapTime = carSystem.CarControllerList.get(i).sensorSystem.lapTimeInFrames ;

          if (lapTime < fastesTime) {
            fastesTime = lapTime;
            fastesGeneration = Generation;
          }
          if (lapTime < thisGenTime) {
            thisGenTime = lapTime;
          }


          borneBassinet.add(carSystem.CarControllerList.get(i));
          tiderBorneBassinet.add(lapTime);


          println("Der er nu en mere i børnebassinet! og laptime var: " + lapTime);
        }
        s.passeret = false;

        if (borneBassinet.size() == 10) {
          parrentListIsFull = true;
          break;
        }
      }
    } else {
      startNewGen(true);
    }
  }
  
  //det er denne funktion som tager de sidste 10 forældre fra csv filen og tilføjer dem til simulation igen
  void getOldParrents() {
    for (int i = bilerLegacy.getRowCount()-10; i<bilerLegacy.getRowCount(); ++i) {
      CarController carcon = new CarController();
      carcon = extrakOldParrent(carcon, i);
      borneBassinet.add(carcon);
      tiderBorneBassinet.add(bilerLegacy.getInt(i, 1));
    }
  }
  
  //den udfylder daten til getOldParrents()
  CarController extrakOldParrent(CarController carcon, int j) {
    float[] newWeights = new float[8];
    for (int i = 0; i<newWeights.length; ++i) {
      newWeights[i] = bilerLegacy.getFloat(j, 2+i);
    }
    carcon.hjerne.weights = newWeights;
    return carcon;
  }
  
  //det er denne funktion der står for at sætte en ny generation igang
  void startNewGen(boolean addToTable) {
    carSystem.CarControllerList.clear();
    for (int i = 0; i<100; ++i) {
      //skal skrives om så¨den gøre at de gode har bedre chance
      DumDumRemix(parrentRollet(), parrentRollet());
    }

    for (int i = 0; i<borneBassinet.size(); ++i) {
      println("parretn " + i + "lapTime: " +  tiderBorneBassinet.get(i));

      // her tager vi forældrne og lægger dem i csv filen
      //borneBassinet.get(i).hjerne.newList(tiderBorneBassinet.get(i));
      //
      float[] newWeights = borneBassinet.get(i).hjerne.weights;
      CarController controller = new CarController();
      controller.hjerne.weights = newWeights;
      carSystem.CarControllerList.add(controller);
    }
    if ( addToTable) {
      for (int i = 0; i<borneBassinet.size(); ++i)
        addInfoToTable(borneBassinet.get(i));
    }

    borneBassinet.clear();
    tiderBorneBassinet.clear();
    parrentListIsFull = false;
    lastGenTime = thisGenTime;
    thisGenTime = Integer.MAX_VALUE;

    Generation++;
  }
  
  
  //tilføjer generation til tablen
  void addInfoToTable(CarController CarCon1) {
    ///virker ikke helt skal udaterets lidt (den smider det ind som int og ikke floats........)
    TableRow newRow = bilerLegacy.addRow();
    newRow.setString(0, ""+ Generation);
    newRow.setString(1, ""+CarCon1.sensorSystem.lapTimeInFrames);
    for (int i = 0; i<CarCon1.hjerne.weights.length; ++i) {
      newRow.setString(2+i, ""+CarCon1.hjerne.weights[i]);
      println("w:" +CarCon1.hjerne.weights[i] + i );
    }
  }
  
  //tager tablens data og sørger for at det passer med hvad stats viser
  void updateDisplayFromTable() {
    int size = bilerLegacy.getRowCount();
    for (int i = 1; i<size; ++i) {
      int lapTime = bilerLegacy.getInt(i, 1);
      if (lapTime < fastesTime) {
        fastesTime = lapTime;
        fastesGeneration = bilerLegacy.getInt(i, 0) ;
      }
    }

    for (int i = size-10; i<size; ++i) {
      int lapTime = bilerLegacy.getInt(i, 1);
      if (lapTime < thisGenTime) {
        thisGenTime = lapTime;
      }
    }

    for (int i = size-20; i<size-10; ++i) {
      int lapTime = bilerLegacy.getInt(i, 1);
      if (lapTime < lastGenTime) {
        lastGenTime = lapTime;
      }
    }
  }

  
  //fjerne dem der står forstilel forlænge
  void removeBadOnes() {

    for (int i = 0; i <carSystem.CarControllerList.size()-1; ++i) {
      CarController carCon = carSystem.CarControllerList.get(i);
      float Greenish = carCon.sensorSystem.clockWiseRotationFrameCounter;
      if (10> Greenish) {
        carSystem.CarControllerList.remove(i);
        i-- ;
        print(i)
          ;
      }
    }
  }
  
  //tager forældre og parrene dem med hindane der er større chance for at blive valgt vis du har kørt hurtigts
  CarController parrentRollet() {
    CarController carcon = new CarController();
    for (int i = 0; i<borneBassinet.size()-1; ++i) {
      if (i == 0) {
        carcon = borneBassinet.get((int)random(0, borneBassinet.size()));
      }
      int lapTime =tiderBorneBassinet.get(i);
      float chance =  lapTime/100;
      if (random(0, 100)> chance) {
        carcon = borneBassinet.get(i);
      }
    }


    return carcon;
  }
  
  //skriver vægten ud på bilerne
  void printCarWeight(CarController CarCon1) {
    for (int i = 0; i<CarCon1.hjerne.weights.length -1; ++i) {
      println(CarCon1.hjerne.weights[i]);
    }
  }
}

//tager bilener og mutere dem lidt
void mutate(CarController CarCon1) {
  for (int i = 0; i<CarCon1.hjerne.weights.length -1; ++i) {
    if (Math.random() > .9) {
      CarCon1.hjerne.weights[i] = random(-CarCon1.varians, CarCon1.varians);
    }
  }
}
