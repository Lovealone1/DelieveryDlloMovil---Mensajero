import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:food_delievery_domiciliario/constant/constant.dart';
import 'package:food_delievery_domiciliario/controller/services/locationServices/locationServices.dart';
import 'package:geolocator/geolocator.dart';

class GeofireServices {
  static DatabaseReference databaseReference = FirebaseDatabase.instance
      .ref()
      .child('Driver/${auth.currentUser!.uid}/driverStatus');

  static goOnline() async {
    Position currentPosition = await LocationServices.getCurrentLocation();
    Geofire.initialize('OnlineDrivers');
    Geofire.setLocation(
      auth.currentUser!.uid,
      currentPosition.latitude,
      currentPosition.longitude,
    );
    databaseReference.set('ONLINE');
    databaseReference.onValue.listen((event) { });
  }

  static goOffline() {
    Geofire.removeLocation(auth.currentUser!.uid);
    databaseReference.set('OFFLINE');
    databaseReference.onDisconnect();
  }
}
