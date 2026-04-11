
import 'package:ecogo/core/models/material_item.dart';

class Configuration {
  final int reportLimit;
  final int collectionKilos;
  final int recyclingKilos;
  final List<MaterialItem> materials;

  Configuration({
    required this.reportLimit,
    required this.collectionKilos,
    required this.recyclingKilos,
    required this.materials,
  });

  // Factory method to parse JSON into a Configuration object
  factory Configuration.fromJson(Map<String, dynamic> json) {

    print("aquii el json ${json}");
    var jsonData = json["configurations"];
    return Configuration(
      reportLimit: int.parse(jsonData['report_limit']) ?? 0,
      collectionKilos: int.parse(jsonData['collection_kilos']) ?? 0,
      recyclingKilos: int.parse(jsonData['recycling_kilos']) ?? 0,
      materials: (jsonData['materials'] as List)
          .map((materialJson) => MaterialItem.fromJson(materialJson))
          .toList(),
    );
  }
}
