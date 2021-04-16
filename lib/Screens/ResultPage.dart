import 'package:app_trial1/Model/Case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:photo_view/photo_view.dart';

import 'GraphPage.dart';

class ResultPage extends StatefulWidget {
  Case patientCase;
  bool hemolytic;
  int zone;
  Color color;
  bool term;
  ResultPage(this.patientCase, this.hemolytic, this.zone, this.color,this.term){
    if(zone==1)
      color=Colors.black54;
    else if(zone==5)
      color=Colors.yellow[700];

  }
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Widget createZoneText(int zone) {
    String zoneString = zone.toString();
    return ListTile(
      title: Text(
        'Result is in zone $zoneString',
        style: TextStyle(
          color: widget.color,
          fontFamily: 'Nunito',
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String getImagePath(){
    return widget.term?'images/term_result.png':'images/preterm_result.png';
  }
  Widget createInstructionText(Case patientCase) {
    String ins = patientCase.instruction;
    return Text(
        'Intervention :\n$ins',
      textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Nunito',
          fontSize: 17,
            fontWeight: FontWeight.bold

        ),
      );

  }

  double getMax(){
    return widget.term?8:7;
  }

  Widget createDoseText(Case patientCase) {
    String dose = patientCase.dose;
    return Text(
        'Measure bili :\n$dose',
      textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Nunito',
          fontSize: 17,
            fontWeight: FontWeight.bold

        ),
      );

  }

  Widget createHintText(Case patientCase) {
    String hint = '1. Consider => if infant sick/bruised, bilirubin is increasing (>0.5 mg/dl/hr.) despite therapy or near upper zone border.'
        '\n\n\n2. PTX => start phototherapy\n\n\n'
        '3. PTX-M => maximize skin surface area exposure, and light source wave length and intensity'
        '\n\n\n4. IVIG => 500 mg/kg/dose, may repeat q 12 hours x 3 doses, only indicated for antibody mediated hemolysis i.e. ABO or Rh sensitization';
           return Text(
      'Important notes :\n\n$hint',
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Nunito',
        fontSize: 16,
      ),
    );
  }


  Widget createRefText(Case patientCase) {
    String ref = 'Results are based on the above hour-specific graph for risk stratification published in Emory University Hyperbilirubinemia Consensus (2005).';
    return Text(
      'Reference : $ref',
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.grey[700],
        fontFamily: 'Nunito',
        fontSize: 14,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey[300], Colors.white],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: CustomScrollView(
            slivers: <Widget>[
          SliverAppBar(
            title:  Text(
          'Results (based on the graph below)',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Lobster',
            fontSize: 20,
          ),
        ),
            leading: Icon(
              Icons.text_snippet,
              size: 25,
              color: Colors.blueAccent,
            ),
            backgroundColor: Colors.blueGrey,
            elevation: 10,
            shadowColor: Colors.black,
          ),
         
          SliverToBoxAdapter(
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(

                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white60,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        SizedBox(
                          child: KdGaugeView(
                            minSpeed: 0,
                            maxSpeed: getMax(),
                            speed: double.parse(widget.zone.toString()),
                            unitOfMeasurement: '',
                            baseGaugeColor: Colors.blueGrey,
                            divisionCircleColors: Colors.blue[900],
                            activeGaugeColor: widget.color,
                            inactiveGaugeColor: Colors.greenAccent,
                            animate: true,
                            duration: Duration(seconds: 3),
                            minMaxTextStyle:
                                TextStyle(fontSize: 16, color: Colors.blueGrey),
                            speedTextStyle:
                                TextStyle(fontSize: 30, color: Colors.black),
                            unitOfMeasurementTextStyle:
                                TextStyle(fontSize: 10, color: Colors.black),
                          ),
                          height: 150,
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.blueGrey,
                            thickness: 2,

                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            child: createZoneText(widget.zone),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Container(child: createInstructionText(widget.patientCase)),

                        SizedBox(
                          height: 10,
                        ),

                        Container(child: createDoseText(widget.patientCase)),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.blueGrey,
                            thickness: 2,

                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(child: createHintText(widget.patientCase)),

                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.blueGrey,
                            thickness: 2,

                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                              child:Text(
                                'Graph : ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'nunito',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        Container(
                          height: 150,
                          child: Stack(
                            clipBehavior: Clip.hardEdge, children: [
                              Container(
                                alignment: Alignment.center,
                                child: Image.asset(getImagePath())),

                              Align(
                                alignment: Alignment.center,
                                child: FloatingActionButton(
                                  backgroundColor: Colors.blueGrey,
                                  child:InkWell(
                                    splashColor: Colors.red, // inkwell color
                                    child: SizedBox(width: 56, height: 56, child: Icon(Icons.zoom_in, color: Colors.white,)),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => GraphPage(getImagePath()),
                                        ),
                                      );                                    },
                                  ),

                                    mini: true,
                                    clipBehavior: Clip.antiAlias,
                                    onPressed: null
                                ),

                              ),

                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.blueGrey,
                            thickness: 2,

                          ),
                        ),

                        Container(child: createRefText(widget.patientCase)),

                        SizedBox(
                          height: 10,
                        ),

                        Center(
                          child: ClipOval(
                            child: Material(
                              color: Colors.blueGrey, // button color
                              child: InkWell(
                                splashColor: Colors.red, // inkwell color
                                child: SizedBox(width: 56, height: 56, child: Icon(Icons.arrow_back, color: Colors.white,)),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Text(
                              'go back',
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Nunito',
                              fontSize: 18,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

// child: Container(
// decoration: BoxDecoration(
// gradient: LinearGradient(
// colors: [Colors.blueGrey[300], Colors.white],
// begin: Alignment.bottomCenter,
// end: Alignment.topCenter,
// ),
// ),
// child: Center(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.stretch,
// mainAxisSize: MainAxisSize.min,
// children: <Widget>[
// Card(
// margin: EdgeInsets.all(20),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(20)),
// clipBehavior: Clip.antiAlias,
// elevation: 5,
// shadowColor: Colors.black,
// color: Colors.grey[100],
// child: Container(
// child: Center(
// child: ListTile(
// leading: Icon(
// Icons.baby_changing_station_sharp,
// size: 25,
// color: Colors.blueAccent,
// ),
// title: Text(
// 'Results',
// style: TextStyle(
// color: Colors.black54,
// fontFamily: 'Lobster',
// fontSize: 25,
// ),
// ),
// ),
// ),
// ),
// ),
// SizedBox(
// height: 10,
// ),
// Expanded(
// flex: 1,
// child: Container(
// padding: EdgeInsets.all(20),
// child: KdGaugeView(
// minSpeed: 0,
// maxSpeed: 7,
// speed: double.parse(widget.zone.toString()),
// unitOfMeasurement: '',
// baseGaugeColor: Colors.blueGrey,
// divisionCircleColors: Colors.blue[900],
// activeGaugeColor: widget.color,
// inactiveGaugeColor: Colors.greenAccent,
// animate: true,
// duration: Duration(seconds: 3),
// minMaxTextStyle: TextStyle(fontSize: 16,color: Colors.blueGrey),
// speedTextStyle:  TextStyle(fontSize: 30,color: Colors.black),
// unitOfMeasurementTextStyle: TextStyle(fontSize: 10,color: Colors.black),
// ),
//
//
// ),
// ),
//
//
// Expanded(
// flex: 2,
// child: Container(
// padding: EdgeInsets.all(20),
// margin: EdgeInsets.all(20),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(25),
// color: Colors.white,
// ),
// clipBehavior: Clip.antiAlias,
// child: Column(
// //crossAxisAlignment: CrossAxisAlignment.center,
// children:<Widget> [
// createZoneText(widget.zone),
// SizedBox(
// height: 2,
// ),
// createInstructionText(widget.patientCase),
//
// SizedBox(
// height: 2,
// ),
//
// createDoseText(widget.patientCase),
//
// ]
// ),
// ),
// ),
// ],
// ),
// ),
// ),
