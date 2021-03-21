import 'package:avatar_glow/avatar_glow.dart';
import 'package:espich_app/constants.dart';
import 'package:espich_app/src/data.dart';
import 'package:espich_app/src/widgets/custom_shape_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechPage extends StatefulWidget {
  @override
  _SpeechPageState createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  SpeechToText _speech;
  bool _isListening = false;
  String _text = '';
  double _confidence = 1.0;
  double _voiceVolume = 0.0;

  String _selectedLanguage = 'es_ES';

  @override
  void initState() {
    super.initState();
    _speech = SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: CustomShapeClipper(),
                child: Container(
                  height: size.height * .3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.cyanAccent],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                          child: Text(
                        'Presiona el botón y empieza a hablar. 🎙',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
              ),
            ],
          ),
          buildRow(),
          Container(
              height: size.height * .42,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  _text.isNotEmpty
                      ? buildCardText()
                      : Center(
                          child: Text(
                          '🎤',
                          textScaleFactor: 3,
                        )),
                ],
              )),
          buildVoiceSpectrum(),
          buildFloatingButtons(),
        ],
      ),
    );
  }

  Row buildFloatingButtons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(
          mini: true,
          backgroundColor: Colors.cyan,
          tooltip: 'Guardar',
          onPressed: () {
            Clipboard.setData(new ClipboardData(text: _text));
          },
          child: Icon(Icons.bookmark_border),
        ),
        AvatarGlow(
          animate: _isListening,
          glowColor: Colors.blue[600],
          endRadius: 50,
          duration: Duration(seconds: 2),
          repeat: true,
          repeatPauseDuration: Duration(milliseconds: 100),
          child: FloatingActionButton(
            onPressed: _listen,
            child: Icon(_isListening ? Icons.mic : Icons.mic_none),
          ),
        ),
        FloatingActionButton(
            mini: true,
            backgroundColor: Colors.redAccent,
            tooltip: 'Borrar texto actual',
            onPressed: () => setState(() => _text = ''),
            child: Icon(Icons.delete_outline_rounded)),
      ],
    );
  }

  Padding buildVoiceSpectrum() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          curve: Curves.ease,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Constants.secondaryColor,
            Constants.primaryLightColor,
            Constants.primaryColor
          ])),
          height: 10,
          width: _voiceVolume == 0 ? 10 : _voiceVolume * 10,
        ),
      ),
    );
  }

  Card buildCardText() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextHighlight(
          text: _text,
          textAlign: TextAlign.center,
          words: highlights,
          textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              color: Colors.black,
              height: 1.2),
        ),
      ),
    );
  }

  Row buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Divider(
          indent: 10,
          endIndent: 10,
        )),
        Text('Precisión: ${(_confidence * 100).toStringAsFixed(1)}%'),
        Expanded(
          child: Divider(
            indent: 10,
            endIndent: 10,
          ),
        )
      ],
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) => setState(() {
            _text = result.recognizedWords;

            if (result.hasConfidenceRating && result.confidence > 0) {
              _confidence = result.confidence;
              _isListening = false;
              _voiceVolume = 0;
            }
          }),
          localeId: _selectedLanguage,
          listenMode: ListenMode.dictation,
          onSoundLevelChange: (level) {
            setState(() => _voiceVolume = level > 1 ? level : 1);
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _voiceVolume = 0;
      _speech.stop();
    }
  }
}
