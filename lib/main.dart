import 'package:flutter/material.dart';
import 'package:flutter_application_featching_api/model/book.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch API',
      home: FetchAPI(),
    );
  }
}

class FetchAPI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fetch API"), centerTitle: true),
      body: Container(
        child: FutureBuilder(
          future: BookModel.fetch(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              var data = snapshot.data;
              print(data);

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = data[index];

                  return Column(
                    children: [
                      Text("Judul: " + item['volumeInfo']['title']),
                      Text("Subtitle: " + item['volumeInfo']['subtitle']),
                       Text("Penulis: " + item['volumeInfo']['authors'][0])
                      ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
