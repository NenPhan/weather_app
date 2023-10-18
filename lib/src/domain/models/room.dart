part of mapper;

@JsonSerializable()
class Room {
  String? id;
  String? roomName;

  Room({
    this.id,
    this.roomName,
  });

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  Map<String, dynamic> toJson() => _$RoomToJson(this);
}
