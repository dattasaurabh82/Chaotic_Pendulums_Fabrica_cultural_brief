//import codeanticode.gsvideo.*;
import processing.video.*;

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress puredata;

float sum = 2;
float previousSum = 0; 

void setup() {
  size(640, 480);

  oscP5 = new OscP5(this, 12000);
  // PureData address
  puredata = new NetAddress("127.0.0.1", 12000);
  frameRate(15);
}

void draw() {



  float test = 10;

  OscMessage myMessage = new OscMessage("/sumRGB");

  if (previousSum != sum) {

    myMessage.add(sum);
    oscP5.send(myMessage, puredata);
  }
  
  previousSum = sum;

  if (previousSum == sum) {
    myMessage.add(test);
    oscP5.send(myMessage, puredata);
  }
}

