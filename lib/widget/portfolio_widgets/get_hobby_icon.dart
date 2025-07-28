
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_creator/data/appdata.dart';

IconData getHobbyIcon(String hobby) {
    final List<IconData> hobbyIcons = [
      FontAwesomeIcons.code,
      FontAwesomeIcons.mobileScreenButton,
      FontAwesomeIcons.globe,
      FontAwesomeIcons.github,
      FontAwesomeIcons.rankingStar,
      FontAwesomeIcons.laptopCode,
      FontAwesomeIcons.handshake,
      FontAwesomeIcons.blog,
      FontAwesomeIcons.newspaper,
      FontAwesomeIcons.video,
      FontAwesomeIcons.youtube,
      FontAwesomeIcons.lightbulb,
      FontAwesomeIcons.camera,
      FontAwesomeIcons.film,
      FontAwesomeIcons.microphone,
      FontAwesomeIcons.fileLines,
    ];

    // Get index based on hobby name (simplified - you might want a better mapping)
    int index = hobbies.indexOf(hobby) % hobbyIcons.length;
    return hobbyIcons[index];
  }