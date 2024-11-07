import 'package:intl/intl.dart';

class TezosBlockTransaction {
  final String hash;
  final DateTime timestamp;
  final num reward, level, fees, bonus;

  TezosBlockTransaction({
    required this.hash,
    required this.timestamp,
    required this.reward,
    required this.level,
    required this.fees,
    required this.bonus,
  });

  String get date {
    return DateFormat("yyyy-MM-dd").format(timestamp);
  }

  String get time {
    return DateFormat("HH:MM").format(timestamp);
  }

  factory TezosBlockTransaction.fromJson(Map<String, dynamic> json) {
    return TezosBlockTransaction(
      hash: json['hash'],
      timestamp: DateTime.parse(json['timestamp']),
      reward: json['reward'],
      fees: json['fees'],
      bonus: json['bonus'],
      level: json['level'],
    );
  }

  factory TezosBlockTransaction.forTest() {
    return TezosBlockTransaction(
      hash: "hash" * 10,
      timestamp: DateTime.now(),
      reward: 10,
      level: 23,
      fees: 1034,
      bonus: 9,
    );
  }
}
