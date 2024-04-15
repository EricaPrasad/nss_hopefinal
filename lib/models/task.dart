import 'package:flutter/material.dart';
import 'package:task_nss/constants/colour.dart';

class Task{
  IconData?iconData;
  String ?title;
  Color ?bgColor;
  Color ?iconColor;
  Color ?btnColor;
  num? left;
  num? done;
  bool? isLast;
  Task(
  {this.iconData,this.title, this.bgColor,this.iconColor,this.btnColor,
  this.left,this.done,this.isLast=false}
      );
  static List<Task>generateTask(){
    return[
    Task(
      iconData: Icons.person_rounded,
      title:'ATTENDANCE',
      bgColor: kYellowLight,
      iconColor: kYellowDark,
      btnColor:kYellow,
      left: 3,
        done:1,
    ),
      Task(
        iconData: Icons.cases_rounded,
        title:'ACTIVITY TRACKER',
        bgColor: kBlueLight,
        iconColor: kBlueDark,
        btnColor:kBlue,
        left: 0,
        done:0,
      ),
      Task(
        iconData: Icons.bloodtype_rounded,
        title:'BLOOD DONATION MANAGEMENT',
        bgColor: kRedLight,
        iconColor: kRedDark,
        btnColor:kRed,
        left: 0,
        done:0,
      ),
      Task(
        iconData: Icons.feedback,
        title:'FEEDBACK',
        bgColor: kYellowLight,
        iconColor: kYellowDark,
        btnColor:kYellow,
        left: 0,
        done:0,
      ),
    ];
  }


}