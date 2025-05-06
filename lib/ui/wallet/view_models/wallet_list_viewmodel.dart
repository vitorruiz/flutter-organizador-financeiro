import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../../../domain/entities/investment_wallet.dart';
import '../../../domain/repository/investment_wallet_repository.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';

class WalletListViewmodel extends ChangeNotifier {
  WalletListViewmodel({required InvestmentWalletRepository investmentWalletRepository})
    : _investmentWalletRepository = investmentWalletRepository {
    loadWalletList = Command0(_loadWalletList)..execute();
    deleteWallet = Command1(_deleteWallet);
    saveOrUpdateWallet = Command1(_saveOrUpdateWallet);
  }

  final Logger _log = Logger('WalletListViewmodel');

  final InvestmentWalletRepository _investmentWalletRepository;

  late final Command0 loadWalletList;
  late final Command1<void, int> deleteWallet;
  late final Command1<void, InvestmentWallet> saveOrUpdateWallet;

  List<InvestmentWallet> _walletList = <InvestmentWallet>[];
  List<InvestmentWallet> get walletList => _walletList;

  Future<Result<void>> _loadWalletList() async {
    try {
      final Result<List<InvestmentWallet>> result = Result.ok(
        await _investmentWalletRepository.getAll(),
      );
      switch (result) {
        case Error():
          _log.warning('Failed to load stored Wallet', result.error);
          return result;
        case Ok():
      }
      _walletList = result.value;
      _log.info('Wallet loaded successfully: $_walletList');
      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _deleteWallet(int id) async {
    try {
      final Result<bool> result = Result.ok(await _investmentWalletRepository.remove(id));
      switch (result) {
        case Error():
          _log.warning('Failed to delete Wallet', result.error);
          return result;
        case Ok():
      }
      _log.info('Wallet deleted successfully: $id');
      return result;
    } finally {
      notifyListeners();
      loadWalletList.execute();
    }
  }

  Future<Result<void>> _saveOrUpdateWallet(InvestmentWallet wallet) async {
    try {
      final Result<int> result = Result.ok(await _investmentWalletRepository.create(wallet));
      switch (result) {
        case Error():
          _log.warning('Failed to save or update Wallet', result.error);
          return result;
        case Ok():
      }
      _log.info('Wallet saved or updated successfully: ${wallet.name}');
      return result;
    } finally {
      notifyListeners();
      loadWalletList.execute();
    }
  }
}
