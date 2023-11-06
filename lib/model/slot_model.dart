class Slot {
  final String name;
  final String turfName;
  final String imgUrl;
  final String description;
  final int price;
  final int startTime;
  final int endTime;
  final int slotNum;
  final bool available;
  int slotPlayer;

  Slot({
    required this.name,
    required this.slotNum,
    required this.turfName,
    required this.imgUrl,
    required this.description,
    required this.price,
    required this.startTime,
    required this.endTime,
    required this.available,
    this.slotPlayer = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'slotNum': slotNum,
      'name': name,
      'turfName': turfName,
      'imgUrl': imgUrl,
      'description': description,
      'price': price,
      'startTime': startTime,
      'endTime': endTime,
      'available': available,
      'slotPlayer': slotPlayer
    };
  }

  Slot fromMap(Map<String, dynamic> map) {
    return Slot(
        slotNum: map['slotNum'],
        name: map['name'] ?? '',
        turfName: map['turfName'] ?? '',
        imgUrl: map['imgUrl'] ?? '',
        description: map['description'] ?? '',
        price: map['price'] ?? '',
        startTime: map['startTime'] ?? '',
        endTime: map['endTime'] ?? '',
        available: map['available'] ?? '',
        slotPlayer: map['slotPlayer'] ?? '');
  }
}
