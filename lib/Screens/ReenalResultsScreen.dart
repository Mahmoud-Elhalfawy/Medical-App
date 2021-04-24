import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:flutter_thermometer/label.dart';
import 'package:flutter_thermometer/scale.dart';
import 'package:flutter_thermometer/setpoint.dart';
import 'package:flutter_thermometer/thermometer.dart';
import 'package:flutter_thermometer/thermometer_paint.dart';
import 'package:flutter_thermometer/thermometer_widget.dart';

class ReenalResultsScreen extends StatefulWidget {
  double eGFR , BONRatio;
  String renalState;
  ReenalResultsScreen({this.eGFR , this.BONRatio , this.renalState});
  @override
  _ReenalResultsScreenState createState() => _ReenalResultsScreenState();
}

class _ReenalResultsScreenState extends State<ReenalResultsScreen>
    with SingleTickerProviderStateMixin{

  AnimationController _animationController;
  final eGFRController = TextEditingController();
  img.Image photo;

  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1700),
    );
    _animationController.forward();
  }

  Widget createField(IconData icon, TextEditingController controller,
      String text, bool enabled, String image) {
    return TextField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      enabled: enabled,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        focusColor: Colors.white,
        hoverColor: Colors.green,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.pink[800])),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.red[700])),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.teal[800])),
        prefixIcon: image==null?Icon(icon):Padding(
          padding: const EdgeInsets.all(11.0),
          child: ImageIcon(AssetImage(image)),
        ),
        hintText: text,
      ),
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey, Colors.white],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Center(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  toolbarHeight: 60,
                  backgroundColor: Colors.pink.shade900,
                  shadowColor: Colors.black,
                  //expandedHeight: 100,
                  centerTitle: true,
                  automaticallyImplyLeading: true,
                  leadingWidth: 100,
                  stretch: true,
                  title: Text(
                    'Reenal App',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lobster',
                      fontSize: 30,
                    ),
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: Image.asset('images/kidney.png' , color: Colors.white,)),
                  ),
                ),
                SliverToBoxAdapter(
                  child: IntrinsicHeight(
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.9,
                        //maximum height set to 100% of vertical height
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white60,
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    createField(
                                        Icons.accessibility,
                                        eGFRController,
                                        '',
                                        true,null
                                    ),
                                    createField(Icons.umbrella_rounded, null, null, true,
                                        "images/urea.png"),
                                    SizedBox(
                                      height: 60,
                                      child: RaisedButton(
                                        child: Text(
                                          'See Results',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius.circular(30.0),
                                        ),
                                        color: Colors.pink.shade900,
                                        onPressed: () async {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


