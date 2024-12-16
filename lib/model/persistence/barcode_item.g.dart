// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarcodeItem _$BarcodeItemFromJson(Map<String, dynamic> json) => BarcodeItem(
      $enumDecode(_$BarcodeTypeEnumEnumMap, json['barcodeType']),
      json['label'] as String,
      json['data'] as String,
    );

Map<String, dynamic> _$BarcodeItemToJson(BarcodeItem instance) =>
    <String, dynamic>{
      'barcodeType': _$BarcodeTypeEnumEnumMap[instance.barcodeType]!,
      'data': instance.data,
      'label': instance.label,
    };

const _$BarcodeTypeEnumEnumMap = {
  BarcodeTypeEnum.code39: 'code39',
};
