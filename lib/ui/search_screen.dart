import 'package:flutter/material.dart';
import 'package:image_search_rewind/data/pixabay_api.dart';
import 'package:image_search_rewind/model/picture_result.dart';
import 'package:provider/src/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // String keyword = 'iphone';
  List<Picture> _pictures = [];

  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 한번 해야 하는 코드

    // initState에서 Context 접근 바로 안 됨
    // 여기까지는 context == null

    // 아주 잠깐 딜레이
    // 여기부터는 context 가 null 아님
    Future.microtask(() => _showResult('iphone'));
  }

  Future<void> _showResult(String query) async {
    // final api = PhotoApiProvider.of(context).api;
    final api = context.read<PixabayApi>();
    List<Picture> pictures = await api.fetchPhotos(query);
    setState(() {
      _pictures = pictures;
      // print(_pictures);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Network Sample"),
      ),
      body: Column(
        children: [
          Form(
            child: TextFormField(
              controller: _controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                icon: TextButton(
                  onPressed: () {
                    _showResult(_controller.text);
                  },
                  child: const Text('검색'),
                ),
              ),
            ),
          ),

          // _buildAlbums(futureTest),
          // FutureBuilder<List<Picture>>(
          //   future: _showResult(),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasError) {
          //       return const Center(child: Text('네트워크 에러!'));
          //     }
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(child: CircularProgressIndicator());
          //     }
          //     if (!snapshot.hasData) {
          //       return const Center(
          //         child: Text('데이터가 없습니다'),
          //       );
          //     }
          //     final List<Picture> albums = snapshot.data!;
          //     return _buildAlbums(albums);
          //   },
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: _pictures.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 180,
                        height: 100,
                        child: Image.network(
                          _pictures[index].previewURL,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(_pictures[index].tags)
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  // Widget _buildAlbums(List<Picture> albums) {
  //   return Expanded(
  //     child: ListView.builder(
  //       itemCount: albums.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         return Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             children: [
  //               SizedBox(
  //                 width: 180,
  //                 height: 100,
  //                 child: Image.network(
  //                   albums[index].previewURL,
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //               Text(albums[index].tags)
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}
