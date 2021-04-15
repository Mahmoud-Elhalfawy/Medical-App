import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
class GraphPage extends StatefulWidget {

  String imagePath;

  GraphPage(this.imagePath);

  @override
  _GraphPageState createState() => _GraphPageState();


}

class _GraphPageState extends State<GraphPage> {

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: PhotoView(
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.contained,
        imageProvider: AssetImage(widget.imagePath),
      ),
      );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,

    ]);
    super.dispose();

  }
}
