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
    with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  final weightController = TextEditingController();
  final PNAController = TextEditingController();
  final GAController = TextEditingController();
  final heightController = TextEditingController();
  final SCRController = TextEditingController();
  final ureaController = TextEditingController();

  String dateAndTime;
  bool enableHoursText = true;
  bool createCalendarField = false;
  img.Image photo;
  bool flag = false;
  String choice;


  //-------------------New Code added
  //--------------------------
  Widget toggleChoice(bool flag){
    if(flag){
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
    }else{
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



  //-----------------------------
  // Widget createCalendar(bool createCalendarField) {
  //   if (createCalendarField) {
  //     return FadeTransition(
  //       opacity: _animationController,
  //       child: Column(children: <Widget>[
  //         DateTimePicker(
  //           type: DateTimePickerType.dateTimeSeparate,
  //           dateMask: 'd MMM, yyyy',
  //           initialValue: DateTime.now().toString(),
  //           firstDate: DateTime(2000),
  //           lastDate: DateTime(2100),
  //           icon: Icon(Icons.event),
  //           dateLabelText: 'Date',
  //           timeLabelText: "Hour",
  //           validator: (val) {
  //             dateAndTime = val;
  //             return dateAndTime;
  //           },
  //           onChanged: (val) => dateAndTime = val,
  //           onSaved: (val) => dateAndTime = val,
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         Text(
  //           '(enter birth date and time)',
  //           style: TextStyle(
  //             color: Colors.black26,
  //             fontSize: 15,
  //           ),
  //         ),
  //       ]),
  //     );
  //   } else {
  //     return FadeTransition(
  //       opacity: _animationController,
  //       child: Text(
  //         '(enter age in hours)',
  //         style: TextStyle(
  //           color: Colors.black26,
  //           fontSize: 15,
  //         ),
  //       ),
  //     );
  //   }
  // }

  // Future<bool> getResults() async {
  //   if (weightController.text.isEmpty || PNAController.text.isEmpty)
  //     return false;
  //
  //   App1Controller app1Controller = App1Controller(context);
  //   double weight = double.parse(weightController.text.toString());
  //   double serum = double.parse(PNAController.text.toString());
  //   app1Controller.calculateResult(
  //       enableHoursText, hemolytic, weightController, dateAndTime, weight, serum);
  //
  //   return true;
  // }


  //---------------------
 void initState(){
   super.initState();
   _animationController = AnimationController(
     vsync: this,
     duration: Duration(milliseconds: 1700),
   );
   _animationController.forward();
 }



 //create Field
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



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
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
                    'Reenal App',
                    style: TextStyle(
                      color: Colors.red[900],
                      fontFamily: 'Lobster',
                      fontSize: 30,
                    ),
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(child: Image.asset('images/bilirubin_logo.png')),
                  ),
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
                                        weightController, 'Weight (Kg)', true,),
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
                                              'Enter PNA (Weeks/Days)',
                                              true),


                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Expanded(
                                          child: LiteRollingSwitch(
                                            value: false,
                                            textOff: 'Days',
                                            textOn: 'Weeks',
                                            colorOff: Colors.blueAccent,
                                            colorOn: Colors.green,
                                            iconOff: Icons.calendar_today_outlined,
                                            iconOn: Icons.calendar_today_outlined,
                                            onChanged: (bool position) {
                                              if (position) {
                                                setState(() {
                                                  flag = true;
                                                  // enableHoursText = false;
                                                  // createCalendarField = true;
                                                });
                                              }else {
                                                flag = false;
                                                // enableHoursText = true;
                                                // createCalendarField = false;
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 30,
                                    ),
                                    toggleChoice(flag),
                                    SizedBox(
                                      height: 20,

                                    ),
                                    createField(Icons.ac_unit, GAController, 'Enter G.A (Weeks)', true),
                                    SizedBox(
                                      height: 18,
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),
                                    createField(Icons.height, heightController, 'Enter Height (Cm)', true),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    createField(Icons.source_outlined,SCRController,
                                        "Enter SCR (mg/dl)", true),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    createField(Icons.access_alarm_rounded, ureaController,
                                        'Enter Urea Rate (mh/dc)', true),
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
    );
   
      
  }






}
