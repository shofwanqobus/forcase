import 'package:flutter/foundation.dart';
import 'package:forcase/database/database_helper.dart';
import 'package:forcase/models/portfolio_model.dart';
import 'package:forcase/utils/state_enum.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getPortfolio();
  }

  ResultState _resultState = ResultState.loading;
  ResultState get state => _resultState;

  String _message = '';
  String get message => _message;

  List<PortfolioItems> _items = [];
  List<PortfolioItems> get items => _items;

  void _getPortfolio() async {
    try {
      _items = await databaseHelper.getPortfolio();
      if (_items.isNotEmpty) {
        _resultState = ResultState.hasData;
      } else {
        _resultState = ResultState.noData;
        _message = 'Anda belum menambah portofolio';
      }
      notifyListeners();
    } catch (e) {
      _resultState = ResultState.error;
      _message = 'Error';
      notifyListeners();
    }
  }

  Future<bool> isPortfolio(int id) async {
    final portfolio = await databaseHelper.getPortfolioById(id);
    if (portfolio == null) {
      return false;
    }
    return portfolio.isNotEmpty;
  }

  void addPortfolio(PortfolioItems items) async {
    try {
      await databaseHelper.addPortfolio(items);
      _getPortfolio();
    } catch (e) {
      _resultState = ResultState.error;
      _message = 'Error';
      notifyListeners();
    }
  }
}
