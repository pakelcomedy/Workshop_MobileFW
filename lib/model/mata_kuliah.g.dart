// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mata_kuliah.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MataKuliah _$MataKuliahFromJson(Map<String, dynamic> json) => MataKuliah(
  nama_mk: json['nama_mk'] as String,
  sks_mk: (json['sks_mk'] as num).toInt(),
  kode_mk: json['kode_mk'] as String,
  dosen_mk: json['dosen_mk'] as String,
  jam_kuliah: json['jam_kuliah'] as String,
  semester_tempuh: (json['semester_tempuh'] as num).toInt(),
);

Map<String, dynamic> _$MataKuliahToJson(MataKuliah instance) =>
    <String, dynamic>{
      'nama_mk': instance.nama_mk,
      'sks_mk': instance.sks_mk,
      'kode_mk': instance.kode_mk,
      'dosen_mk': instance.dosen_mk,
      'jam_kuliah': instance.jam_kuliah,
      'semester_tempuh': instance.semester_tempuh,
    };