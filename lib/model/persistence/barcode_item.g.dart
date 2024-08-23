// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarcodeItem _$BarcodeItemFromJson(Map<String, dynamic> json) => BarcodeItem(
      $enumDecode(_$BarcodeTypeEnumMap, json['barcodeType']),
      json['label'] as String,
      json['data'] as String,
    );

Map<String, dynamic> _$BarcodeItemToJson(BarcodeItem instance) =>
    <String, dynamic>{
      'barcodeType': _$BarcodeTypeEnumMap[instance.barcodeType]!,
      'data': instance.data,
      'label': instance.label,
    };

const _$BarcodeTypeEnumMap = {
  BarcodeType.code39: 'code39',
};
