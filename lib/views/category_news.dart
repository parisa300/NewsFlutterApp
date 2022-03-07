import 'package:flutter/material.dart';
import 'package:news/helper/news.dart';
import 'package:news/models/article_model.dart';

import 'article_view.dart';
import 'home.dart';

class CategoryNews extends StatefulWidget {

  final String newsCategory;

  CategoryNews({required this.newsCategory});



  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> article = <ArticleModel>[];
  bool _loading = true;

  @override
  void initState() {
    getCategoryNews();
    // TODO: implement initState
    super.initState();
  }

  void getCategoryNews() async {
    NewsForCategorie news = NewsForCategorie();
    await news.getNewsForCategory(widget.newsCategory);
    article = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(
              opacity: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.share),
              ))
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  child: ListView.builder(
                      itemCount: article.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BlogTile(
                          imageUrl: article[index].urlToImage,
                          title: article[index].title ,
                          desc: article[index].description ,
                       //   content: newslist[index].content ,
                          url: article[index].url ,
                        );
                      }),
                ),
              ),
            ),
    );
  }
}
class BlogTile extends StatelessWidget {
  final String imageUrl,title,desc,url;
  BlogTile({required this.imageUrl, required this.title,required this.desc,required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder:(context)=> Arrticle(
              blogUrl: url,
            )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)),
            SizedBox(height: 8,),
            Text(title,style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black87
            ),),
            SizedBox(height: 8,),
            Text(desc,style: TextStyle(
                color: Colors.grey
            ),)
          ],
        ),
      ),
    );
  }
}