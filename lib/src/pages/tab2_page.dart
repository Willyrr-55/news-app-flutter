import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/theme/theme.dart';
import 'package:provider/provider.dart';

import '../widgets/list_news.dart';

class Tab2Page extends StatelessWidget {
   
  const Tab2Page({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {

  final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children:  <Widget>[
            _ListCagetories(),

            if(!newsService.isLoading)
            Expanded(
              child: ListNews(newsService.getArticlesCategorySelected)
            ),

            if(newsService.isLoading)
            const CircularProgressIndicator()
            
          ]
        ),
      ),
    );
  }
}

class _ListCagetories extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;
    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index){
    
          final cName = categories[index].name;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children:  <Widget>[
                _CategoryButton(categories[index]),
                const SizedBox(height: 5),
                Text( '${cName[0].toUpperCase()}${cName.substring(1)}')
              ]
            ),
          
          );
        }
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {

  final Category category ;

  const _CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);
    
    return GestureDetector(
      onTap: (){
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(
          category.icon,
          color: (newsService.selectedCategory == category.name) 
                  ? myTheme.colorScheme.secondary
                  : Colors.black54,
        ),
      ),
    );
  }
}