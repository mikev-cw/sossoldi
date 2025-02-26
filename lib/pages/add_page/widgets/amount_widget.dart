import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

import '../../../constants/functions.dart';
import "../../../constants/style.dart";
import '../../../providers/currency_provider.dart';
import '../../../providers/transactions_provider.dart';

class AmountWidget extends ConsumerStatefulWidget {
  const AmountWidget(
    this.amountController, {
    super.key,
  });

  final TextEditingController amountController;

  @override
  ConsumerState<AmountWidget> createState() => _AmountWidgetState();
}

class _AmountWidgetState extends ConsumerState<AmountWidget> with Functions {
  @override
  Widget build(BuildContext context) {
    final selectedType = ref.watch(transactionTypeProvider);
    final currencyState = ref.watch(currencyStateNotifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: TextField(
        controller: widget.amountController,
        decoration: InputDecoration(
          hintText: "0",
          border: InputBorder.none,
          prefixText: ' ',
          suffixText: currencyState.selectedCurrency.symbol,
          suffixStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: typeToColor(
                  selectedType,
                  brightness: Theme.of(context).brightness,
                ),
              ),
        ),
        keyboardType:
            const TextInputType.numberWithOptions(decimal: true, signed: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'\d*\.?\d{0,2}')),
        ],
        autofocus: false,
        textAlign: TextAlign.center,
        cursorColor: grey1,
        style: TextStyle(
          color: typeToColor(
            selectedType,
            brightness: Theme.of(context).brightness,
          ),
          fontSize: 58,
          fontWeight: FontWeight.bold,
        ),
        onTapOutside: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
      ),
    );
  }
}
