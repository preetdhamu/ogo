
import 'package:hive/hive.dart';


class OHiveName {
  static final OHiveName _instance = OHiveName._internal();
  factory OHiveName() => _instance;
  OHiveName._internal();

  static const String genremovies = 'genremovies';
  
  openAllBoxes() async {
    await Hive.openBox(genremovies);
  }
}
