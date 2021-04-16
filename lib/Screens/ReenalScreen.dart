import 'package:app_trial1/Controller/App1Controller.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:image/image.dart' as img;

class ReenalScreen extends StatefulWidget {
  @override
  _ReenalScreenState createState() => _ReenalScreenState();
}

class _ReenalScreenState extends State<ReenalScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final weightController = TextEditingController();
  final PNAController = TextEditingController();
  final GAController = TextEditingController();
  final heightController = TextEditingController();
  final SCRController = TextEditingController();
  final ureaController = TextEditingController();

  img.Image photo;
  bool isWeeks = false;

  //-------------------New Code added
  //--------------------------
  Widget toggleChoice(bool flag) {
    if (flag) {
      return FadeTransition(
        opacity: _animationController,
        child: Column(children: <Widget>[
          
          Text(
            '(Enter PNA in Weeks)',
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
          '(Enter PNA in Days)',
          style: TextStyle(
            color: Colors.black26,
            fontSize: 15,
          ),
        ),
      );
    }
  }

  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1700),
    );
    _animationController.forward();
  }

  //create Field
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
                                      weightController,
                                      'Weight (Kg)',
                                      true,null
                                    ),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Expanded(

                                          child: createField(
                                              Icons.hourglass_full_sharp,
                                              PNAController,
                                              'PNA',
                                              true,"images/catheter.png"),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Expanded(
                                          child: LiteRollingSwitch(
                                            value: false,
                                            textOff: 'Days',
                                            textOn: 'Weeks',
                                            colorOff: Colors.indigo[900],
                                            colorOn: Colors.pink.shade900,
                                            iconOff:
                                                Icons.timelapse,
                                            iconOn:
                                                Icons.timelapse,
                                            onChanged: (bool position) {
                                              if(position!=isWeeks)
                                              setState(() {
                                                   isWeeks=position;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    toggleChoice(isWeeks),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    createField(Icons.ac_unit, GAController,
                                        'Enter G.A (Weeks)', true,'images/pills.png'),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    createField(Icons.height, heightController,
                                        'Enter Height (Cm)', true,null),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    createField(
                                        Icons.source_outlined,
                                        SCRController,
                                        "Enter SCR (mg/dl)",
                                        true,"images/SCR.png"),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    createField(
                                        Icons.access_alarm_rounded,
                                        ureaController,
                                        'Enter Urea Rate (mh/dc)',
                                        true,'images/urea.png'),
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
