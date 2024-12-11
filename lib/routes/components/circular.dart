import 'dart:convert';
import 'package:employ_service/api/api_list.dart';
import 'package:employ_service/routes/components/side_menu.dart';
import 'package:employ_service/theme/app_theme.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:employ_service/routes/components/custom_sliver_app_bar.dart';

class Circular extends StatefulWidget {
  const Circular({super.key});
  @override
  State<Circular> createState() => _CircularState();
}

class _CircularState extends State<Circular> {
  late List<CircularData> circulardata = <CircularData>[];

  void getCirculars() async {
    final response = await http.get(Uri.parse(API.circulars));
    final body = response.body;
    //print(body);
    final json = jsonDecode(body);
    //  print(json);
    setState(() {
      // data = json;
      //print(Users[0]);
      // print(Users.length);
      for (var i = 0; i < json.length; i++) {
        var cri = json[i];
        circulardata.add(CircularData('${cri['name']}', '${cri['link']}'));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getCirculars();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      title: 'Employee Service',
      home: Scaffold(
        appBar: null,
        drawer: SideMenu(),
        body: CustomScrollView(
          slivers: [
            CustomSliverAppBar(),
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const AutoSizeText(
                    "List Of Service Books",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  for (var i = 0; i < circulardata.length; i++) ...[
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (_) => PDFViewerFromUrl(
                            url: circulardata[i].link.toString(),
                          ),
                        ),
                      ),
                      child: Text(circulardata[i].name),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PDFViewerFromUrl extends StatefulWidget {
  PDFViewerFromUrl({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  State<PDFViewerFromUrl> createState() => _PDFViewerFromUrlState();
}

class _PDFViewerFromUrlState extends State<PDFViewerFromUrl> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        title: 'Employee Service',
        home: Scaffold(
          appBar: null,
          drawer: SideMenu(),
          body: const PDF(
                  enableSwipe: true,
                  swipeHorizontal: true,
                  autoSpacing: false,
                  pageFling: false,
                  fitPolicy: FitPolicy.BOTH)
              .fromUrl(
            widget.url,
            placeholder: (double progress) =>
                Center(child: Text('$progress %')),
            errorWidget: (dynamic error) =>
                Center(child: Text(error.toString())),
          ),
        ));
  }
}

class CircularData {
  CircularData(this.name, this.link);
  final String name;
  final String link;
}
