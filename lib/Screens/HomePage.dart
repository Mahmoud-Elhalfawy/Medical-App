import 'dart:typed_data';

import 'package:app_trial1/Controller/App1Controller.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final weightController = TextEditingController();
  final ageController = TextEditingController();
  final serumController = TextEditingController();
  String dateAndTime;
  bool enableHoursText = true;
  bool hemolytic = true;
  bool createCalendarField = false;
  img.Image photo;
  Widget createField(IconData icon, TextEditingController controller,
      String text, bool enabled) {
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
            borderSide: BorderSide(color: Colors.blue[700])),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.red[700])),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.green[700])),
        prefixIcon: Icon(icon),
        hintText: text,
      ),
    );
  }

  Widget createCalendar(bool createCalendarField) {
    if (createCalendarField) {
      return FadeTransition(
        opacity: _animationController,
        child: Column(children: <Widget>[
          DateTimePicker(
            type: DateTimePickerType.dateTimeSeparate,
            dateMask: 'd MMM, yyyy',
            initialValue: DateTime.now().toString(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            icon: Icon(Icons.event),
            dateLabelText: 'Date',
            timeLabelText: "Hour",
            validator: (val) {
              dateAndTime = val;
              return dateAndTime;
            },
            onChanged: (val) => dateAndTime = val,
            onSaved: (val) => dateAndTime = val,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '(enter birth date and time)',
            style: TextStyle(
              color: Colors.black26,
              fontSize: 15,
            ),
          ),
        ]),
      );
    } else {
      return FadeTransition(
        opacity: _animationController,
        child: Text(
          '(enter age in hours)',
          style: TextStyle(
            color: Colors.black26,
            fontSize: 15,
          ),
        ),
      );
    }
  }

  Future<bool> getResults() async {
    if (weightController.text.isEmpty || serumController.text.isEmpty)
      return false;

    App1Controller app1Controller = App1Controller(context);
    double weight = double.parse(weightController.text.toString());
    double serum = double.parse(serumController.text.toString());
    app1Controller.calculateResult(
        enableHoursText, hemolytic, ageController, dateAndTime, weight, serum);

    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1700),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, 5),
          end: Offset.zero,
        ).animate(_animationController),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueGrey[300], Colors.white],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Center(
              child:
                  //Expanded(
                  //   child: Image.asset('images/doctor.png'),
                  // ),
                  CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    toolbarHeight: 60,
                    backgroundColor: Colors.blueGrey,
                    shadowColor: Colors.black,
                    //expandedHeight: 100,
                    centerTitle: true,
                    automaticallyImplyLeading: true,
                    leadingWidth: 100,
                    stretch: true,
                    title: Text(
                      'Bilirubin App',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Lobster',
                        fontSize: 30,
                      ),

                    ),
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(child: Image.asset('images/bilirubin_logo.png')),
                    ),

                    // flexibleSpace: FlexibleSpaceBar(
                    //   background: Image.asset('images/doctor.png'),
                    // ),
                  ),

                  SliverToBoxAdapter(
                    child: IntrinsicHeight(
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height*0.9,
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
                                  margin: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.white60,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      createField(Icons.accessibility,
                                          weightController, 'Weight (gm)', true),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Expanded(
                                            child: createField(
                                                Icons.hourglass_full_sharp,
                                                ageController,
                                                'age',
                                                enableHoursText),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Expanded(
                                            child: LiteRollingSwitch(
                                              value: false,
                                              textOff: 'Hours',
                                              textOn: 'Calender',
                                              colorOff: Colors.blueAccent,
                                              colorOn: Colors.green,
                                              iconOff: Icons.hourglass_bottom_sharp,
                                              iconOn: Icons.calendar_today_outlined,
                                              onChanged: (bool position) {
                                                if (position) {
                                                  setState(() {
                                                    enableHoursText = false;
                                                    createCalendarField = true;
                                                  });
                                                } else if (!enableHoursText) {
                                                  setState(() {
                                                    enableHoursText = true;
                                                    createCalendarField = false;
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      createCalendar(createCalendarField),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      createField(Icons.open_in_full, serumController,
                                          "Total serum bilirubin (mg/dl)", true),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      Card(
                                        margin: EdgeInsets.symmetric(horizontal: 5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)),
                                        clipBehavior: Clip.antiAlias,
                                        elevation: 5,
                                        shadowColor: Colors.black,
                                        color: Colors.grey[100],
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              ListTile(
                                                title: Text(
                                                  'The type of hyperbilirubinemia : ',
                                                  style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                leading: Icon(
                                                  Icons.adjust,
                                                  color: Colors.blueAccent,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: SizedBox(
                                                        height: 95,
                                                        child: RaisedButton(
                                                          child: Text(
                                                            'Hemolytic ',
                                                            style: TextStyle(
                                                              color: Colors.black54,
                                                              fontFamily: 'Nunito',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          shape:
                                                              new RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                    .circular(30.0),
                                                          ),
                                                          color: hemolytic
                                                              ? Colors.red[300]
                                                              : Colors.grey[100],
                                                          onPressed: () {
                                                            setState(() {
                                                              hemolytic = true;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 30,
                                                    ),
                                                    Expanded(
                                                      child: SizedBox(
                                                        height: 95,
                                                        child: RaisedButton(
                                                          child: Text(
                                                            'Non-Hemolytic ',
                                                            style: TextStyle(
                                                              color: Colors.black54,
                                                              fontFamily: 'Nunito',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          shape:
                                                              new RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                    .circular(30.0),
                                                          ),
                                                          color: hemolytic
                                                              ? Colors.grey[100]
                                                              : Colors.red[300],
                                                          onPressed: () {
                                                            setState(() {
                                                              hemolytic = false;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 18,
                                              ),
                                            ]),
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
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
                                          color: Colors.green[600],
                                          onPressed: () async {
                                            bool result = await getResults();
                                            if (!result) {
                                              Widget okButton = FlatButton(
                                                child: Text("OK"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              );

                                              AlertDialog alert = AlertDialog(
                                                title: Text("Missing Data"),
                                                content: Text(
                                                    "please enter all required data to calculate results"),
                                                actions: [
                                                  okButton,
                                                ],
                                              );

                                              // show the dialog
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return alert;
                                                },
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
