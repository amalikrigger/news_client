import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:news_client/features/articles/models/article.dart';

void compareArticleLists(
    List<Article>? actualArticles, List<Article>? expectedArticles) {
  if (expectedArticles == null) {
    expect(actualArticles, isNull, reason: 'Expected article list to be null');
    return;
  }
  if (actualArticles == null) {
    fail('Actual article list is null, but expected is not.');
  }

  expect(actualArticles.length, expectedArticles.length,
      reason: 'Article list lengths are different');

  for (int i = 0; i < expectedArticles.length; i++) {
    final expectedArticle = expectedArticles[i];
    final actualArticle = actualArticles[i];

    expect(actualArticle.title, expectedArticle.title,
        reason: 'Article at index $i: title mismatch');
    expect(actualArticle.description, expectedArticle.description,
        reason: 'Article at index $i: description mismatch');
    expect(actualArticle.url, expectedArticle.url,
        reason: 'Article at index $i: url mismatch');
    expect(actualArticle.author, expectedArticle.author,
        reason: 'Article at index $i: author mismatch');
    expect(actualArticle.urlToImage, expectedArticle.urlToImage,
        reason: 'Article at index $i: urlToImage mismatch');
    expect(actualArticle.publishedAt, expectedArticle.publishedAt,
        reason: 'Article at index $i: publishedAt mismatch');
    expect(actualArticle.content, expectedArticle.content,
        reason: 'Article at index $i: content mismatch');

    compareArticleSources(actualArticle.source, expectedArticle.source,
        index: i);
  }
}

void compareArticleSources(
    ArticleSource actualSource, ArticleSource expectedSource,
    {required int index}) {
  expect(actualSource.id, expectedSource.id,
      reason: 'ArticleSource at article index $index: id mismatch');
  expect(actualSource.name, expectedSource.name,
      reason: 'ArticleSource at article index $index: name mismatch');
}

Future<String> getTemporaryDirectoryPath() async {
  final directory = await Directory.systemTemp.createTemp('test_db');
  return directory.path;
}

