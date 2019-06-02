import 'package:flutter/material.dart';

double responsive(BuildContext context, double default1080){
  return (default1080/20) * ((4/600) * MediaQuery.of(context).size.height + 12.8);
}