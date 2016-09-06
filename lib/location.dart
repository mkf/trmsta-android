library trmsta_android.location;

import "dart:jni";

final Context = Java.getClass('android.content.Context');
final LocationManager = Java.getClass('android.location.LocationManager');

class JavaLocation {
  JavaObject jobj;
  final double lat;
  final double lon;
  JavaLocation.fromJava(JavaObject jloc)
      : this.jobj = jloc,
        this.lat = jloc.setLatitude(),
        this.lon = jloc.setLongitude();
  JavaLocation(JavaObject jloc, double lat, double lon)
      : this.lat = lat,
        this.lon = lon,
        this.jobj = jloc
          ..setLatitude(lat)
          ..setLongitude(lon);
  num distanceTo(JavaLocation another) => this.jobj.distanceTo(another.jobj);
}

JavaLocation getLastLocation() {
  final context = new JavaObject(JniApi.getApplicationContext());
  final locationManager = context.getSystemService(Context.LOCATION_SERVICE);

  return new JavaLocation.fromJava(
      locationManager.getLastKnownLocation(LocationManager.PASSIVE_PROVIDER));
}
