#include <Servo.h> 

//initilaize set of servos in linear direction 
Servo myservoOne;  
Servo myservoTwo;
Servo myservoThree;
Servo myservoFour;

//initialize set of servos in perpendicular direction
Servo myservoFive;  
Servo myservoSix;
Servo myservoSeven;
Servo myservoEight;



int pos = 0;  // variable to certain position in servos  
int counter = 0; //variable to keep track of how many times the servos
                 // should oscillate before stopping.. 

void setup() 
{ 
  //assigning the servos their corresponding pins.
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
  if(counter <= 4){ //you can play with the counter value
                    //it is just to assign how many times 
                    //it would oscillate before stopping
                    
    /*This portion is just the for loops making the 
    servo go to and fr****************************/
    for(pos = 80; pos <= 100; pos += 1){
      colXServos();
      colYServos();
      delay(8);  // you can play with the delay values as well
                 // for how rapidly they act
                 // or jow much noise they create      
    } 
    for(pos = 100; pos >= 80; pos -= 1){                                
      colXServos();
      colYServos();
      delay(8);                        
    }
  }
  /****Finish of one round of oscillation: back and forth*****/
  
  //After one complete back and forth oscillation
  //the counter increments by one and checks if it's 
  //more or less than the an assigned value. Here it's my choice of 4 rounds
  //so the checking value is 4. 
  //If it's not 4 it goes back to the top of loop and does one more oscillation
  //cycle and checks again till the counter becomes 4.
  
  counter++; 
  if(counter >= 4){
    //when the value reaches 4 the counter is set to 0 again
    //but before that the whole setup is stopped for 40 seconds 
    resett();
    counter = 0;
    delay(40000);
  }
}

/*************These are consiquitive functions writing servo pisitions******************/
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

/***************A reset function setting every servo position to
90 degrees when sopped*****************************************/
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













