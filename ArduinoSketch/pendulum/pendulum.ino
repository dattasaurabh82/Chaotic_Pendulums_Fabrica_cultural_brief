#include <Servo.h> 

Servo myservoOne;  
Servo myservoTwo;
Servo myservoThree;
Servo myservoFour;

Servo myservoFive;  
Servo myservoSix;
Servo myservoSeven;
Servo myservoEight;



int pos = 0;    
int counter = 0;

void setup() 
{ 
  myservoOne.attach(10);  
  myservoTwo.attach(A1);  
  myservoThree.attach(9);  
  myservoFour.attach(11);  

  myservoFive.attach(6);  
  myservoSix.attach(A0);   
  myservoSeven.attach(5);  
  myservoEight.attach(3);  

  //setup at 90 degree mean position
  myservoOne.write(90);  
  myservoTwo.write(90);  
  myservoThree.write(90);  
  myservoFour.write(90);  

  myservoFive.write(90);  
  myservoSix.write(90);   
  myservoSeven.write(90);  
  myservoEight.write(90);
} 

void loop() 
{ 
  if(counter <= 4){
    for(pos = 80; pos <= 100; pos += 1){
      colXServos();
      colYServos();
      delay(8);                       
    } 
    for(pos = 100; pos >= 80; pos -= 1){                                
      colXServos();
      colYServos();
      delay(8);                        
    }
  }
  counter++;
  if(counter >= 4){
    resett();
    counter = 0;
    delay(40000);
  }
}

void colXServos(){
  myservoOne.write(pos);
  myservoTwo.write(pos);
  myservoThree.write(pos);
  myservoFour.write(pos);
}

void colYServos(){
  myservoFive.write(pos);
  myservoSix.write(pos);
  myservoSeven.write(pos);
  myservoEight.write(pos);   
}

void resett(){
  myservoOne.write(90);  
  myservoTwo.write(90);  
  myservoThree.write(90);  
  myservoFour.write(90);  

  myservoFive.write(90);  
  myservoSix.write(90);   
  myservoSeven.write(90);  
  myservoEight.write(90);
}













