

import 'package:flyerdeal/models/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flyerdeal/infrastructure/config.dart';
import 'package:flyerdeal/infrastructure/exceptions.dart';
import 'package:flyerdeal/models/location.dart';
import 'package:flyerdeal/services/map/open_street_map_service.dart';

mixin MapService {
  MapProvider provider();

  Future<List<RentXLocation>> query(final String address);

  Future<RentXLocation> exactLocation(final RentXLatLong coordinates);
}

class MapServiceFactory {
  final ConfigurationService _configurationService = ConfigurationService();

  static Map<MapProvider, OpenStreetMapService> services() {
    return {MapProvider.openStreet: OpenStreetMapService()};
  }

  Future<OpenStreetMapService> getMapService() async {
    ConfigModel configModel = await _configurationService.getConfigs();
    var mapService = services()[configModel.mapProvider];
    if (mapService == null) {
      throw ApiException('no-map-implementation',
          'No map implementation for: ${configModel.mapProvider}');
    }
    return mapService;
  }
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('location-disabled');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('location-denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('location-permanently-denied');
  }
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}

enum MapProvider { openStreet }
