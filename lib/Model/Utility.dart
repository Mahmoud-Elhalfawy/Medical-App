import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

abstract class Utility{

  //term data
  static const TERM_IMAGE='images/term.png';
  static const TERM_X=1932;
  static const TERM_Y=1215;
  static const SCALETERM_X=1932/150;
  static const SCALETERM_Y=1215/32;

  //pre term data
  static const PRETERM_IMAGE='images/preterm.png';
  static const PRETERM_X=1932;
  static const PRETERM_Y=1215;
  static const SCALE_PRETERM_X=1932/150;
  static const SCALE_PRETERM_Y=1215/32;

  //colors
  static const GREEN='Color(0xff329866)';
  static const YELLOW='Color(0xffffff00)';
  static const ORANGE='Color(0xffff9800)';
  static const DARK_ORANGE='Color(0xffff6000)';
  static const RED='Color(0xffff0000)';
  static const WHITE='Color(0xffffffff)';
  static const PURPLE='Color(0xff800080)';
  static const BLUE='Color(0xff0000ff)';

  static Future <Color> getImage(String path,double x,double y) async{
    img.Image photo;
    ByteData imageBytes = await rootBundle.load(path);
    List<int> values = imageBytes.buffer.asUint8List();
    photo = null;
    photo = img.decodeImage(values);
    int pixel32 = abgrToArgb(photo.getPixelSafe(x.round(),y.round()));
    Color color=Color(pixel32);
    print('color = $color');
    return color;
  }

  static int abgrToArgb(int argbColor) {
    int r = (argbColor >> 16) & 0xFF;
    int b = argbColor & 0xFF;
    return (argbColor & 0xFF00FF00) | (b << 16) | r;
  }

  static int checkZoneColor(String color, bool term){
          if(color.compareTo(Colors.white.toString())>=0)
            return 1;
          else if(color.compareTo(YELLOW)>=0)
            return 5;
          else if(color.compareTo(ORANGE)>=0)
            return 6;
          else if(color.compareTo(DARK_ORANGE.toString())>=0)
            return 7;
          else if(color.compareTo(Colors.red[900].toString())>=0)
            return term?8:7;
          else if(color.compareTo(PURPLE)>=0)
            return 2;
          else if(color.compareTo(GREEN)>=0)
            return 4;
          else if(color.compareTo(BLUE)>=0)
            return 3;



    }



}