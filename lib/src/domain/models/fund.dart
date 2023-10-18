part of mapper;

@JsonSerializable()
class Fund {
  String? id;
  String? name;
  int? amount;

  Fund({
    this.id,
    this.name,
    this.amount,
  });

  factory Fund.fromJson(Map<String, dynamic> json) => _$FundFromJson(json);

  Map<String, dynamic> toJson() => _$FundToJson(this);
}
