import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

class carInfo {
  static int engine_rpm = 0;
  static int engine_load = 0;
  static int coolant_temp = 0;
  static int fuel_level = 0;
  static int current_speed = 0;
  static int battery_charge = 0;
  static int accelerator_stat = 0;

  carInfo();

  void randomize() {
    var rand = Random();

    engine_rpm = rand.nextInt(8000);
    engine_load = rand.nextInt(100);
    coolant_temp = rand.nextInt(200);
    fuel_level = rand.nextInt(100);
    current_speed = rand.nextInt(200);
    battery_charge = 42;
  }

  get ENG_RPM => engine_rpm;
  get ENG_LOAD => engine_load;
  get COOL_TMP => coolant_temp;
  get FUEL_LVL => fuel_level;
  get CUR_SPD => current_speed;
  get BAT_CHG => battery_charge;
  get ACCEL => accelerator_stat;
}
