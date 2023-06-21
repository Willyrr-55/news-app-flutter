import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/theme/theme.dart';

class ListNews extends StatelessWidget {
  final List<Article> news;

  const ListNews( this.news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (BuildContext context, int index) {
        return _News(index: index, news: news[index]);
      },
    );
  }
}

class _News extends StatelessWidget {
  final Article news; //one news
  final int index;

  const _News({required this.news, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _CardTopBar(news, index),
        _CardTitle(news),
        _CardImage(news),
        _CardBody(news),
        _CardBottoms(),
        const SizedBox(
          height: 10,
        ),
        const Divider()
      ],
    );
  }
}

class _CardTopBar extends StatelessWidget {
  final Article news;
  final int index;

  const _CardTopBar(this.news, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Text('${index + 1}. ',
              style: TextStyle(color: myTheme.colorScheme.secondary)),
          Text('${news.source.name}. ',
              style: TextStyle(color: myTheme.colorScheme.secondary)),
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final Article news;

  const _CardTitle(this.news);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(news.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
    );
  }
}

class _CardImage extends StatelessWidget {
  final Article news;

  const _CardImage(this.news);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        child: Container(
            child: (news.urlToImage != '')
                ? FadeInImage(
                    placeholder: const AssetImage('assets/img/giphy.gif'),
                    image: NetworkImage(news.urlToImage))
                : const Image(
                    image: AssetImage('assets/img/no-image.png'),
                  )),
      ),
    );
  }
}

class _CardBody extends StatelessWidget {
  final Article news;

  const _CardBody(this.news);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text((news.description != null) ? news.description : ''));
  }
}

class _CardBottoms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        RawMaterialButton(
          onPressed: () {},
          fillColor: myTheme.colorScheme.secondary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: const Icon(Icons.star_border),
        ),
        SizedBox(width: 10,),
        RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: const Icon(Icons.more_horiz_outlined),
        )
      ]),
    );
  }
}
