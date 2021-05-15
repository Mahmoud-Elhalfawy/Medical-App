class RenalFactory{


 getRange(double pna,double gaWeeks){



if(pna>=2 && pna<=8)
  return gaWeeks<34?[11,15]:[17,60];
if(pna>=4 && pna<=28)
   return gaWeeks<34?[15,28]:[26,68];
if(pna>=30 && pna<=90)
   return gaWeeks<34?[40,65]:[30,86];
if(pna>=30 && pna>=180)
  return[39,114];
if(pna>180 && pna>=360)
  return [49,157];
if(pna>360 && pna>=570)
   return [62,191];
if(pna>=720)
  return [89,165];








 }

}