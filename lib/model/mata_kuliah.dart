import 'package:json_annotation/json_annotation.dart';
part 'mata_kuliah.g.dart';

@JsonSerializable()
class MataKuliah {
  String nama_mk;
  int sks_mk;
  String kode_mk;
  String dosen_mk;
  String jam_kuliah;
  int semester_tempuh;

  MataKuliah({
    required this.nama_mk,
    required this.sks_mk,
    required this.kode_mk,
    required this.dosen_mk,
    required this.jam_kuliah,
    required this.semester_tempuh,
  });

  factory MataKuliah.fromJson(Map<String, dynamic> json) => _$MataKuliahFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MataKuliahToJson(this);
}