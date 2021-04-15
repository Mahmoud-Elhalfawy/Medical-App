import 'dart:collection';
import 'package:app_trial1/Model/Case.dart';


class PreTermFactory {
  List<Case> listH;
  List<Case> listN;
  HashMap<int, List<Case>> hemolyticCases = HashMap();
  HashMap<int, List<Case>> nonHemolyticCases = HashMap();

  PreTermFactory() {
    fillMap();
  }
  void fillMap() {

    // hemolytic Data of Term Infants

     listH=[Case('Consider PTX', 'Every 12-24 hours'),Case('Follow bili till < 5', 'Every 12-24 hours'),Case('Follow bili / observe', 'prn ')];
    hemolyticCases.putIfAbsent(
        1, () => listH);

     listH=[Case('PTX', 'Every 8-12 hours'),Case('Consider PTX', 'Every 12 hours'),Case('Follow bili till < 5', 'Every 12-24 hours')];
    hemolyticCases.putIfAbsent(2, () => listH);

     listH=[Case('PTX > Consider IVIG', 'Every 6-12 hours'),Case('PTX', 'Every 8-12 hours'),Case('Consider PTX', 'Every 12-24 hours')];
     hemolyticCases.putIfAbsent(
        3, () => listH);

     listH=[Case('PTX-M > IVIG > Consider Exchange', 'Every 4-8 hours'),Case('PTX-M > Consider IVIG', 'Every 6-12 hours'),Case('PTX', 'Every 12 hours')];
     hemolyticCases.putIfAbsent(
        4, () => listH);

     listH=[Case('PTX-M > IVIG > Consider Exchange, but exchange at 15 mg/dL at any hour of age', 'Every 4-8 hours'),Case('PTX-M > IVIG > Consider exchange', 'Every 6-8 hours'),Case('PTX-M > consider IVIG', 'Every 6-12 hours')];
     hemolyticCases.putIfAbsent(
        5, () => listH);

     listH=[Case('PTX-M > IVIG > Exchange', 'Every 4-8 hours'),Case('PTX-M > IVIG > Exchange', 'Every 4-8 hours'),Case('PTX-M > IVIG > consider exchange', 'Every 6-8 hours')];
     hemolyticCases.putIfAbsent(
        6, () => listH);

     listH=[Case('Exchange', 'Every 4-6 hours'),Case('Exchange', 'Every 4-6 hours'),Case('Exchange', 'Every 4-6 hours')];
    hemolyticCases.putIfAbsent(
        7, () => listH);



    //Non hemolytic data of term infants

     listN=[Case('Follow bili till < 5', 'Every 12-24 hours'),Case('Follow bili / Observe', 'prn '),Case('Observe', 'prn ')];
     nonHemolyticCases.putIfAbsent(1, () => listN);

     listN=[Case('Consider PTX', 'Every 12-24 hours'),Case('Follow bili till < 5', 'Every 24 hours'),Case('Follow bili / Observe', '(+ or -) 24 hours')];
     nonHemolyticCases.putIfAbsent(2, () =>listN);

     listN=[Case('PTX', 'Every 12-24 hours'),Case('Consider PTX', 'Every 12-24 hours'),Case('Consider PTX', 'Every 24 hours')];
     nonHemolyticCases.putIfAbsent(3, () => listN);

    listN=[Case('PTX-M', 'Every 8-12 hours'),Case('PTX', 'Every 12 hours'),Case('PTX', 'Every 12-24 hours')];
    nonHemolyticCases.putIfAbsent(4, () =>listN);

    listN=[Case('PTX-M > Consider exchange', 'Every 6-8 hours'),Case('PTX-M', 'Every 8 hours'),Case('PTX-M', 'Every 8-12 hours')];
    nonHemolyticCases.putIfAbsent(5, () =>listN);

    listN=[Case('PTX-M > Exchange', 'Every 4-8 hours'),Case('PTX-M > Consider exchange', 'Every 4-8 hours'),Case('PTX-M > Consider exchange', 'Every 6-12 hours')];
    nonHemolyticCases.putIfAbsent(6, () => listN);

    listN=[Case('Exchange', 'Every 4-6 hours'),Case('Exchange', 'Every 4-6 hours'),Case('Exchange', 'Every 4-6 hours')];
    nonHemolyticCases.putIfAbsent(7, () => listN);
  }

}
