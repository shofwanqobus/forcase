import 'package:flutter/foundation.dart';
import 'package:forcase/database/database_helper.dart';
import 'package:forcase/models/portfolio_model.dart';
import 'package:forcase/utils/state_enum.dart';

class FavoriteDatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  FavoriteDatabaseProvider({required this.databaseHelper}) {
    getFavoritePortfolios();
  }

  ResultState _portfolioState = ResultState.loading;
  ResultState get portfolioState => _portfolioState;

  String _message = '';
  String get message => _message;

  List<PortfolioItems> _items = [];
  List<PortfolioItems> get items => _items;

  void getFavoritePortfolios() async {
    try {
      _items = await databaseHelper.getFavoritePortfolio();

      if (_items.isNotEmpty) {
        _portfolioState = ResultState.hasData;
      } else {
        _portfolioState = ResultState.noData;
        _message = 'Favorite empty';
      }
      notifyListeners();
    } catch (e) {
      _portfolioState = ResultState.error;
      _message = "error";
      notifyListeners();
    }
  }

  void addFavPortfolio(PortfolioItems portfolioItems) async {
    try {
      await databaseHelper.addFavPortfolio(portfolioItems);
      getFavoritePortfolios();
    } catch (e) {
      _portfolioState = ResultState.error;
      _message = 'failed to add favorite';
      notifyListeners();
    }
  }

  bool _isFavPortfolio = false;
  bool get isFavPortfolio => _isFavPortfolio;

  Future<bool> isFavPortfolioById(int id) async {
    final result = await databaseHelper.getFavoritePortfolioById(id);

    if (result) {
      _isFavPortfolio = true;
      notifyListeners();
      return true;
    } else {
      _isFavPortfolio = false;
      notifyListeners();
      return false;
    }
  }

  void removeFavPortfolio(int id) async {
    try {
      await databaseHelper.removeFavPortfolio(id);
      getFavoritePortfolios();
    } catch (e) {
      _portfolioState = ResultState.error;
      _message = 'failed to remove favorite';
      notifyListeners();
    }
  }

  Future<void> setFavoritePortfolio(PortfolioItems items) async {
    final isExists = await databaseHelper.getFavoritePortfolioById(items.id);

    if (isExists) {
      await databaseHelper.removeFavPortfolio(items.id);
    } else {
      await databaseHelper.addFavPortfolio(items);
    }

    isFavPortfolioById(items.id);
  }
}
