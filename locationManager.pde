import android.content.Context;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.Manifest;

LocationManager locationManager;
MyLocationListener locationListener;

boolean hasLocation = false;

void setup () {
  fullScreen();
  orientation(PORTRAIT);  
  textFont(createFont("SansSerif", 26 * displayDensity));
  textAlign(CENTER, CENTER);
  requestPermission("android.permission.ACCESS_FINE_LOCATION", "initLocation");
}

void draw() {
}

void initLocation(boolean granted) {
  if (granted) {    
    Context context = getContext();
    locationListener = new MyLocationListener();
    locationManager = (LocationManager) context.getSystemService(Context.LOCATION_SERVICE);    
    locationManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 0, 0, locationListener);
    hasLocation = true;
  } else {
    hasLocation = false;
  }
}

class MyLocationListener implements LocationListener {
  public void onLocationChanged(Location location) {
    println(location.getLatitude(), location.getLongitude());
  }

  public void onProviderDisabled (String provider) { }

  public void onProviderEnabled (String provider) { }

  public void onStatusChanged (String provider, int status, Bundle extras) {
  }
}