final dynamic jsonResponse1 = {
  "status": "ok",
  "totalResults": 1,
  "articles": [
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "05/02/2025 20:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxwsdn",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-05T20:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "05/02/2025 19:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxwnnj",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-05T19:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Bernd Debusmann Jr",
      "title": "Trump signs order banning transgender women from female sports",
      "description":
          "He says the move, which covers non-elite levels, restores fairness but human rights advocates have condemned it.",
      "url": "https://www.bbc.co.uk/news/articles/c20g85k3z35o",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/f719/live/0d3abb90-e40f-11ef-a319-fb4e7360c4ec.jpg",
      "publishedAt": "2025-02-05T18:55:46Z",
      "content":
          "A number of sporting governing bodies, including swimming, athletics and golf, have banned transgender women from competing in the female category at elite level if they have gone through male pubert… [+2728 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "05/02/2025 18:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxwjxd",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-05T18:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Catherine Snowdon",
      "title": "Women with endometriosis earn less, research shows",
      "description":
          "Researchers suggest that following diagnosis, women may take lower-paid jobs or work fewer hours.",
      "url": "https://www.bbc.co.uk/news/articles/c0k5rp87nzlo",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/1040/live/81f77fa0-e3c8-11ef-9849-d956c4d21350.jpg",
      "publishedAt": "2025-02-05T17:12:14Z",
      "content":
          "Emily is far from alone in having to adapt her working life to her condition. The research by the ONS, which is the first population-wide analysis ever carried out in England, suggests many women exp… [+790 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "05/02/2025 17:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxwf58",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-05T17:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title":
          "Palestinians, Saudis, Egypt, and others reject Trump's plans for US takeover of Gaza",
      "description":
          "There's been international condemnation of plans by US President Donald Trump to seize control of Gaza. He said he wants the US to take a \"long-term ownership position\" and turn it into the \"Riviera of the Middle East\", while Palestinians could be resettled i…",
      "url": "https://www.bbc.co.uk/programmes/w172zb9cctgsxdv",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p0kpb3k6.jpg",
      "publishedAt": "2025-02-05T16:39:00Z",
      "content":
          "There's been international condemnation of plans by US President Donald Trump to seize control of Gaza. He said he wants the US to take a \"long-term ownership position\" and turn it into the \"Riviera … [+572 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Paul Adams",
      "title":
          "Why does Donald Trump want to take over Gaza and could he do it?",
      "description":
          "The president's vision for a Gaza under US control could upend the future of Middle East relations.",
      "url": "https://www.bbc.co.uk/news/articles/cn4z32y12jpo",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/b2a8/live/247cac90-e3de-11ef-bd1b-d536627785f2.jpg",
      "publishedAt": "2025-02-05T16:12:08Z",
      "content":
          "Many Gazans are descendants of people who fled or were driven from their homes in 1948 during the creation of the state of Israel - a period Palestinians call the Nakba, the Arabic word for catastrop… [+1170 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "05/02/2025 16:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxw9f4",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-05T16:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Wedaeli Chibelushi",
      "title":
          "Goma jailbreak: More than 100 women raped and burned alive in DR Congo, UN says",
      "description":
          "As M23 rebels entered Goma and the city was plunged into chaos, female prisoners were attacked, the UN says.",
      "url": "https://www.bbc.co.uk/news/articles/ckgyrxz4k6zo",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/0198/live/bddf61c0-e3d4-11ef-a319-fb4e7360c4ec.jpg",
      "publishedAt": "2025-02-05T15:34:12Z",
      "content":
          "The BBC has not been able to verify the reports.\r\nGoma, a major city of more than a million people, was captured after the Rwanda-backed M23 executed a rapid advance through eastern DR Congo.\r\nThe ci… [+1463 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "05/02/2025 15:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxw5p0",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-05T15:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "05/02/2025 14:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxw1xw",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-05T14:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "05/02/2025 13:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxvy5r",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-05T13:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Mark Savage",
      "title":
          "Ozzy Osbourne and Black Sabbath to play final show in Birmingham",
      "description":
          "The band will reunite to play a charity show with metal legends Metallica, Anthrax and Slayer.",
      "url": "https://www.bbc.co.uk/news/articles/c805m3l02v5o",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/299b/live/a2a471d0-e3b0-11ef-9c34-470658c222b3.jpg",
      "publishedAt": "2025-02-05T12:12:28Z",
      "content":
          "Black Sabbath formed in 1968, and held their first rehearsal at Newtown Community Centre, a stone's throw from Villa Park.\r\nThey previously played a farewell show to a sold out audience of 16,000 peo… [+1542 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "05/02/2025 12:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxvtfm",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-05T12:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "05/02/2025 11:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxvpph",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-05T11:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Christal Hayes",
      "title":
          "100,000 organic eggs stolen from one US grocer as bird flu drives up prices",
      "description":
          "The price of eggs has risen amid a bird flu epidemic, making them an unexpectedly costly menu option.",
      "url": "https://www.bbc.co.uk/news/articles/cd64l45221wo",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/04ae/live/6a5a2ba0-e35e-11ef-85b4-d3e7cbacfead.jpg",
      "publishedAt": "2025-02-05T10:37:58Z",
      "content":
          "On Tuesday, Waffle House announced a \$0.50 surcharge for customers to shell out per egg. \r\nThe US diner chain called it a \"temporary targeted surcharge tied to the unprecedented rise in egg prices\".\r… [+526 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "05/02/2025 10:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxvkyc",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-05T10:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Bbc News",
      "title": "Belgian police hunt for gunmen in Brussels underground",
      "description":
          "Police say they are looking for \"a small group of people, probably two or three individuals\".",
      "url": "https://www.bbc.co.uk/news/articles/cn4mvl1ngk1o",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/069d/live/16ca3950-e3a7-11ef-8450-ff58a15d40df.jpg",
      "publishedAt": "2025-02-05T09:51:53Z",
      "content":
          "The spokeswoman said there were no injuries in the shooting. Both the local police and federal railway police are searching the area.\r\nPolice are looking for \"a small group of people, probably two or… [+1084 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "05/02/2025 09:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxvg67",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-05T09:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Bbc News",
      "title": "Witnesses recall horror of Sweden's worst school shooting",
      "description":
          "At least 11 people were killed in the attack at Risbergska school in Orebro, including the suspected gunman.",
      "url": "https://www.bbc.co.uk/news/articles/c0lze6zjrwwo",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/7f95/live/ce6751b0-e393-11ef-90ea-a53b659307b9.jpg",
      "publishedAt": "2025-02-05T08:09:14Z",
      "content":
          "Prime Minister Ulf Kristersson said it was difficult to grasp the magnitude of what happened. Flags on government buildings, parliament and the royal palaces will fly at half-mast on Wednesday, the p… [+777 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "05/02/2025 08:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxvbg3",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-05T08:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Bbc News",
      "title": "Sheffield stabbing: Teenager charged over murder of boy, 15",
      "description":
          "The 15-year-old is also charged with possession of a bladed article and one count of affray.",
      "url": "https://www.bbc.co.uk/news/articles/c14nmpde6y2o",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/ca54/live/c9c296e0-e395-11ef-8304-b7bc1f9cc5e8.jpg",
      "publishedAt": "2025-02-05T07:44:27Z",
      "content":
          "In a statement released through South Yorkshire Police on Tuesday, Harvey's \"utterly heartbroken\" family paid tribute to their \"beautiful boy, Harvey Goose\".\r\n\"Our lives are devastated and will never… [+390 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "05/02/2025 07:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxv6pz",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-05T07:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "05/02/2025 06:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxv2yv",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-05T06:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "05/02/2025 05:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxtz6q",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-05T05:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "05/02/2025 04:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxtvgl",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-05T04:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "João Da Silva",
      "title": "US Postal Service stops accepting parcels from China",
      "description":
          "It says the suspension will be in place \"until further notice\" and did not offer a reason for the decision.",
      "url": "https://www.bbc.co.uk/news/articles/c3w83x38zvwo",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/f819/live/69baee50-e372-11ef-af36-93a423d43eab.jpg",
      "publishedAt": "2025-02-05T03:38:48Z",
      "content":
          "In responseChina said it would implement tariffs on some US imports.\r\nFrom 10 February coal and liquefied natural gas products (LNG) will face a 15% levy. Crude oil, agricultural machinery and large-… [+706 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "05/02/2025 03:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxtqqg",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-05T03:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "05/02/2025 02:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxtlzb",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-05T02:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Alice Evans",
      "title":
          "Phone bans in schools don't help grades or health, study suggests",
      "description":
          "It is the first study to look at school phone rules, alongside measures of pupil health and education.",
      "url": "https://www.bbc.co.uk/news/articles/cy8plvqv60lo",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/2d7e/live/de2e1230-e25a-11ef-9895-2b17c6c3968e.jpg",
      "publishedAt": "2025-02-05T01:39:36Z",
      "content":
          "Colin Crehan, head at Holy Trinity Catholic School in Small Heath, Birmingham, feels a \"moral obligation\" to help students learn to use their phones in a \"safe and controlled space\".\r\nHe says phone-r… [+1027 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "BBC World Service",
      "title": "BBC Trending: The dark side of music streaming",
      "description":
          "In September last year, musician Michael Smith of North Carolina was charged with stealing millions from music streaming services. The US Department of Justice has accused him of using artificial intelligence tools and thousands of bots to fraudulently stream…",
      "url": "https://www.bbc.co.uk/programmes/p0knwddj",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p0hd1sss.jpg",
      "publishedAt": "2025-02-05T01:30:00Z",
      "content":
          "In September last year, musician Michael Smith of North Carolina was charged with stealing millions from music streaming services. The US Department of Justice has accused him of using artificial int… [+468 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Lucy Hooker",
      "title": "Google owner Alphabet drops promise over 'harmful' AI uses",
      "description":
          "The tech giant has updated the principles governing its development of artificial intelligence.",
      "url": "https://www.bbc.co.uk/news/articles/cy081nqx2zjo",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/9489/live/6de4ebf0-e351-11ef-a08f-756c6bc158bd.jpg",
      "publishedAt": "2025-02-05T01:12:23Z",
      "content":
          "There is debate amongst AI experts and professionals over how the powerful new technology should be governed in broad terms, how far commercial gains should be allowed to determine its direction, and… [+2553 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "05/02/2025 01:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxth76",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-05T01:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Nathan Williams",
      "title": "Aga Khan: Billionaire and spiritual leader dies at 88",
      "description":
          "The philanthropist and spiritual leader died \"peacefully\" at the age of 88 in Lisbon, Portugal.",
      "url": "https://www.bbc.co.uk/news/articles/c9vmlk4rzzjo",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/7f4f/live/d12b31a0-e35c-11ef-a819-277e390a7a08.jpg",
      "publishedAt": "2025-02-05T00:46:07Z",
      "content":
          "Prince Karim Aga Khan succeeded his grandfather as imam of the Ismaili Muslims in 1957 at the age of 20.\r\nThe prince had an estimated fortune of \$1bn (£801m) in 2008, according to Forbes magazine, ex… [+1521 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "05/02/2025 00:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxtch2",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-05T00:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Ed Butler",
      "title":
          "Ghana wants more for its cashews, but it's a tough nut to crack",
      "description":
          "The African nation exports its cashews in raw form, but processing them would be more lucrative.",
      "url": "https://www.bbc.co.uk/news/articles/cg5y1r189m0o",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/2221/live/861d4cd0-deec-11ef-95b8-53b8dd8c4ede.jpg",
      "publishedAt": "2025-02-05T00:00:20Z",
      "content":
          "\"It's amazing,\" says Bright Simons, an entrepreneur and economic commentator in Accra, who has studied the numbers. \"Roasters and retailers buy the nuts from farmers for \$500 a tonne, and sell to cus… [+1670 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 23:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxt7qy",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T23:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "Netanyahu and Trump meet at White House",
      "description":
          "The Israeli PM has said that this shows how close the bond is between the two countries and the two men. But is that really so?\n\nAlso on the programme: Sweden experiences the worst mass shooting in its history as ten people are killed in the central city of Ö…",
      "url": "https://www.bbc.co.uk/programmes/w172zb9cctgqvqn",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p0kp55qq.jpg",
      "publishedAt": "2025-02-04T22:18:00Z",
      "content":
          "The Israeli PM has said that this shows how close the bond is between the two countries and the two men. But is that really so?\r\nAlso on the programme: Sweden experiences the worst mass shooting in i… [+321 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 22:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxt3zt",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T22:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 21:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxt07p",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T21:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 20:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxswhk",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T20:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 19:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxsrrf",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T19:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 18:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxsn09",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T18:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Bbc News",
      "title":
          "Trump wants US to 'take over' Gaza and own it 'long term', with Palestinians resettled - live updates",
      "description":
          "The US president says he wants the US to take \"long-term ownership\" of Gaza, turning it into the \"Riviera of the Middle East\".",
      "url": "https://www.bbc.co.uk/news/live/clyn05y9x2xt",
      "urlToImage":
          "https://static.files.bbci.co.uk/ws/simorgh-assets/public/news/images/metadata/poster-1024x576.png",
      "publishedAt": "2025-02-04T17:58:37Z",
      "content":
          "What did Trump say about the US taking over Gaza?\r\nThe US will take over the Gaza Strip, and we will do a job with it too. Well own it and be responsible for dismantling all of the dangerous unexplod… [+2737 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Faarea Masud",
      "title":
          "Estée Lauder to cut thousands of jobs, warning of tariff impact",
      "description":
          "The firm that owns Clinique, MAC and Bobbi Brown shedding double the number of jobs than planned, warning of global volatility.",
      "url": "https://www.bbc.co.uk/news/articles/cn0y8lrlnkyo",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/f010/live/48a68d90-e323-11ef-8ce2-a59f1a725a0e.jpg",
      "publishedAt": "2025-02-04T17:20:48Z",
      "content":
          "Estée Lauder is the latest company to warn of the impact a tit-for-tat tariff war could have on their fortunes.\r\nDrinks giant, Diageo, which makes Guinness, Johnnie Walker, Baileys and Smirnoff warne… [+823 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 17:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxsj85",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T17:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 16:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxsdj1",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T16:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Bbc News",
      "title":
          "Trump-South Africa land row: President Ramaphosa calls Elon Musk to calm tensions",
      "description":
          "President Trump, who Elon Musk advises, has threatened to cut funding over South Africa's land policy.",
      "url": "https://www.bbc.co.uk/news/articles/cly7gyvyveeo",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/91fc/live/7ca204c0-e301-11ef-a470-4fd3f77f90af.jpg",
      "publishedAt": "2025-02-04T15:58:37Z",
      "content":
          "Last month, President Cyril Ramaphosa signed into law a bill that allows land seizures without compensation in certain circumstances.\r\nLand ownership has long been a contentious issue in South Africa… [+2606 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "China announces retaliatory tariffs on some American goods",
      "description":
          "China is retaliating against US tariffs by restricting exports on a group of rare metals crucial to defence and other industries.\n\nAlso, the Israeli prime minister, Benjamin Netanyahu is to meet with president Trump for talks in Washington later today. \n\nAnd …",
      "url": "https://www.bbc.co.uk/programmes/w172zb9cctgq0hr",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p0kp2p18.jpg",
      "publishedAt": "2025-02-04T15:25:00Z",
      "content":
          "China is retaliating against US tariffs by restricting exports on a group of rare metals crucial to defence and other industries.\r\nAlso, the Israeli prime minister, Benjamin Netanyahu is to meet with… [+177 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 15:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxs8rx",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T15:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Seb Noble",
      "title": "More pensioners turning to us, say Cornwall's foodbanks",
      "description":
          "Foodbanks in Cornwall say they are helping more pensioners since changes to the winter fuel payment.",
      "url": "https://www.bbc.co.uk/news/articles/cn8y3616lv1o",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/bcba/live/360e4d70-dcd0-11ef-8258-c7fdda71ed41.jpg",
      "publishedAt": "2025-02-04T15:03:01Z",
      "content":
          "Ben Maguire, Liberal Democrat MP for North Cornwall, urged the government to reconsider who received winter fuel payments.\r\nHe argued: \"This should be linked to other benefits, whether it's housing a… [+527 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Michael Race",
      "title": "Five ways China is hitting back against US tariffs",
      "description":
          "China has set out a series of measures to kick in next week after the US introduced 10% tariffs on imports from the country.",
      "url": "https://www.bbc.co.uk/news/articles/czj31l4p7vzo",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/5473/live/ba6a1a90-e2f7-11ef-aac9-6f6e2a699c06.jpg",
      "publishedAt": "2025-02-04T14:28:38Z",
      "content":
          "Part of China's countermeasures to Trump's tariffs is to announce import taxes of its own on US coal and liquefied natural gas (LNG) of 10%, and a 15% charge on crude oil.\r\nThe response from Beijing … [+1075 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 14:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxs50s",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T14:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 13:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxs18n",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T13:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Bbc News",
      "title": "Five people shot at school in central Sweden",
      "description":
          "The school shooting happened in Örebro 200km west of Stockholm.",
      "url": "https://www.bbc.co.uk/news/articles/c79d52gpd02o",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/cdd2/live/f0a209e0-e2f9-11ef-bf72-232dd6212056.jpg",
      "publishedAt": "2025-02-04T12:58:47Z",
      "content":
          "Five people have been shot at a school in central Sweden, police say.\r\nThe shooting happened in Örebro, 200km (124m) west of Stockholm, on Tuesday afternoon. \r\nPolice said the extent of the injuries … [+241 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Bbc Newsround",
      "title": "'Singing is really good for my mental health'",
      "description":
          "This children's choir has been exploring emotions through the power of singing, as part of Children's Mental Health Week.",
      "url": "https://www.bbc.co.uk/newsround/articles/cd0j3x275dzo",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_newsround/1200/cpsprodpb/80ba/live/d046f0f0-e300-11ef-a819-277e390a7a08.jpg",
      "publishedAt": "2025-02-04T12:36:47Z",
      "content":
          "Mental health describes our emotional, psychological, and social wellbeing.\r\nEveryone has mental health - it effects how you feel and think, and sometimes how you act and cope with things going on in… [+365 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 12:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxrxjj",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T12:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Victoria Scheer And Tom Ingall",
      "title":
          "All Saints Sheffield stabbing victim's family pay tribute to teenager",
      "description":
          "The family of Harvey Willgoose share pictures and tributes following his death on Monday.",
      "url": "https://www.bbc.co.uk/news/articles/czj31xevkkyo",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/838a/live/ca558620-e2e7-11ef-a83b-bf768968ed36.jpg",
      "publishedAt": "2025-02-04T11:57:10Z",
      "content":
          "Tributes left at the school gates described the teenager as someone who had been \"the life of a party\" and who had \"brought joy and laughter to everyone who knew him\".\r\nOne card read: \"Harvey my 'pal… [+700 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Lucy Hooker",
      "title": "Trump says sovereign wealth fund could buy TikTok",
      "description":
          "The president has kickstarted the creation of a national fund, which he says could buy the social media platform.",
      "url": "https://www.bbc.co.uk/news/articles/cvgm81x2d3ko",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/527c/live/8cc71930-e289-11ef-b364-61a0d90e83b4.jpg",
      "publishedAt": "2025-02-04T11:51:22Z",
      "content":
          "When Trump first floated the idea of a sovereign wealth fund during his election campaign, he suggested it could be funded by \"tariffs and other intelligent things\".\r\nHe has already announced plans t… [+1727 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Emma Saunders",
      "title":
          "Jesse Eisenberg: I don't want to be associated with Mark Zuckerberg",
      "description":
          "The star who played Meta's Mark Zuckerberg in The Social Network slams his plan to ditch fact-checkers.",
      "url": "https://www.bbc.co.uk/news/articles/crr0x4qxxvko",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/1375/live/e3fac110-e2ee-11ef-a319-fb4e7360c4ec.jpg",
      "publishedAt": "2025-02-04T11:27:09Z",
      "content":
          "Eisenberg is promoting A Real Pain, which he wrote, directed and stars in - a comedy drama about two cousins who travel to Poland together to visit Holocaust sites to honour their late grandmother.\r\n… [+976 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Ian Aikman",
      "title":
          "Thousands evacuate Santorini after earthquakes shake Greek island",
      "description":
          "Hundreds of earthquakes have rattled the island since Sunday, leading emergency flights to be scheduled.",
      "url": "https://www.bbc.co.uk/news/articles/cjde94dnj08o",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/bdd0/live/249ff540-e2dc-11ef-a319-fb4e7360c4ec.jpg",
      "publishedAt": "2025-02-04T11:06:18Z",
      "content":
          "Several tremors, measuring up to magnitude 4.7, were recorded north-east of Santorini early on Tuesday.\r\nThough no major damage has been reported so far, emergency measures are being taken as a preca… [+1671 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 11:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxrssd",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T11:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Bbc News",
      "title": "NHS opens a further 12 mpox vaccination centres in England",
      "description":
          "The new centres offer jabs to people classed as at a higher risk of getting the infection.",
      "url": "https://www.bbc.co.uk/news/articles/clyn0lpyd7no",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/b257/live/0f114fd0-e2dc-11ef-a819-277e390a7a08.jpg",
      "publishedAt": "2025-02-04T10:41:06Z",
      "content":
          "Symptoms of mpox include a skin rash with blisters, spots and ulcers that can appear anywhere on the body, fever, headaches, backache and muscle aches.\r\nA rash usually appears between one and five da… [+642 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "BBC Radio",
      "title": "My Song, My Home: Grace in Liverpool",
      "description":
          "Welcome to our new music series My Song, My Home. In each episode we meet a new musician who tells us about their home town and performs a song to help you learn.Today, we meet Grace, who performs for us in a library in Liverpool.With thanks to the University…",
      "url": "https://www.bbc.co.uk/programmes/p0kp1py1",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p0kp1pyp.jpg",
      "publishedAt": "2025-02-04T10:36:00Z",
      "content":
          "Welcome to our new music series My Song, My Home. In each episode we meet a new musician who tells us about their home town and performs a song to help you learn.\r\nToday, we meet Grace, who performs … [+699 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 10:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxrp18",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T10:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Dominic Casciani",
      "title":
          "Lucy Letby's lawyers apply for case to be reviewed by commission",
      "description":
          "Letby is serving 15 whole life prison sentences after being convicted of murdering seven babies and attempting to murder seven others.",
      "url": "https://www.bbc.co.uk/news/articles/cvgl5yyg1x6o",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/bf25/live/f6d20520-e2e2-11ef-9c34-2b19c8701564.jpg",
      "publishedAt": "2025-02-04T10:05:50Z",
      "content":
          "The CCRC confirmed it had \"received a preliminary application in relation to Ms Letby's case, and work has begun to assess the application\".\r\nA CCRC spokesperson said: \"We are aware that there has be… [+584 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 09:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxrk94",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T09:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 08:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxrfk0",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T08:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Samantha Granville",
      "title": "Joe Biden signs with Los Angeles talent agency CAA",
      "description":
          "The former president was signed to the same agency between 2017 to 2020, which also represents the Obamas.",
      "url": "https://www.bbc.co.uk/news/articles/cvgl55wng87o",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/5ddf/live/15ce7f70-e28f-11ef-8d6e-af2159186f83.jpg",
      "publishedAt": "2025-02-04T07:31:00Z",
      "content":
          "During his previous stint signed to the talent agency, he published his memoir, Promise Me, Dad: A Year of Hope, Hardship, and Purpose in 2017.\r\nThe book, which chronicled the loss of his eldest son,… [+997 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 07:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxr9sw",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T07:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Anna Lamche",
      "title": "Brian Murphy: Man About the House actor dies aged 92",
      "description":
          "The actor and comedian had worked closely with theatre director Joan Littlewood in his early career.",
      "url": "https://www.bbc.co.uk/news/articles/cdxeg4q0rddo",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/190c/live/1cc86320-e2b4-11ef-97d8-5319c5a9def7.jpg",
      "publishedAt": "2025-02-04T06:17:17Z",
      "content":
          "Born on the Isle of Wight in 1932, Murphy's acting career began in the 1950s when he became a member of the pioneering Theatre Workshop.\r\nFounded by Joan Littlewood and her partner Gerry Raffles, it … [+725 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Emma Barnett",
      "title":
          "Thomas Kingston's family calls for antidepressant prescription change",
      "description":
          "Thomas Kingston's family calls for antidepressant prescription changebbc.co.uk",
      "url": "https://www.bbc.co.uk/news/articles/c5y76kd8x6no",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/67b4/live/44e99860-e22d-11ef-a819-277e390a7a08.jpg",
      "publishedAt": "2025-02-04T06:10:54Z",
      "content":
          "The NHS says that antidepressants can be used to treat clinical depression, anxiety disorder, OCD and PTSD. More than 8.7 million people, external in England were prescribed antidepressants in the 12… [+1094 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 06:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxr61r",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T06:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "Botched: The Brazilian Butt Lift Nightmare",
      "description":
          "This is the story of a man who charges thousands for a dangerous cosmetic procedure - liquid Brazilian Butt Lifts. Ricky Sawyer has left women across the UK disfigured and in agony.",
      "url":
          "https://www.bbc.co.uk/iplayer/episode/m0028253/scams-scandals-botched-the-brazilian-butt-lift-nightmare",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p0knfb3c.jpg",
      "publishedAt": "2025-02-04T06:00:00Z",
      "content":
          "Contains some upsetting scenes.\r\nThis is the story of a man who charges thousands for a dangerous cosmetic procedure - liquid Brazilian Butt Lifts. Ricky Sawyer has left women across the UK disfigure… [+19 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Bbc News",
      "title": "El Salvador offers to take in US criminals and migrants",
      "description":
          "El Salvador says it can house dangerous criminals, including US citizens, in its mega-jail.",
      "url": "https://www.bbc.co.uk/news/articles/c0jn5291p52o",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/e9ce/live/b56ecb90-e30a-11ef-bd1b-d536627785f2.jpg",
      "publishedAt": "2025-02-04T05:13:06Z",
      "content":
          "The treatment of inmates at Cecot, where scores of inmates are locked up in each windowless cell, has been criticised by rights groups.\r\nBut Bukele's crackdown on crime continues to be very popular w… [+651 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 05:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxr29m",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T05:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 04:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxqykh",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T04:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 03:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxqttc",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T03:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 02:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxqq27",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T02:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "BBC World Service",
      "title": "Assignment: Spain - ‘liquid gold’ under pressure",
      "description":
          "Spain is the world’s largest producer of olive oil. But successive, brutal droughts have led to plummeting production, whilst prices have reached record highs. For 2024 / 2025, the weather’s been better - Spain’s predicted to increase the quantity of olives h…",
      "url": "https://www.bbc.co.uk/programmes/p0kml99v",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p0kmkbfl.jpg",
      "publishedAt": "2025-02-04T01:30:00Z",
      "content":
          "Spain is the worlds largest producer of olive oil. But successive, brutal droughts have led to plummeting production, whilst prices have reached record highs. For 2024 / 2025, the weathers been bette… [+737 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 01:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxqlb3",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T01:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Annabel Rackham And Elena Bailey",
      "title":
          "Pharmacies to require more checks before selling weight-loss jabs",
      "description":
          "Online pharmacies will no longer be allowed to use customer pictures or questionnaires as evidence.",
      "url": "https://www.bbc.co.uk/news/articles/c5yeklrer39o",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/ad8f/live/7897b440-e24a-11ef-bd1b-d536627785f2.jpg",
      "publishedAt": "2025-02-04T00:57:05Z",
      "content":
          "Semaglutide and tirzepatide were first used to help type 2 diabetes patients regulate their blood-sugar levels.\r\nBut in the past three to four years, they started being prescribed as a weight-loss ai… [+728 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "04/02/2025 00:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxqgkz",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-04T00:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "03/02/2025 23:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxqbtv",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-03T23:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Soutik Biswas",
      "title":
          "Guillain-Barre syndrome: India faces outbreak of creeping paralysis",
      "description":
          "GBS is a rare disorder where the immune system attacks nerve cells, causing paralysis.",
      "url": "https://www.bbc.co.uk/news/articles/c2038ggnpx7o",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/4fb8/live/1c318e10-e277-11ef-a819-277e390a7a08.jpg",
      "publishedAt": "2025-02-03T23:00:30Z",
      "content":
          "GBS is not entirely uncommon in India. Monojit Debnath and Madhu Nagappa, of Bangalore-based National Institute of Mental Health and Neurosciences (NIMHANS), studied 150 GBS patients over a five year… [+1897 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "US pauses tariffs on Mexico for one month",
      "description":
          "Mexico will increase its efforts in combating drug trafficking. Mexico's president, Claudia Sheinbaum, says the US has agreed to take steps to limit the flow of guns south.\n\nAlso on the programme: the US Secretary of State, Marco Rubio, is taking over the run…",
      "url": "https://www.bbc.co.uk/programmes/w172zb9cctgmytk",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p0knyq9f.jpg",
      "publishedAt": "2025-02-03T22:16:00Z",
      "content":
          "Mexico will increase its efforts in combating drug trafficking. Mexico's president, Claudia Sheinbaum, says the US has agreed to take steps to limit the flow of guns south.\r\nAlso on the programme: th… [+397 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "03/02/2025 22:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxq72q",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-03T22:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Alex Loftus",
      "title": "Australia: Teenage girl killed in shark attack near Brisbane",
      "description":
          "The 17-year-old was attacked around 100m from shore of Woormin Beach, Australian media reports.",
      "url": "https://www.bbc.co.uk/news/articles/c36037251gpo",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/cc11/live/b08cb220-e226-11ef-87aa-53645de28b43.jpg",
      "publishedAt": "2025-02-03T21:12:01Z",
      "content":
          "Police confirmed the girl had been swimming in the waters off Bribie Island - just off the mainland, on which Woorim Beach sits - when she was attacked by the shark, the species of which has not been… [+805 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "03/02/2025 21:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxq3bl",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-03T21:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Vishala Sri-pathma & Oliver Smith",
      "title":
          "AstraZeneca: Government hits back in funding row with pharmaceutical giant",
      "description":
          "The firm scrapped its £450m investment despite the government's offer of support, the government says.",
      "url": "https://www.bbc.co.uk/news/articles/c4gx2k35k7do",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/bbec/live/8cceab60-e26a-11ef-a819-277e390a7a08.jpg",
      "publishedAt": "2025-02-03T20:48:58Z",
      "content":
          "\"Securing this deal was a big test of Labour's economic credibility, and they have failed,\" said Mak.\r\nThe pharmaceutical giant announced its decision to cancel its planned investment just two days a… [+1724 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "03/02/2025 20:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxpzlg",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-03T20:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "03/02/2025 19:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxpvvb",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-03T19:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "Watch Monday Night Club on BBC iPlayer",
      "description":
          "Mark Chapman, Chris Sutton, Rory Smith and Theo Walcott debate the weekend's football.",
      "url":
          "https://www.bbc.co.uk/iplayer/episode/l0056y2v/monday-night-club-0322025",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p0jlvk0w.jpg",
      "publishedAt": "2025-02-03T18:34:02Z",
      "content":
          "Mark Chapman, Chris Sutton, Rory Smith and Theo Walcott debate the weekend's football."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "03/02/2025 18:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxpr36",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-03T18:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "03/02/2025 17:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxpmc2",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-03T17:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Bbc News",
      "title":
          "Ontario ends contract with Elon Musk's Starlink over US tariffs",
      "description":
          "It is part of Canada's response to sweeping tariffs levied by US President Donald Trump on its imports.",
      "url": "https://www.bbc.co.uk/news/articles/c5y7626l610o",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/7659/live/df6e1c00-e249-11ef-a319-fb4e7360c4ec.jpg",
      "publishedAt": "2025-02-03T17:05:10Z",
      "content":
          "Trump said in the Oval Office on Monday they had a \"good talk\" but that he raised a number of issues he saw as trade irritants. \r\n\"I'm sure you're shocked to hear that, but Canada is very tough,\" he … [+2727 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Pallab Ghosh",
      "title": "YR4: the asteroid with a tiny chance of hitting Earth",
      "description":
          "The asteroid named YR4 has a 1% chance of hitting Earth in 2032",
      "url": "https://www.bbc.co.uk/news/articles/cqx9dgpx98go",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/abbf/live/a6b43bc0-e252-11ef-a819-277e390a7a08.jpg",
      "publishedAt": "2025-02-03T17:02:12Z",
      "content":
          "When asteroids are initially calculated to have a small probability of hitting the Earth, that impact probability usually drops to zero after additional observations. \r\nThis happened in 2004 when an … [+2161 chars]"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "Can it get any worse for Wales?",
      "description":
          "13 defeats in a row - can things get any worse for Wales?",
      "url": "https://www.bbc.co.uk/programmes/p0knxkkp",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p0knxn14.jpg",
      "publishedAt": "2025-02-03T16:24:46Z",
      "content":
          "Former Wales captain Sam Warburton says the difference between Wales winning the Six Nations in 2021 and losing their 13th consecutive Test match could be 'the biggest drop-off we've ever seen.'"
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": null,
      "title": "03/02/2025 16:01 GMT",
      "description":
          "The latest five minute news bulletin from BBC World Service.",
      "url": "https://www.bbc.co.uk/programmes/w172zgfkxkxphly",
      "urlToImage": "https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg",
      "publishedAt": "2025-02-03T16:06:00Z",
      "content": "The latest five minute news bulletin from BBC World Service."
    }
  ]
};

