class CableModel {
  int? id;
  String? name;
  String? location;
  int? number;
  String? gateType;
  int? gateNumber;
  int? qaem;
  int? port;
  int? mainCable;
  int? tank;
  int? cable;
  int? box;
  int? terminal;
  String? house;

  CableModel(
      {this.id,
      this.name,
      this.location,
      this.number,
      this.gateType,
      this.gateNumber,
      this.qaem,
      this.port,
      this.mainCable,
      this.tank,
      this.cable,
      this.box,
      this.terminal,
      this.house});

  CableModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    number = json['number'];
    gateType = json['gateType'];
    gateNumber = json['gateNumber'];
    qaem = json['qaem'];
    port = json['port'];
    mainCable = json['mainCable'];
    tank = json['tank'];
    cable = json['cable'];
    box = json['box'];
    terminal = json['terminal'];
    house = json['house'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['number'] = this.number;
    data['gateType'] = this.gateType;
    data['gateNumber'] = this.gateNumber;
    data['qaem'] = this.qaem;
    data['port'] = this.port;
    data['mainCable'] = this.mainCable;
    data['tank'] = this.tank;
    data['cable'] = this.cable;
    data['box'] = this.box;
    data['terminal'] = this.terminal;
    data['house'] = this.house;
    return data;
  }
}
