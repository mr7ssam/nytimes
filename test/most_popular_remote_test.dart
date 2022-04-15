import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:network/p_http_client.dart';
import 'package:nytimes/app/most_popular/data/data_sources/models/article_dto.dart';
import 'package:nytimes/app/most_popular/data/data_sources/remote/remote.dart';
import 'package:nytimes/app/most_popular/domain/params/params.dart';
import 'package:nytimes/common/const.dart';

main() async {
  group(
    'fetch most popular articles',
    () {
      final dio = DioClient(kBaseURL);
      final dioAdapter = DioAdapter(dio: dio);
      final MostPopularRemote mostPopularRemote = MostPopularRemote(dio);
      final path = RegExp('/mostpopular/v2/mostviewed/*');

      test('fetch success', () async {
        dioAdapter.onGet(path, (server) {
          server.reply(200, _fakeData);
        });
        final response =
            await mostPopularRemote.getMostPopular(MostPopularParams());
        expect(response, const TypeMatcher<List<ArticleDTO>>());
      });

      test('should throw [DioError] server error', () async {
        dioAdapter.onGet(path, (server) {
          server.throws(
            500,
            DioError(
              requestOptions: RequestOptions(
                path: path.pattern,
              ),
              error: DioErrorType.response,
            ),
          );
        });
        expect(() => mostPopularRemote.getMostPopular(MostPopularParams()),
            throwsA(isA<AppException<DioError>>()));
      });
    },
  );
}

final _fakeData = {
  "status": "OK",
  "copyright":
      "Copyright (c) 2022 The New York Times Company.  All Rights Reserved.",
  "num_results": 20,
  "results": [
    {
      "uri": "nyt://article/279a59f9-8baa-5381-8c37-d8610247c64c",
      "url":
          "https://www.nytimes.com/2022/04/13/us/grand-rapids-police-shooting-michigan-patrick-lyoya.html",
      "id": 100000008300888,
      "asset_id": 100000008300888,
      "source": "New York Times",
      "published_date": "2022-04-13",
      "updated": "2022-04-14 10:50:12",
      "section": "U.S.",
      "subsection": "",
      "nytdsection": "u.s.",
      "adx_keywords":
          "Police Brutality, Misconduct and Shootings;Black People;Lyoya, Patrick (d 2022);Grand Rapids (Mich)",
      "column": null,
      "byline": "By Mitch Smith",
      "type": "Article",
      "title":
          "Videos Show Police Officer Fatally Shooting Black Man in Michigan",
      "abstract":
          "Patrick Lyoya, 26, was killed by a Grand Rapids police officer last week during a traffic stop. Activists said the shooting followed years of unheeded calls for changes to the police force.",
      "des_facet": [
        "Police Brutality, Misconduct and Shootings",
        "Black People"
      ],
      "org_facet": [],
      "per_facet": ["Lyoya, Patrick (d 2022)"],
      "geo_facet": ["Grand Rapids (Mich)"],
      "media": [
        {
          "type": "image",
          "subtype": "photo",
          "caption":
              "Chief Eric Winstrom of the Grand Rapids Police Department, center, called the shooting a tragedy but declined to say whether he thought the officer followed department policy.",
          "copyright": "Nic Antaya for The New York Times",
          "approved_for_syndication": 1,
          "media-metadata": [
            {
              "url":
                  "https://static01.nyt.com/images/2022/04/13/us/13michigan-police-shooting01/13michigan-police-shooting01-thumbStandard.jpg",
              "format": "Standard Thumbnail",
              "height": 75,
              "width": 75
            },
            {
              "url":
                  "https://static01.nyt.com/images/2022/04/13/us/13michigan-police-shooting01/13michigan-police-shooting01-mediumThreeByTwo210.jpg",
              "format": "mediumThreeByTwo210",
              "height": 140,
              "width": 210
            },
            {
              "url":
                  "https://static01.nyt.com/images/2022/04/13/us/13michigan-police-shooting01/13michigan-police-shooting01-mediumThreeByTwo440.jpg",
              "format": "mediumThreeByTwo440",
              "height": 293,
              "width": 440
            }
          ]
        }
      ],
      "eta_id": 0
    },
  ]
};
