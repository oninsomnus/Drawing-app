import netP5.*;
import oscP5.*;

OscP5 oscP5;
NetAddress remoteLocation;
double latitud, longitud;
float ay, ax, az, xCurve, anguloX, puntoX, yCurve, puntoY, movA, movB;

void setup() {
  fullScreen();
  //size(displayWidth, 800);
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
  float disX = map(latAb, 0.179730, 0.179735, 10, 20);
  float disY = map(lonY, 0, 1.5, 10, height);
  float direccion = 1;
 
  
  background(0);
  fill(mapAx, mapAy, mapAz, 155);
  noStroke();
  /*text("disX: " + disX + "\n" + "Latitud: " + latAb + "\n" +
    "X: " + mapAx + "\nY: " + mapAy + "\nZ: " + mapAz, 
    0, 0, width, height);*/
 
  xCurve = width/2;
  anguloX = map(mapAx, 0, 255, -width*5, width*5);
  puntoX = map(varAx, -10, 10, 0, 1920);
  yCurve = map(varAx, 10, -10, 0, 1920);
  puntoY = map(varAy, 10, -10, 400, 5000);

  stroke(mapAx, mapAy, mapAz, 10);
  noFill();
  
  for (int i = 0; i < 100; i++){
    strokeWeight(i/5);
  //curve(xCurve, 0, xCurve, height, puntoX+i*5, 0, xCurve+anguloX, 0);
  //curve(xCurve, 0, xCurve, height, yCurve+i*5, 0, xCurve-anguloX, 0);
  //curve(xCurve, 0, puntoX+i*5, height, xCurve, 0, xCurve+anguloX, 0);
  curve(xCurve, 800-puntoY, yCurve+i*5, height, xCurve,  200, xCurve-anguloX, puntoY);
  curve(xCurve, 800-puntoY, yCurve+i*5, height, xCurve+400,  200, xCurve-anguloX, puntoY);
  curve(xCurve, 800-puntoY, yCurve+i*5, height, xCurve+400/2,  400, xCurve-anguloX, puntoY);
  }
  
  println(movA +"..."+movB+"..."+direccion);
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