//libraries for mking the applet window borderless
import java.awt.MouseInfo;
import java.awt.Point;
import processing.opengl.*;

//libraries for Kinect and GUI
import SimpleOpenNI.*;
import controlP5.*;

//Libraries for OSC communication 
import oscP5.*;
import netP5.*;

//Object Initializations for kinect and GUI. 
SimpleOpenNI  kinect;
ControlP5 cp5;

//Object Initializations for OSC
OscP5 oscP5;
NetAddress puredata;

//Object initialization for onscreen console monitor.. 
Textarea myTextarea;

int c = 0;
int mX, mY;

float sum = 0;
float previousSum = 0;
float someDifferentValue = 10;

Println console;

boolean OSC_Gate = false;

void setup() {

  /*****************************************************
   **********Setting up OSC channel informatio***********
   *****************************************************/
  oscP5 = new OscP5(this, 12000);
  //PureData address
  puredata = new NetAddress("127.0.0.1", 12000);

  ///////////////////////////////////////////////////  
  size(400, 200, OPENGL);
  
  //Initial location on desktop where the frame would be placed
  //when initialized.
  frame.setLocation(500, 200);

  ////////////////////////////////////////////////////
  kinect = new SimpleOpenNI(this);
  if (kinect.isInit() == false)
  {
    println("Can't initialize SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }
  // enable skeleton generation for all joints
  kinect.enableUser();
  /////////////////////////////////////////////////////////////
  cp5 = new ControlP5(this);
  /*********************************************
  /**********create on screen console***********
   *********************************************/
  cp5.enableShortcuts();
  frameRate(50);
  myTextarea = cp5.addTextarea("txt")
    .setPosition(100, 10)
      .setSize(280, 180)
        .setFont(createFont("", 10))
          .setLineHeight(14)
            .setColor(color(200))
              .setColorBackground(color(0, 100))
                .setColorForeground(color(255, 100));
  ;

  console = cp5.addConsole(myTextarea);

  /***************************************************
   ******Create a toggle switch to open OSC gate*******
   ***************************************************/
  cp5.addToggle("OSC_Gate")
    .setPosition(15, 10)
      .setSize(40, 40)
        .setColorBackground(color(100, 100, 100))
          .setColorForeground(color(150, 10, 56))
            .setColorActive(color(150, 10, 56))
              ;
}



void draw() {
  background(150);
  //update the cam
  kinect.update();

  //Initializing an object for wrapping the OSC message. 
  OscMessage myMessage = new OscMessage("/sumRGB");
 
 //If the open button is pressed
  if (OSC_Gate==true) {
    //send osc messages
    println("Gate opened");
    IntVector userList = new IntVector();
    kinect.getUsers(userList);

    sum = userList.size();
    println("visible people: " + " " + sum);
//Here is a trick/
//In pure data, if they continiously receive a value, they continiously
//trigger the sample player and so it never starts. 
//This simple logic here send a value that can be used by Pure data
//only when the value changes and is necessary for Pure data to know 
//the value has changed to trigger a different sample accordingly
    if (previousSum != sum) {

      myMessage.add(sum);
      oscP5.send(myMessage, puredata);
    }

    previousSum = sum;

    if (previousSum == sum) {
      myMessage.add(someDifferentValue);
      oscP5.send(myMessage, puredata);
    }
  } else {
    println("Gate Closed");
  }
}

/***************************************************
 *****shortcuts for controlling onscreen console*****
 ***************************************************/
void keyPressed() {
  switch(key) {
    case('1'):
    console.pause();
    break;
    case('2'):
    console.play();
    break;
    case('3'):
    console.clear();
    break;
  }
}


/*****************************************
 ***Frame less interaction of the window***
 *****************************************/
public void init() {
  // to make a frame not displayable, you can
  // use frame.removeNotify()
  frame.removeNotify();
  frame.setUndecorated(true);
  // addNotify, here i am not sure if you have 
  // to add notify again.  
  frame.addNotify();
  super.init();
}

void mousePressed() {
  mX = mouseX; 
  mY = mouseY;
}
void mouseDragged() {
  frame.setLocation(
  MouseInfo.getPointerInfo().getLocation().x-mX, 
  MouseInfo.getPointerInfo().getLocation().y-mY);
}

