import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_patrimonio/presentation/blocs/account_balance_notifier.dart';
import 'package:meu_patrimonio/presentation/pages/create_balance_page.dart';
import 'package:meu_patrimonio/presentation/widgets/item_summary_card.dart';

class BalanceListPage extends ConsumerWidget {
  const BalanceListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountBalanceList = ref.watch(accountBalanceListProvider);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child:
            accountBalanceList.isNotEmpty
                ? ListView.builder(
                  itemBuilder: (context, index) {
                    final account = accountBalanceList[index];
                    return ItemSummaryCard(
                      title: account.name,
                      balance: account.balance,
                      onClick: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateBalancePage(account: account)));
                      },
                    );
                  },
                  itemCount: accountBalanceList.length,
                )
                : Center(child: const Text("Você ainda não possui nenhuma conta")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CreateBalancePage()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// class _BalanceListPageState extends ConsumerState<BalanceListPage> {
//   AccountBalanceNotifier? _accountBalanceNotifier;

//   @override
//   void initState() {
//     super.initState();
//     _accountBalanceNotifier = ref.read(accountBalanceListProvider.notifier);
//   }

//   void _update() {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Contas")),
//       body: FutureBuilder<List<AccountBalance>>(
//         future: _repository.getBalances(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else {
//             return Container(
//               padding: const EdgeInsets.all(24.0),
//               child: ListView.builder(
//                 itemBuilder: (context, index) {
//                   if (snapshot.data != null) {
//                     final account = snapshot.data![index];
//                     return ItemSummaryCard(
//                       title: account.name,
//                       balance: account.balance,
//                       onClick: () async {
//                         await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateBalancePage(account: account)));
//                         _update();
//                       },
//                     );
//                   }
//                   return const Center();
//                 },
//                 itemCount: snapshot.data != null ? snapshot.data!.length : 0,
//               ),
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           await Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CreateBalancePage()));
//           _update();
//         },
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
