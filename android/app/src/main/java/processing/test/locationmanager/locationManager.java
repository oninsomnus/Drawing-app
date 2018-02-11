package processing.test.locationmanager;

import processing.core.*;
import processing.data.*;
import processing.event.*; 
import processing.opengl.*;

import netP5.*;
import oscP5.*;
import ketai.net.*;

import android.content.Context;
import android.location.Location;
import android.location.LocationListener; 
import android.location.LocationManager; 
import android.os.Bundle;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.Manifest; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class locationManager extends PApplet {




OscP5 oscP5;
NetAddress remoteLocation;
String myIPAddress;
//String remoteAddress = "192.168.0.104"; //Casa
String remoteAddress = "192.168.40.65"; //Medialab

Context context;
SensorManager manager;
Sensor sensor;
AccelerometerListener  listener;
LocationManager locationManager;
MyLocationListener locationListener;

boolean hasLocation = false;
double longitud, latitud;
String provider;
float ax,ay,az;

public void setup () {
  
  orientation(PORTRAIT);  
  textAlign(CENTER, CENTER);
  textSize(30);
  requestPermission("android.permission.ACCESS_FINE_LOCATION", "initLocation");
  context = getActivity();
  manager = (SensorManager)context.getSystemService(Context.SENSOR_SERVICE);
  sensor = manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
  listener = new AccelerometerListener();
  manager.registerListener(listener, sensor, SensorManager.SENSOR_DELAY_GAME);
  initNetworkConnection();


}

public void draw() {
  background(153, 112, 255);
  text("Latitud: " + latitud + "\n" + "Longitud: " + longitud + "\n" +
                  "X: " + /*ax +*/ "\nY: " + round(ay) + "\nZ: " +
          "Provider: " + provider, 0, 0, width, height);

    OscMessage myMessage = new OscMessage("datos");
    myMessage.add(latitud);
    myMessage.add(longitud);
    myMessage.add(ay);
    myMessage.add(ax);
    myMessage.add(az);
    oscP5.send(myMessage, remoteLocation);

}

public void initLocation(boolean granted) {
  if (granted) {    
    context = getContext();
    locationListener = new MyLocationListener();
    locationManager = (LocationManager) context.getSystemService(Context.LOCATION_SERVICE);    
    locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 1000, 0, locationListener);
    hasLocation = true;
  } else {
    hasLocation = false;
  }
}

public void oscEvent(OscMessage theOscMessage){
    if (theOscMessage.checkTypetag("iii"))
    {
        longitud =  theOscMessage.get(0).doubleValue();
        latitud =  theOscMessage.get(1).doubleValue();
        ay = theOscMessage.get(2).floatValue();
        ax = theOscMessage.get(3).floatValue();

    }
}

public void initNetworkConnection(){
    oscP5 = new OscP5(this, 12000);
    remoteLocation = new NetAddress(remoteAddress, 12000);
    myIPAddress = KetaiNet.getIP();
}

class MyLocationListener implements LocationListener {
  public void onLocationChanged(Location location) {
    longitud = location.getLongitude();
    latitud = location.getLatitude();
    provider = location.getProvider();
    println(location.getLatitude(), location.getLongitude());
  }

  public void onProviderDisabled (String provider) {
      provider = "";
  }

  public void onProviderEnabled (String provider) {
      provider = provider;
  }

  public void onStatusChanged (String provider, int status, Bundle extras) {
  }
}

    class AccelerometerListener implements SensorEventListener {
        public void onSensorChanged(SensorEvent event) {
            ax = event.values[0];
            ay = event.values[1];
            az = event.values[2];
            //println("inclinacion: " + ax + ay + az);
        }
        public void onAccuracyChanged(Sensor sensor, int accuracy) {
        }
}
  public void settings() {  fullScreen(); }
}
