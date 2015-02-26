import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.awt.MouseInfo; 
import java.awt.Point; 
import processing.opengl.*; 
import SimpleOpenNI.*; 
import controlP5.*; 
import oscP5.*; 
import netP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Kinect_get_user_send_to_pd____basic extends PApplet {












SimpleOpenNI  kinect;
ControlP5 cp5;

OscP5 oscP5;
NetAddress puredata;

Textarea myTextarea;

int c = 0;
int mX, mY;

float sum = 0;
float previousSum = 0;
float someValue = 10;

Println console;

boolean OSC_Gate = false;

public void setup() {

  /*****************************************************
   **********Setting up OSC channel informatio***********
   *****************************************************/
  oscP5 = new OscP5(this, 12000);
  //PureData address
  puredata = new NetAddress("127.0.0.1", 12000);

  ///////////////////////////////////////////////////  
  size(400, 200, OPENGL);
  //size(400, 200, P3D);
  //frame.setResizable(true);
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



public void draw() {
  background(150);
  //update the cam
  kinect.update();


  OscMessage myMessage = new OscMessage("/sumRGB");

  if (OSC_Gate==true) {
    //send osc messages
    println("Gate opened");
    IntVector userList = new IntVector();
    kinect.getUsers(userList);

    sum = userList.size();
    println("visible people: " + " " + sum);

    if (previousSum != sum) {

      myMessage.add(sum);
      oscP5.send(myMessage, puredata);
    }

    previousSum = sum;

    if (previousSum == sum) {
      myMessage.add(someValue);
      oscP5.send(myMessage, puredata);
    }
  } else {
    println("Gate Closed");
  }
}

/***************************************************
 *****shortcuts for controlling onscreen console*****
 ***************************************************/
public void keyPressed() {
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

public void mousePressed() {
  mX = mouseX; 
  mY = mouseY;
}
public void mouseDragged() {
  frame.setLocation(
  MouseInfo.getPointerInfo().getLocation().x-mX, 
  MouseInfo.getPointerInfo().getLocation().y-mY);
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Kinect_get_user_send_to_pd____basic" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
