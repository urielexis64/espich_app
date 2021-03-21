import 'package:highlight_text/highlight_text.dart';
import 'package:flutter/material.dart';

final Map<String, HighlightedWord> highlights = {
  'flutter': HighlightedWord(
      onTap: () {},
      textStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
  'Uriel': HighlightedWord(
      onTap: () {},
      textStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
  'verde': HighlightedWord(
      onTap: () {},
      textStyle:
          TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold))
};
