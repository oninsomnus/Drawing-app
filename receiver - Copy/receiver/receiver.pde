import netP5.*;
import oscP5.*;

OscP5 oscP5;
NetAddress remoteLocation;
double latitud, longitud;
float ay, ax, az;
float b;
boolean curva = true;

void setup() {
  //fullScreen();
  size(displayWidth, 800);
  oscP5 = new OscP5(this, 12000);
  // remoteLocation = new NetAddress("127.0.0.1", 12000); //Casa
  textAlign(CENTER, CENTER);
  textSize(30);
}



void draw() {
  int varAy = round(ay);
  int mapAy = round(map(varAy, -10, 10, 0, 255));
  int varAx = round(ax);
  int mapAx = round(map(varAx, -10, 10, 0, 255));
  int varAz = round(az);
  int mapAz = round(map(varAz, -10, 10, 0, 255));
  float latX = (float)latitud;
  float latAb = abs(latX);
  float lonY = (float)longitud*-1;
  float disX = map(latAb, 0.179711, 0.179719, 10, width);
  float disY = map(lonY, 0, 1.5, 10, height);
  background(mapAy, mapAx, mapAz);
  fill(255);
  text("Latitud: " + disX + "\n" + "Longitud: " + lonY + "\n" +
    "X: " + mapAx + "\nY: " + mapAy + "\nZ: " + mapAz, 
    0, 0, width, height);
  println(latitud);
  
  b = b + 0.5;
  forma(b);
  
  if (b >= 20){
    b = b - 0.5;
    curva = false;
  }
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkTypetag("ddfff")) {
    latitud =  theOscMessage.get(0).doubleValue();
    longitud =  theOscMessage.get(1).doubleValue();
    ay = theOscMessage.get(2).floatValue();
    ax = theOscMessage.get(3).floatValue();
    az = theOscMessage.get(4).floatValue();
  }
}