import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:http/http.dart' as http;

const _URL_NEWS = 'newsapi.org';
const _API_KEY = 'c11fa6ee875f446094ebf9bdbff1578c';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';

  bool _isLoading = true;

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'healths'),
    Category(FontAwesomeIcons.vials, 'cience'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticules = {
    'general':[]
  }; 

  NewsService() {
    getTopHeadlines();
    categories.forEach((item) { 
      categoryArticules[item.name] = [];
    });
  }

  bool get isLoading => _isLoading;



  String get selectedCategory => _selectedCategory;

  set selectedCategory(String value){
    _isLoading = true;
    _selectedCategory = value;
    getArticulesByCategory(value);

    notifyListeners();
  }

  List<Article> get getArticlesCategorySelected => categoryArticules[selectedCategory]!;


  getTopHeadlines() async {
    // print('Hola Mundo');
    final uri = Uri.https(_URL_NEWS, '/v2/top-headlines',
      {
        'apiKey': _API_KEY, 
        'country': 'us',
      });
    final resp = await http.get(uri);
    final newResponse = NewsResponse.fromJson(resp.body);
    
    headlines.addAll(newResponse.articles);
    notifyListeners();
  }

  getArticulesByCategory(String category ) async{

    if( categoryArticules[category]!.isNotEmpty){
      _isLoading = false;
      return categoryArticules[category];
    }

    final uri = Uri.https(_URL_NEWS, '/v2/top-headlines',
      {
        'apiKey': _API_KEY, 
        'country': 'us',
        'category':category
      });
    final resp = await http.get(uri);
    final newResponse = NewsResponse.fromJson(resp.body);

    categoryArticules[category]?.addAll(newResponse.articles);
    
    _isLoading = false;
    notifyListeners();
  }
}
