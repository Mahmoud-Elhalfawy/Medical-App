import 'dart:collection';

import 'package:app_trial1/Model/Case.dart';

class TermFactory {
  HashMap<int, Case> hemolyticCases = HashMap();
  HashMap<int, Case> nonHemolyticCases = HashMap();

  TermFactory() {
    fillMap();
  }


  void fillMap() {
    // hemolytic Data of Term Infants
    hemolyticCases.putIfAbsent(
        1, () => Case('Follow bili until decreasing x 2 ', 'Every 12-24 '));
    hemolyticCases.putIfAbsent(2, () => Case('Consider PTX  ', 'Every 12 '));
    hemolyticCases.putIfAbsent(
        3, () => Case('PTX ', 'Every 12 '));
    hemolyticCases.putIfAbsent(
        4, () => Case('PTXM-M > Consider IVIG', 'Every 8-12 '));
    hemolyticCases.putIfAbsent(
        5, () => Case('PTXM-M > IVIG > Consider exchange', 'Every 6-8 '));
    hemolyticCases.putIfAbsent(
        6, () => Case('PTXM-M > IVIG > Exchange ', 'Every 4-8 '));
    hemolyticCases.putIfAbsent(
        7, () => Case('Exchange', 'Every 4-8 '));
    hemolyticCases.putIfAbsent(
        8, () => Case('Exchange', 'Every 4-8 '));

    //Non hemolytic data of term infants
    nonHemolyticCases.putIfAbsent(1, () => Case('Observe ', 'prn'));
    nonHemolyticCases.putIfAbsent(2, () => Case('Follow bili until decreasing x 1 ', 'Every 24 hours'));
    nonHemolyticCases.putIfAbsent(3, () => Case('Consider PTX', 'Every 12-24 hours'));
    nonHemolyticCases.putIfAbsent(4, () => Case('Consider PTX', 'Every 12-24 hours'));
    nonHemolyticCases.putIfAbsent(5, () => Case('PTX > PTX-M', 'Every 8-12 hours'));
    nonHemolyticCases.putIfAbsent(6, () => Case('PTX-M > Consider exchange', 'Every 6-12 hours'));
    nonHemolyticCases.putIfAbsent(7, () => Case('PTX-M > Consider exchange', 'Every 6-12 hours'));
    nonHemolyticCases.putIfAbsent(8, () => Case('Exchange', 'Every 4-8 hours'));
  }

}