final dynamic jsonResponse2 = {
  'sources': [
    {
      "id": "abc-news",
      "name": "ABC News",
      "description":
          "Your trusted source for breaking news, analysis, exclusive interviews, headlines, and videos at ABCNews.com.",
      "url": "https://abcnews.go.com",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "abc-news-au",
      "name": "ABC News (AU)",
      "description":
          "Australia's most trusted source of local, national and world news. Comprehensive, independent, in-depth analysis, the latest business, sport, weather and more.",
      "url": "https://www.abc.net.au/news",
      "category": "general",
      "language": "en",
      "country": "au"
    },
    {
      "id": "aftenposten",
      "name": "Aftenposten",
      "description":
          "Norges ledende nettavis med alltid oppdaterte nyheter innenfor innenriks, utenriks, sport og kultur.",
      "url": "https://www.aftenposten.no",
      "category": "general",
      "language": "no",
      "country": "no"
    },
    {
      "id": "al-jazeera-english",
      "name": "Al Jazeera English",
      "description":
          "News, analysis from the Middle East and worldwide, multimedia and interactives, opinions, documentaries, podcasts, long reads and broadcast schedule.",
      "url": "https://www.aljazeera.com",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "ansa",
      "name": "ANSA.it",
      "description":
          "Agenzia ANSA: ultime notizie, foto, video e approfondimenti su: cronaca, politica, economia, regioni, mondo, sport, calcio, cultura e tecnologia.",
      "url": "https://www.ansa.it",
      "category": "general",
      "language": "it",
      "country": "it"
    },
    {
      "id": "argaam",
      "name": "Argaam",
      "description":
          "ارقام موقع متخصص في متابعة سوق الأسهم السعودي تداول - تاسي - مع تغطيه معمقة لشركات واسعار ومنتجات البتروكيماويات , تقارير مالية الاكتتابات الجديده ",
      "url": "https://www.argaam.com",
      "category": "business",
      "language": "ar",
      "country": "sa"
    },
    {
      "id": "ars-technica",
      "name": "Ars Technica",
      "description":
          "The PC enthusiast's resource. Power users and the tools they love, without computing religion.",
      "url": "https://arstechnica.com",
      "category": "technology",
      "language": "en",
      "country": "us"
    },
    {
      "id": "ary-news",
      "name": "Ary News",
      "description":
          "ARY News is a Pakistani news channel committed to bring you up-to-the minute Pakistan news and featured stories from around Pakistan and all over the world.",
      "url": "https://arynews.tv/ud/",
      "category": "general",
      "language": "ud",
      "country": "pk"
    },
    {
      "id": "associated-press",
      "name": "Associated Press",
      "description":
          "The AP delivers in-depth coverage on the international, politics, lifestyle, business, and entertainment news.",
      "url": "https://apnews.com/",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "australian-financial-review",
      "name": "Australian Financial Review",
      "description":
          "The Australian Financial Review reports the latest news from business, finance, investment and politics, updated in real time. It has a reputation for independent, award-winning journalism and is essential reading for the business and investor community.",
      "url": "http://www.afr.com",
      "category": "business",
      "language": "en",
      "country": "au"
    },
    {
      "id": "axios",
      "name": "Axios",
      "description":
          "Axios are a new media company delivering vital, trustworthy news and analysis in the most efficient, illuminating and shareable ways possible.",
      "url": "https://www.axios.com",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "bbc-news",
      "name": "BBC News",
      "description":
          "Use BBC News for up-to-the-minute news, breaking news, video, audio and feature stories. BBC News provides trusted World and UK news as well as local and regional perspectives. Also entertainment, business, science, technology and health news.",
      "url": "https://www.bbc.co.uk/news",
      "category": "general",
      "language": "en",
      "country": "gb"
    },
    {
      "id": "bbc-sport",
      "name": "BBC Sport",
      "description":
          "The home of BBC Sport online. Includes live sports coverage, breaking news, results, video, audio and analysis on Football, F1, Cricket, Rugby Union, Rugby League, Golf, Tennis and all the main world sports, plus major events such as the Olympic Games.",
      "url": "http://www.bbc.co.uk/sport",
      "category": "sports",
      "language": "en",
      "country": "gb"
    },
    {
      "id": "bild",
      "name": "Bild",
      "description":
          "Die Seite 1 für aktuelle Nachrichten und Themen, Bilder und Videos aus den Bereichen News, Wirtschaft, Politik, Show, Sport, und Promis.",
      "url": "http://www.bild.de",
      "category": "general",
      "language": "de",
      "country": "de"
    },
    {
      "id": "blasting-news-br",
      "name": "Blasting News (BR)",
      "description":
          "Descubra a seção brasileira da Blasting News, a primeira revista feita pelo  público, com notícias globais e vídeos independentes. Junte-se a nós e torne- se um repórter.",
      "url": "https://br.blastingnews.com",
      "category": "general",
      "language": "pt",
      "country": "br"
    },
    {
      "id": "bleacher-report",
      "name": "Bleacher Report",
      "description":
          "Sports journalists and bloggers covering NFL, MLB, NBA, NHL, MMA, college football and basketball, NASCAR, fantasy sports and more. News, photos, mock drafts, game scores, player profiles and more!",
      "url": "http://www.bleacherreport.com",
      "category": "sports",
      "language": "en",
      "country": "us"
    },
    {
      "id": "bloomberg",
      "name": "Bloomberg",
      "description":
          "Bloomberg delivers business and markets news, data, analysis, and video to the world, featuring stories from Businessweek and Bloomberg News.",
      "url": "http://www.bloomberg.com",
      "category": "business",
      "language": "en",
      "country": "us"
    },
    {
      "id": "breitbart-news",
      "name": "Breitbart News",
      "description":
          "Syndicated news and opinion website providing continuously updated headlines to top news and analysis sources.",
      "url": "http://www.breitbart.com",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "business-insider",
      "name": "Business Insider",
      "description":
          "Business Insider is a fast-growing business site with deep financial, media, tech, and other industry verticals. Launched in 2007, the site is now the largest business news site on the web.",
      "url": "http://www.businessinsider.com",
      "category": "business",
      "language": "en",
      "country": "us"
    },
    {
      "id": "buzzfeed",
      "name": "Buzzfeed",
      "description":
          "BuzzFeed is a cross-platform, global network for news and entertainment that generates seven billion views each month.",
      "url": "https://www.buzzfeed.com",
      "category": "entertainment",
      "language": "en",
      "country": "us"
    },
    {
      "id": "cbc-news",
      "name": "CBC News",
      "description":
          "CBC News is the division of the Canadian Broadcasting Corporation responsible for the news gathering and production of news programs on the corporation's English-language operations, namely CBC Television, CBC Radio, CBC News Network, and CBC.ca.",
      "url": "http://www.cbc.ca/news",
      "category": "general",
      "language": "en",
      "country": "ca"
    },
    {
      "id": "cbs-news",
      "name": "CBS News",
      "description":
          "CBS News: dedicated to providing the best in journalism under standards it pioneered at the dawn of radio and television and continue in the digital age.",
      "url": "http://www.cbsnews.com",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "cnn",
      "name": "CNN",
      "description":
          "View the latest news and breaking news today for U.S., world, weather, entertainment, politics and health at CNN",
      "url": "http://us.cnn.com",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "cnn-es",
      "name": "CNN Spanish",
      "description":
          "Lee las últimas noticias e información sobre Latinoamérica, Estados Unidos, mundo, entretenimiento, política, salud, tecnología y deportes en CNNEspañol.com.",
      "url": "http://cnnespanol.cnn.com/",
      "category": "general",
      "language": "es",
      "country": "us"
    },
    {
      "id": "crypto-coins-news",
      "name": "Crypto Coins News",
      "description":
          "Providing breaking cryptocurrency news - focusing on Bitcoin, Ethereum, ICOs, blockchain technology, and smart contracts.",
      "url": "https://www.ccn.com",
      "category": "technology",
      "language": "en",
      "country": "us"
    },
    {
      "id": "der-tagesspiegel",
      "name": "Der Tagesspiegel",
      "description":
          "Nachrichten, News und neueste Meldungen aus dem Inland und dem Ausland - aktuell präsentiert von tagesspiegel.de.",
      "url": "http://www.tagesspiegel.de",
      "category": "general",
      "language": "de",
      "country": "de"
    },
    {
      "id": "die-zeit",
      "name": "Die Zeit",
      "description":
          "Aktuelle Nachrichten, Kommentare, Analysen und Hintergrundberichte aus Politik, Wirtschaft, Gesellschaft, Wissen, Kultur und Sport lesen Sie auf ZEIT ONLINE.",
      "url": "http://www.zeit.de/index",
      "category": "business",
      "language": "de",
      "country": "de"
    },
    {
      "id": "el-mundo",
      "name": "El Mundo",
      "description":
          "Noticias, actualidad, álbumes, debates, sociedad, servicios, entretenimiento y última hora en España y el mundo.",
      "url": "http://www.elmundo.es",
      "category": "general",
      "language": "es",
      "country": "es"
    },
    {
      "id": "engadget",
      "name": "Engadget",
      "description":
          "Engadget is a web magazine with obsessive daily coverage of everything new in gadgets and consumer electronics.",
      "url": "https://www.engadget.com",
      "category": "technology",
      "language": "en",
      "country": "us"
    },
    {
      "id": "entertainment-weekly",
      "name": "Entertainment Weekly",
      "description":
          "Online version of the print magazine includes entertainment news, interviews, reviews of music, film, TV and books, and a special area for magazine subscribers.",
      "url": "http://www.ew.com",
      "category": "entertainment",
      "language": "en",
      "country": "us"
    },
    {
      "id": "espn",
      "name": "ESPN",
      "description":
          "ESPN has up-to-the-minute sports news coverage, scores, highlights and commentary for NFL, MLB, NBA, College Football, NCAA Basketball and more.",
      "url": "https://www.espn.com",
      "category": "sports",
      "language": "en",
      "country": "us"
    },
    {
      "id": "espn-cric-info",
      "name": "ESPN Cric Info",
      "description":
          "ESPN Cricinfo provides the most comprehensive cricket coverage available including live ball-by-ball commentary, news, unparalleled statistics, quality editorial comment and analysis.",
      "url": "http://www.espncricinfo.com/",
      "category": "sports",
      "language": "en",
      "country": "us"
    },
    {
      "id": "financial-post",
      "name": "Financial Post",
      "description":
          "Find the latest happenings in the Canadian Financial Sector and stay up to date with changing trends in Business Markets. Read trading and investing advice from professionals.",
      "url": "https://financialpost.com",
      "category": "business",
      "language": "en",
      "country": "ca"
    },
    {
      "id": "focus",
      "name": "Focus",
      "description":
          "Minutenaktuelle Nachrichten und Service-Informationen von Deutschlands modernem Nachrichtenmagazin.",
      "url": "http://www.focus.de",
      "category": "general",
      "language": "de",
      "country": "de"
    },
    {
      "id": "football-italia",
      "name": "Football Italia",
      "description":
          "Italian football news, analysis, fixtures and results for the latest from Serie A, Serie B and the Azzurri.",
      "url": "http://www.football-italia.net",
      "category": "sports",
      "language": "en",
      "country": "it"
    },
    {
      "id": "fortune",
      "name": "Fortune",
      "description": "Fortune 500 Daily and Breaking Business News",
      "url": "http://fortune.com",
      "category": "business",
      "language": "en",
      "country": "us"
    },
    {
      "id": "four-four-two",
      "name": "FourFourTwo",
      "description":
          "The latest football news, in-depth features, tactical and statistical analysis from FourFourTwo, the UK&#039;s favourite football monthly.",
      "url": "http://www.fourfourtwo.com/news",
      "category": "sports",
      "language": "en",
      "country": "gb"
    },
    {
      "id": "fox-news",
      "name": "Fox News",
      "description":
          "Breaking News, Latest News and Current News from FOXNews.com. Breaking news and video. Latest Current News: U.S., World, Entertainment, Health, Business, Technology, Politics, Sports.",
      "url": "http://www.foxnews.com",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "fox-sports",
      "name": "Fox Sports",
      "description":
          "Find live scores, player and team news, videos, rumors, stats, standings, schedules and fantasy games on FOX Sports.",
      "url": "http://www.foxsports.com",
      "category": "sports",
      "language": "en",
      "country": "us"
    },
    {
      "id": "globo",
      "name": "Globo",
      "description":
          "Só na globo.com você encontra tudo sobre o conteúdo e marcas do Grupo Globo. O melhor acervo de vídeos online sobre entretenimento, esportes e jornalismo do Brasil.",
      "url": "http://www.globo.com/",
      "category": "general",
      "language": "pt",
      "country": "br"
    },
    {
      "id": "google-news",
      "name": "Google News",
      "description":
          "Comprehensive, up-to-date news coverage, aggregated from sources all over the world by Google News.",
      "url": "https://news.google.com",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "google-news-ar",
      "name": "Google News (Argentina)",
      "description":
          "Completa cobertura actualizada de noticias agregadas a partir de fuentes de todo el mundo por Google Noticias.",
      "url": "https://news.google.com",
      "category": "general",
      "language": "es",
      "country": "ar"
    },
    {
      "id": "google-news-au",
      "name": "Google News (Australia)",
      "description":
          "Comprehensive, up-to-date Australia news coverage, aggregated from sources all over the world by Google News.",
      "url": "https://news.google.com",
      "category": "general",
      "language": "en",
      "country": "au"
    },
    {
      "id": "google-news-br",
      "name": "Google News (Brasil)",
      "description":
          "Cobertura jornalística abrangente e atualizada, agregada de fontes do mundo inteiro pelo Google Notícias.",
      "url": "https://news.google.com",
      "category": "general",
      "language": "pt",
      "country": "br"
    },
    {
      "id": "google-news-ca",
      "name": "Google News (Canada)",
      "description":
          "Comprehensive, up-to-date Canada news coverage, aggregated from sources all over the world by Google News.",
      "url": "https://news.google.com",
      "category": "general",
      "language": "en",
      "country": "ca"
    },
    {
      "id": "google-news-fr",
      "name": "Google News (France)",
      "description":
          "Informations complètes et à jour, compilées par Google Actualités à partir de sources d&#39;actualités du monde entier.",
      "url": "https://news.google.com",
      "category": "general",
      "language": "fr",
      "country": "fr"
    },
    {
      "id": "google-news-in",
      "name": "Google News (India)",
      "description":
          "Comprehensive, up-to-date India news coverage, aggregated from sources all over the world by Google News.",
      "url": "https://news.google.com",
      "category": "general",
      "language": "en",
      "country": "in"
    },
    {
      "id": "google-news-is",
      "name": "Google News (Israel)",
      "description":
          "כיסוי מקיף ועדכני של חדשות שהצטברו ממקורות בכל העולם על ידי &#39;חדשות Google&#39;.",
      "url": "https://news.google.com",
      "category": "general",
      "language": "he",
      "country": "is"
    },
    {
      "id": "google-news-it",
      "name": "Google News (Italy)",
      "description":
          "Copertura giornalistica completa e aggiornata ottenuta combinando fonti di notizie in tutto il mondo attraverso Google News.",
      "url": "https://news.google.com",
      "category": "general",
      "language": "it",
      "country": "it"
    },
    {
      "id": "google-news-ru",
      "name": "Google News (Russia)",
      "description":
          "Исчерпывающая и актуальная информация, собранная службой &quot;Новости Google&quot; со всего света.",
      "url": "https://news.google.com",
      "category": "general",
      "language": "ru",
      "country": "ru"
    },
    {
      "id": "google-news-sa",
      "name": "Google News (Saudi Arabia)",
      "description":
          "تغطية شاملة ومتجددة للأخبار، تم جمعها من مصادر أخبار من جميع أنحاء العالم بواسطة أخبار Google.",
      "url": "https://news.google.com",
      "category": "general",
      "language": "ar",
      "country": "sa"
    },
    {
      "id": "google-news-uk",
      "name": "Google News (UK)",
      "description":
          "Comprehensive, up-to-date UK news coverage, aggregated from sources all over the world by Google News.",
      "url": "https://news.google.com",
      "category": "general",
      "language": "en",
      "country": "gb"
    },
    {
      "id": "goteborgs-posten",
      "name": "Göteborgs-Posten",
      "description":
          "Göteborgs-Posten, abbreviated GP, is a major Swedish language daily newspaper published in Gothenburg, Sweden.",
      "url": "http://www.gp.se",
      "category": "general",
      "language": "sv",
      "country": "se"
    },
    {
      "id": "gruenderszene",
      "name": "Gruenderszene",
      "description":
          "Online-Magazin für Startups und die digitale Wirtschaft. News und Hintergründe zu Investment, VC und Gründungen.",
      "url": "http://www.gruenderszene.de",
      "category": "technology",
      "language": "de",
      "country": "de"
    },
    {
      "id": "hacker-news",
      "name": "Hacker News",
      "description":
          "Hacker News is a social news website focusing on computer science and entrepreneurship. It is run by Paul Graham's investment fund and startup incubator, Y Combinator. In general, content that can be submitted is defined as \"anything that gratifies one's intellectual curiosity\".",
      "url": "https://news.ycombinator.com",
      "category": "technology",
      "language": "en",
      "country": "us"
    },
    {
      "id": "handelsblatt",
      "name": "Handelsblatt",
      "description":
          "Auf Handelsblatt lesen sie Nachrichten über Unternehmen, Finanzen, Politik und Technik. Verwalten Sie Ihre Finanzanlagen mit Hilfe unserer Börsenkurse.",
      "url": "http://www.handelsblatt.com",
      "category": "business",
      "language": "de",
      "country": "de"
    },
    {
      "id": "ign",
      "name": "IGN",
      "description":
          "IGN is your site for Xbox One, PS4, PC, Wii-U, Xbox 360, PS3, Wii, 3DS, PS Vita and iPhone games with expert reviews, news, previews, trailers, cheat codes, wiki guides and walkthroughs.",
      "url": "http://www.ign.com",
      "category": "entertainment",
      "language": "en",
      "country": "us"
    },
    {
      "id": "il-sole-24-ore",
      "name": "Il Sole 24 Ore",
      "description":
          "Notizie di economia, cronaca italiana ed estera, quotazioni borsa in tempo reale e di finanza, norme e tributi, fondi e obbligazioni, mutui, prestiti e lavoro a cura de Il Sole 24 Ore.",
      "url": "https://www.ilsole24ore.com",
      "category": "business",
      "language": "it",
      "country": "it"
    },
    {
      "id": "independent",
      "name": "Independent",
      "description":
          "National morning quality (tabloid) includes free online access to news and supplements. Insight by Robert Fisk and various other columnists.",
      "url": "http://www.independent.co.uk",
      "category": "general",
      "language": "en",
      "country": "gb"
    },
    {
      "id": "infobae",
      "name": "Infobae",
      "description":
          "Noticias de Argentina y del mundo en tiempo real. Información, videos y fotos sobre los hechos más relevantes y sus protagonistas. Léelo antes en infobae.",
      "url": "http://www.infobae.com/?noredirect",
      "category": "general",
      "language": "es",
      "country": "ar"
    },
    {
      "id": "info-money",
      "name": "InfoMoney",
      "description":
          "No InfoMoney você encontra tudo o que precisa sobre dinheiro. Ações, investimentos, bolsas de valores e muito mais. Aqui você encontra informação que vale dinheiro!",
      "url": "https://www.infomoney.com.br",
      "category": "business",
      "language": "pt",
      "country": "br"
    },
    {
      "id": "la-gaceta",
      "name": "La Gaceta",
      "description":
          "El diario de Tucumán, noticias 24 horas online - San Miguel de Tucumán - Argentina - Ultimo momento - Ultimas noticias.",
      "url": "http://www.lagaceta.com.ar",
      "category": "general",
      "language": "es",
      "country": "ar"
    },
    {
      "id": "la-nacion",
      "name": "La Nacion",
      "description":
          "Información confiable en Internet. Noticias de Argentina y del mundo - ¡Informate ya!",
      "url": "http://www.lanacion.com.ar",
      "category": "general",
      "language": "es",
      "country": "ar"
    },
    {
      "id": "la-repubblica",
      "name": "La Repubblica",
      "description":
          "Breaking News, Latest News and Current News from FOXNews.com. Breaking news and video. Latest Current News: U.S., World, Entertainment, Health, Business, Technology, Politics, Sports.",
      "url": "http://www.repubblica.it",
      "category": "general",
      "language": "it",
      "country": "it"
    },
    {
      "id": "le-monde",
      "name": "Le Monde",
      "description":
          "Les articles du journal et toute l'actualit&eacute; en continu : International, France, Soci&eacute;t&eacute;, Economie, Culture, Environnement, Blogs ...",
      "url": "http://www.lemonde.fr",
      "category": "general",
      "language": "fr",
      "country": "fr"
    },
    {
      "id": "lenta",
      "name": "Lenta",
      "description":
          "Новости, статьи, фотографии, видео. Семь дней в неделю, 24 часа в сутки.",
      "url": "https://lenta.ru",
      "category": "general",
      "language": "ru",
      "country": "ru"
    },
    {
      "id": "lequipe",
      "name": "L'equipe",
      "description":
          "Le sport en direct sur L'EQUIPE.fr. Les informations, résultats et classements de tous les sports. Directs commentés, images et vidéos à regarder et à partager !",
      "url": "https://www.lequipe.fr",
      "category": "sports",
      "language": "fr",
      "country": "fr"
    },
    {
      "id": "les-echos",
      "name": "Les Echos",
      "description":
          "Toute l'actualité économique, financière et boursière française et internationale sur Les Echos.fr",
      "url": "https://www.lesechos.fr",
      "category": "business",
      "language": "fr",
      "country": "fr"
    },
    {
      "id": "liberation",
      "name": "Libération",
      "description":
          "Toute l'actualité en direct - photos et vidéos avec Libération",
      "url": "http://www.liberation.fr",
      "category": "general",
      "language": "fr",
      "country": "fr"
    },
    {
      "id": "marca",
      "name": "Marca",
      "description":
          "La mejor información deportiva en castellano actualizada minuto a minuto en noticias, vídeos, fotos, retransmisiones y resultados en directo.",
      "url": "http://www.marca.com",
      "category": "sports",
      "language": "es",
      "country": "es"
    },
    {
      "id": "mashable",
      "name": "Mashable",
      "description":
          "Mashable is a global, multi-platform media and entertainment company.",
      "url": "https://mashable.com",
      "category": "entertainment",
      "language": "en",
      "country": "us"
    },
    {
      "id": "medical-news-today",
      "name": "Medical News Today",
      "description":
          "Medical news and health news headlines posted throughout the day, every day.",
      "url": "http://www.medicalnewstoday.com",
      "category": "health",
      "language": "en",
      "country": "us"
    },
    {
      "id": "msnbc",
      "name": "MSNBC",
      "description":
          "Breaking news and in-depth analysis of the headlines, as well as commentary and informed perspectives from The Rachel Maddow Show, Morning Joe & more.",
      "url": "http://www.msnbc.com",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "mtv-news",
      "name": "MTV News",
      "description":
          "The ultimate news source for music, celebrity, entertainment, movies, and current events on the web. It's pop culture on steroids.",
      "url": "http://www.mtv.com/news",
      "category": "entertainment",
      "language": "en",
      "country": "us"
    },
    {
      "id": "mtv-news-uk",
      "name": "MTV News (UK)",
      "description":
          "All the latest celebrity news, gossip, exclusive interviews and pictures from the world of music and entertainment.",
      "url": "http://www.mtv.co.uk/news",
      "category": "entertainment",
      "language": "en",
      "country": "gb"
    },
    {
      "id": "national-geographic",
      "name": "National Geographic",
      "description":
          "Reporting our world daily: original nature and science news from National Geographic.",
      "url": "http://news.nationalgeographic.com",
      "category": "science",
      "language": "en",
      "country": "us"
    },
    {
      "id": "national-review",
      "name": "National Review",
      "description":
          "National Review: Conservative News, Opinion, Politics, Policy, & Current Events.",
      "url": "https://www.nationalreview.com/",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "nbc-news",
      "name": "NBC News",
      "description":
          "Breaking news, videos, and the latest top stories in world news, business, politics, health and pop culture.",
      "url": "http://www.nbcnews.com",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "news24",
      "name": "News24",
      "description":
          "South Africa's premier news source, provides breaking news on national, world, Africa, sport, entertainment, technology and more.",
      "url": "http://www.news24.com",
      "category": "general",
      "language": "en",
      "country": "za"
    },
    {
      "id": "new-scientist",
      "name": "New Scientist",
      "description":
          "Breaking science and technology news from around the world. Exclusive stories and expert analysis on space, technology, health, physics, life and Earth.",
      "url": "https://www.newscientist.com/section/news",
      "category": "science",
      "language": "en",
      "country": "us"
    },
    {
      "id": "news-com-au",
      "name": "News.com.au",
      "description":
          "We say what people are thinking and cover the issues that get people talking balancing Australian and global moments — from politics to pop culture.",
      "url": "http://www.news.com.au",
      "category": "general",
      "language": "en",
      "country": "au"
    },
    {
      "id": "newsweek",
      "name": "Newsweek",
      "description":
          "Newsweek provides in-depth analysis, news and opinion about international issues, technology, business, culture and politics.",
      "url": "https://www.newsweek.com",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "new-york-magazine",
      "name": "New York Magazine",
      "description":
          "NYMAG and New York magazine cover the new, the undiscovered, the next in politics, culture, food, fashion, and behavior nationally, through a New York lens.",
      "url": "https://nymag.com/",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "next-big-future",
      "name": "Next Big Future",
      "description":
          "Coverage of science and technology that have the potential for disruption, and analysis of plans, policies, and technology that enable radical improvement.",
      "url": "https://www.nextbigfuture.com",
      "category": "science",
      "language": "en",
      "country": "us"
    },
    {
      "id": "nfl-news",
      "name": "NFL News",
      "description":
          "The official source for NFL news, schedules, stats, scores and more.",
      "url": "https://www.nfl.com",
      "category": "sports",
      "language": "en",
      "country": "us"
    },
    {
      "id": "nhl-news",
      "name": "NHL News",
      "description":
          "The most up-to-date breaking hockey news from the official source including interviews, rumors, statistics and schedules.",
      "url": "https://www.nhl.com/news",
      "category": "sports",
      "language": "en",
      "country": "us"
    },
    {
      "id": "nrk",
      "name": "NRK",
      "description":
          "NRK er Norges største tilbud på nett: nyheter fra Norge og verden, lokalnyheter, radio- og tv-program, podcast, vær, helse-, kultur-, underholdning-, humor- og debattstoff.",
      "url": "https://www.nrk.no",
      "category": "general",
      "language": "no",
      "country": "no"
    },
    {
      "id": "politico",
      "name": "Politico",
      "description":
          "Political news about Congress, the White House, campaigns, lobbyists and issues.",
      "url": "https://www.politico.com",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "polygon",
      "name": "Polygon",
      "description":
          "Polygon is a gaming website in partnership with Vox Media. Our culture focused site covers games, their creators, the fans, trending stories and entertainment news.",
      "url": "http://www.polygon.com",
      "category": "entertainment",
      "language": "en",
      "country": "us"
    },
    {
      "id": "rbc",
      "name": "RBC",
      "description":
          "Главные новости политики, экономики и бизнеса, комментарии аналитиков, финансовые данные с российских и мировых биржевых систем на сайте rbc.ru.",
      "url": "https://www.rbc.ru",
      "category": "general",
      "language": "ru",
      "country": "ru"
    },
    {
      "id": "recode",
      "name": "Recode",
      "description":
          "Get the latest independent tech news, reviews and analysis from Recode with the most informed and respected journalists in technology and media.",
      "url": "http://www.recode.net",
      "category": "technology",
      "language": "en",
      "country": "us"
    },
    {
      "id": "reddit-r-all",
      "name": "Reddit /r/all",
      "description":
          "Reddit is an entertainment, social news networking service, and news website. Reddit's registered community members can submit content, such as text posts or direct links.",
      "url": "https://www.reddit.com/r/all",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "reuters",
      "name": "Reuters",
      "description":
          "Reuters.com brings you the latest news from around the world, covering breaking news in business, politics, entertainment, technology, video and pictures.",
      "url": "https://www.reuters.com",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "rt",
      "name": "RT",
      "description":
          "Актуальная картина дня на RT: круглосуточное ежедневное обновление новостей политики, бизнеса, финансов, спорта, науки, культуры. Онлайн-репортажи с места событий. Комментарии экспертов, актуальные интервью, фото и видео репортажи.",
      "url": "https://russian.rt.com",
      "category": "general",
      "language": "ru",
      "country": "ru"
    },
    {
      "id": "rte",
      "name": "RTE",
      "description":
          "Get all of the latest breaking local and international news stories as they happen, with up to the minute updates and analysis, from Ireland's National Broadcaster.",
      "url": "https://www.rte.ie/news",
      "category": "general",
      "language": "en",
      "country": "ie"
    },
    {
      "id": "rtl-nieuws",
      "name": "RTL Nieuws",
      "description":
          "Volg het nieuws terwijl het gebeurt. RTL Nieuws informeert haar lezers op een onafhankelijke, boeiende en toegankelijke wijze over belangrijke ontwikkelingen in eigen land en de rest van de wereld.",
      "url": "https://www.rtlnieuws.nl/",
      "category": "general",
      "language": "nl",
      "country": "nl"
    },
    {
      "id": "sabq",
      "name": "SABQ",
      "description":
          "صحيفة الكترونية سعودية هدفها السبق في نقل الحدث بمهنية ومصداقية خدمة للوطن والمواطن.",
      "url": "https://sabq.org",
      "category": "general",
      "language": "ar",
      "country": "sa"
    },
    {
      "id": "spiegel-online",
      "name": "Spiegel Online",
      "description":
          "Deutschlands führende Nachrichtenseite. Alles Wichtige aus Politik, Wirtschaft, Sport, Kultur, Wissenschaft, Technik und mehr.",
      "url": "http://www.spiegel.de",
      "category": "general",
      "language": "de",
      "country": "de"
    },
    {
      "id": "svenska-dagbladet",
      "name": "Svenska Dagbladet",
      "description":
          "Sveriges ledande mediesajt - SvD.se. Svenska Dagbladets nyhetssajt låter läsarna ta plats och fördjupar nyheterna.",
      "url": "https://www.svd.se",
      "category": "general",
      "language": "sv",
      "country": "se"
    },
    {
      "id": "t3n",
      "name": "T3n",
      "description":
          "Das Online-Magazin bietet Artikel zu den Themen E-Business, Social Media, Startups und Webdesign.",
      "url": "https://t3n.de",
      "category": "technology",
      "language": "de",
      "country": "de"
    },
    {
      "id": "talksport",
      "name": "TalkSport",
      "description":
          "Tune in to the world's biggest sports radio station - Live Premier League football coverage, breaking sports news, transfer rumours &amp; exclusive interviews.",
      "url": "http://talksport.com",
      "category": "sports",
      "language": "en",
      "country": "gb"
    },
    {
      "id": "techcrunch",
      "name": "TechCrunch",
      "description":
          "TechCrunch is a leading technology media property, dedicated to obsessively profiling startups, reviewing new Internet products, and breaking tech news.",
      "url": "https://techcrunch.com",
      "category": "technology",
      "language": "en",
      "country": "us"
    },
    {
      "id": "techcrunch-cn",
      "name": "TechCrunch (CN)",
      "description":
          "TechCrunch is a leading technology media property, dedicated to obsessively profiling startups, reviewing new Internet products, and breaking tech news.",
      "url": "https://techcrunch.cn",
      "category": "technology",
      "language": "zh",
      "country": "zh"
    },
    {
      "id": "techradar",
      "name": "TechRadar",
      "description":
          "The latest technology news and reviews, covering computing, home entertainment systems, gadgets and more.",
      "url": "https://www.techradar.com",
      "category": "technology",
      "language": "en",
      "country": "us"
    },
    {
      "id": "the-american-conservative",
      "name": "The American Conservative",
      "description":
          "Realism and reform. A new voice for a new generation of conservatives.",
      "url": "http://www.theamericanconservative.com/",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "the-globe-and-mail",
      "name": "The Globe And Mail",
      "description":
          "The Globe and Mail offers the most authoritative news in Canada, featuring national and international news.",
      "url": "https://www.theglobeandmail.com",
      "category": "general",
      "language": "en",
      "country": "ca"
    },
    {
      "id": "the-hill",
      "name": "The Hill",
      "description":
          "The Hill is a top US political website, read by the White House and more lawmakers than any other site -- vital for policy, politics and election campaigns.",
      "url": "https://thehill.com",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "the-hindu",
      "name": "The Hindu",
      "description":
          "The Hindu. latest news, analysis, comment, in-depth coverage of politics, business, sport, environment, cinema and arts from India's national newspaper.",
      "url": "http://www.thehindu.com",
      "category": "general",
      "language": "en",
      "country": "in"
    },
    {
      "id": "the-huffington-post",
      "name": "The Huffington Post",
      "description":
          "The Huffington Post is a politically liberal American online news aggregator and blog that has both localized and international editions founded by Arianna Huffington, Kenneth Lerer, Andrew Breitbart, and Jonah Peretti, featuring columnists.",
      "url": "http://www.huffingtonpost.com",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "the-irish-times",
      "name": "The Irish Times",
      "description":
          "The Irish Times online. Latest news including sport, analysis, business, weather and more from the definitive brand of quality news in Ireland.",
      "url": "https://www.irishtimes.com",
      "category": "general",
      "language": "en",
      "country": "ie"
    },
    {
      "id": "the-jerusalem-post",
      "name": "The Jerusalem Post",
      "description":
          "The Jerusalem Post is the leading online newspaper for English speaking Jewry since 1932, bringing news and updates from the Middle East and all over the Jewish world.",
      "url": "https://www.jpost.com/",
      "category": "general",
      "language": "en",
      "country": "is"
    },
    {
      "id": "the-lad-bible",
      "name": "The Lad Bible",
      "description":
          "The LAD Bible is one of the largest community for guys aged 16-30 in the world. Send us your funniest pictures and videos!",
      "url": "https://www.theladbible.com",
      "category": "entertainment",
      "language": "en",
      "country": "gb"
    },
    {
      "id": "the-next-web",
      "name": "The Next Web",
      "description":
          "The Next Web is one of the world’s largest online publications that delivers an international perspective on the latest news about Internet technology, business and culture.",
      "url": "http://thenextweb.com",
      "category": "technology",
      "language": "en",
      "country": "us"
    },
    {
      "id": "the-sport-bible",
      "name": "The Sport Bible",
      "description":
          "TheSPORTbible is one of the largest communities for sports fans across the world. Send us your sporting pictures and videos!",
      "url": "https://www.thesportbible.com",
      "category": "sports",
      "language": "en",
      "country": "gb"
    },
    {
      "id": "the-times-of-india",
      "name": "The Times of India",
      "description":
          "Times of India brings the Latest News and Top Breaking headlines on Politics and Current Affairs in India and around the World, Sports, Business, Bollywood News and Entertainment, Science, Technology, Health and Fitness news, Cricket and opinions from leading columnists.",
      "url": "http://timesofindia.indiatimes.com",
      "category": "general",
      "language": "en",
      "country": "in"
    },
    {
      "id": "the-verge",
      "name": "The Verge",
      "description":
          "The Verge covers the intersection of technology, science, art, and culture.",
      "url": "http://www.theverge.com",
      "category": "technology",
      "language": "en",
      "country": "us"
    },
    {
      "id": "the-wall-street-journal",
      "name": "The Wall Street Journal",
      "description":
          "WSJ online coverage of breaking news and current headlines from the US and around the world. Top stories, photos, videos, detailed analysis and in-depth reporting.",
      "url": "https://www.wsj.com",
      "category": "business",
      "language": "en",
      "country": "us"
    },
    {
      "id": "the-washington-post",
      "name": "The Washington Post",
      "description":
          "Breaking news and analysis on politics, business, world national news, entertainment more. In-depth DC, Virginia, Maryland news coverage including traffic, weather, crime, education, restaurant reviews and more.",
      "url": "https://www.washingtonpost.com",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "the-washington-times",
      "name": "The Washington Times",
      "description":
          "The Washington Times delivers breaking news and commentary on the issues that affect the future of our nation.",
      "url": "https://www.washingtontimes.com/",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "time",
      "name": "Time",
      "description":
          "Breaking news and analysis from TIME.com. Politics, world news, photos, video, tech reviews, health, science and entertainment news.",
      "url": "http://time.com",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "usa-today",
      "name": "USA Today",
      "description":
          "Get the latest national, international, and political news at USATODAY.com.",
      "url": "http://www.usatoday.com/news",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "vice-news",
      "name": "Vice News",
      "description":
          "Vice News is Vice Media, Inc.'s current affairs channel, producing daily documentary essays and video through its website and YouTube channel. It promotes itself on its coverage of \"under - reported stories\".",
      "url": "https://news.vice.com",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "wired",
      "name": "Wired",
      "description":
          "Wired is a monthly American magazine, published in print and online editions, that focuses on how emerging technologies affect culture, the economy, and politics.",
      "url": "https://www.wired.com",
      "category": "technology",
      "language": "en",
      "country": "us"
    },
    {
      "id": "wired-de",
      "name": "Wired.de",
      "description":
          "Wired reports on how emerging technologies affect culture, the economy and politics.",
      "url": "https://www.wired.de",
      "category": "technology",
      "language": "de",
      "country": "de"
    },
    {
      "id": "wirtschafts-woche",
      "name": "Wirtschafts Woche",
      "description":
          "Das Online-Portal des führenden Wirtschaftsmagazins in Deutschland. Das Entscheidende zu Unternehmen, Finanzen, Erfolg und Technik.",
      "url": "http://www.wiwo.de",
      "category": "business",
      "language": "de",
      "country": "de"
    },
    {
      "id": "xinhua-net",
      "name": "Xinhua Net",
      "description":
          "中国主要重点新闻网站,依托新华社遍布全球的采编网络,记者遍布世界100多个国家和地区,地方频道分布全国31个省市自治区,每天24小时同时使用6种语言滚动发稿,权威、准确、及时播发国内外重要新闻和重大突发事件,受众覆盖200多个国家和地区,发展论坛是全球知名的中文论坛。",
      "url": "http://xinhuanet.com/",
      "category": "general",
      "language": "zh",
      "country": "zh"
    },
    {
      "id": "ynet",
      "name": "Ynet",
      "description":
          "ynet דף הבית: אתר החדשות המוביל בישראל מבית ידיעות אחרונות. סיקור מלא של חדשות מישראל והעולם, ספורט, כלכלה, תרבות, אוכל, מדע וטבע, כל מה שקורה וכל מה שמעניין ב ynet.",
      "url": "http://www.ynet.co.il",
      "category": "general",
      "language": "he",
      "country": "is"
    }
  ]
};
