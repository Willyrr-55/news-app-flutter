import 'package:flutter/material.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/widgets/list_news.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
   
  const Tab1Page({Key? key}) : super(key: key);

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);
    // newsService.headlines;

    return Scaffold(
      // body: ListNews(news: newsService.headlines)
      body: ( newsService.headlines.length == 0)
        ? const Center( child: CircularProgressIndicator())
        : ListNews(newsService.headlines)
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}