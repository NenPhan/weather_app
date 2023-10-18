// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_mapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
      id: json['id'] as String?,
      roomName: json['roomName'] as String?,
    );

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'id': instance.id,
      'roomName': instance.roomName,
    };

Fund _$FundFromJson(Map<String, dynamic> json) => Fund(
      id: json['id'] as String?,
      name: json['name'] as String?,
      amount: json['amount'] as int?,
    );

Map<String, dynamic> _$FundToJson(Fund instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount': instance.amount,
    };
