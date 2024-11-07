import 'package:busha_app/data/models/local/coin_type.dart';
import 'package:busha_app/data/services/block_transaction_service.dart';
import 'package:busha_app/presentation/block_transaction/block_transaction_screen.dart';
import 'package:busha_app/presentation/block_transaction/cubit/block_transaction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'data/services/fake_block_transaction_service.dart';

GetIt getIt = GetIt.instance;

void main() {
  late BlockTransactionService blockService;
  late BlockTransactionCubit blockCubit;

  setUp(() {
    blockService = FakeBlockTransactionService();
    blockCubit = BlockTransactionCubit(blockService);
    getIt.registerFactory(() => blockCubit);
  });

  tearDown(() => getIt.reset());

  testWidgets('Verify that the right coin short-name is shown on the appBar', (WidgetTester tester) async {
    //Arrange - Pump MyApp() widget to tester
    await tester.pumpWidget(const MaterialApp(home: BlockTransactionScreen(coinType: CoinType.bitcoin)));

    expect(find.text("${CoinType.bitcoin.shortName} Transactions"), findsOneWidget);
  });

  testWidgets('Verify that btc block transactions are shown on the screen', (WidgetTester tester) async {
    //Arrange - Pump MyApp() widget to tester
    await tester.pumpWidget(const MaterialApp(home: BlockTransactionScreen(coinType: CoinType.bitcoin)));

    expect(find.text("${CoinType.bitcoin.shortName} Transactions"), findsOneWidget);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key("blockTransactionsListView")), findsOneWidget);
    expect(find.byKey(const Key("transactionBlockErrorSection")), findsNothing);
  });
}
