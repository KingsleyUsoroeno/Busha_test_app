import 'package:intl/intl.dart';

class BlockTransaction {
  final String hash;
  final DateTime transactionTime;
  final int size;
  final num blockIndex;
  final num blockHeight;

  BlockTransaction({
    required this.hash,
    required this.transactionTime,
    required this.size,
    required this.blockIndex,
    required this.blockHeight,
  });

  String get date {
    return DateFormat("yyyy-MM-dd").format(transactionTime);
  }

  String get time {
    return DateFormat("HH:MM").format(transactionTime);
  }

  factory BlockTransaction.fromJson(Map<String, dynamic> json) {
    return BlockTransaction(
      hash: json['hash'],
      transactionTime: DateTime.fromMillisecondsSinceEpoch(json['time'] * 1000),
      blockIndex: json['block_index'],
      size: json['size'],
      blockHeight: json['block_height'],
    );
  }

  factory BlockTransaction.forTest() {
    return BlockTransaction(
      hash: "hash" * 10,
      transactionTime: DateTime.now(),
      size: 10,
      blockHeight: 23,
      blockIndex: 1034,
    );
  }
}
