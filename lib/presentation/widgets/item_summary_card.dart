import 'package:flutter/material.dart';
import 'package:meu_patrimonio/common/utils.dart';

class ItemSummaryCard extends StatelessWidget {
  
  const ItemSummaryCard({
    Key? key,
    required this.title,
    required this.balance,
    this.rentability,
    this.onClick,
  }) : super(key: key);

  final String title;
  final String? rentability;
  final double balance;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(title, style: Theme.of(context).textTheme.titleLarge),
                ),
                Center(
                  child: Text(
                    "Total: ${formatToCurrency(balance)}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Center(
                  child: Visibility(
                    child: Text("Rentabilidade: $rentability", style: Theme.of(context).textTheme.bodyLarge),
                    visible: rentability?.isNotEmpty == true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
