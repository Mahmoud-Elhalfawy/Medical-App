import 'dart:collection';

import 'package:app_trial1/Model/Case.dart';
import 'package:app_trial1/Model/PreTermFactory.dart';
import 'package:app_trial1/Model/RenalFactory.dart';
import 'package:app_trial1/Model/TermFactory.dart';
import 'package:app_trial1/Model/Utility.dart';
import 'package:app_trial1/Screens/RenalResultsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/ResultPage.dart';

class App1Controller {
  BuildContext context;
  App1Controller(BuildContext context) {
    this.context = context;
  }
  Future<bool> calculateResult(
      bool enableHoursText,
      bool hemolytic,
      TextEditingController ageController,
      String dateAndTime,
      double weight,
      double serum) async {
    double x;
    double y;
    bool term;
    Color color;
    DateTime now = DateTime.now();
    double age;
    Case patientCase;
    if(serum<0)
      serum=0;
    else if(serum>=32)
      serum=32;
    if(ageController.text.isNotEmpty && enableHoursText) {
      age = double.parse(ageController.text.toString())>=12?double.parse(ageController.text.toString()):12;
      if(age>=144)
        age=143;
    }
      else if (!enableHoursText) {
        List<String> dateList = dateAndTime.split(" ")[0].split("-");
        List<String> timeList = dateAndTime.split(" ")[1].split(":");
        int hours = ((now.month - int.parse(dateList[1])) * 30 * 24) +
            ((now.day - int.parse(dateList[2])) * 24);
        age = (hours +
            (now.hour - int.parse(timeList[0])) +
            ((now.minute - int.parse(timeList[1])) / 60)) ;
        if(age<12)
          age=12;
        else if(age>=144)
          age=143;
        print("age : $age");
      } else{
      age=(now.hour+(now.minute/60))>=12?(now.hour+(now.minute/60)):12;
      if(age>=144)
        age=143;
    }

    if (weight < 2500) {
      term = false;
      x = (age) * Utility.SCALE_PRETERM_X;
      y = serum * Utility.SCALE_PRETERM_Y;
      y = Utility.PRETERM_Y - y;
      color = await Utility.getImage(Utility.PRETERM_IMAGE, x, y);
    } else {
      term=true;
      x = (age) * Utility.SCALETERM_X;
      y = serum * Utility.SCALETERM_Y;
      y = Utility.TERM_Y - y;
      color = await Utility.getImage(Utility.TERM_IMAGE, x, y);
    }

    int zone=Utility.checkZoneColor(color.toString(),term);
    if(!term){
      PreTermFactory factory=PreTermFactory();

      HashMap<int,List<Case>> map=hemolytic?factory.hemolyticCases:factory.nonHemolyticCases;
      if(weight<1000)
         patientCase=map[zone][0];
      else if(weight>=1000  && weight<=2500)
         patientCase=map[zone][1];
      else
         patientCase=map[zone][2];


      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(patientCase,hemolytic,zone,color,term),
        ),
      );
    }else{
      TermFactory factory=TermFactory();
      HashMap<int,Case> map=hemolytic?factory.hemolyticCases:factory.nonHemolyticCases;
      patientCase=map[zone];

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(patientCase,hemolytic,zone,color,term),
        ),
      );





    }

    return true;
  }





  Future<bool> calculateRenalResult(double weight,double height,double pna
      ,double ga,double urea,double scr,int isWeeks) async{
  double k;
  double gaWeeks=ga/7.0;

  bool adjustment=true;
  bool renal=true;
  if(gaWeeks<38)
    k=0.33;
  else
    k=0.45;


  double eGFR=(k*height)/scr;

  if(isWeeks==1){
    pna=pna*7;
  }else if(isWeeks==2){
    pna=pna*30;
  }

  RenalFactory renalFactory=RenalFactory();
  var range=renalFactory.getRange(pna, gaWeeks);
  if(eGFR>=range[0] && eGFR<=range[1])
    adjustment=false;

  double BUN=urea/2.18;
  double ratio=BUN/scr;

  if(ratio>20)
    renal=false;

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RenalResultsScreen(eGFR:eGFR,adjustment:adjustment,renal:renal),
    ),
  );

return true;

  }




}
