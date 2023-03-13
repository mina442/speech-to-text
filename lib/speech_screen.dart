import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
final Map<String, HighlightedWord> highlights ={
'flutter': HighlightedWord(
onTap: () => print('flutter') ,textStyle: const TextStyle( color: Colors.blue, fontWeight: FontWeight.bold, ), // TextStyle
),
'voice': HighlightedWord( onTap: () => print('voice'), textStyle: const TextStyle( color: Colors.green, fontWeight: FontWeight.bold
), ),
'subscribe': HighlightedWord( onTap: () => print('subscribe'), textStyle: const TextStyle( color: Colors. red,
fontWeight: FontWeight.bold ), ), 
'like': HighlightedWord(
onTap: () => print('like'), 
textStyle:  TextStyle( color: Colors. blueAccent, fontWeight: FontWeight.bold
)
),
'comment': HighlightedWord( onTap: () => print ('comment') ,textStyle:  TextStyle( color: Colors.green, fontWeight: FontWeight.bold,
)),
};
 stt.SpeechToText? speech;
 bool isLisening = false;
 String text = "Press the button";
 double confidence = 1.0;
 @override
void initState() {
  super.initState();
  speech =stt.SpeechToText();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text('Confidence: ${(confidence*100.0).toStringAsFixed(1)}%'),
        ),
        floatingActionButton: AvatarGlow(
          repeat: true,
          animate: isLisening,
          glowColor: Theme.of(context).primaryColor,
          endRadius: 75.0,
          repeatPauseDuration: Duration(milliseconds: 100),
          duration: Duration(milliseconds:2000),
          child: FloatingActionButton(onPressed: listen,
          child: Icon(isLisening? Icons.mic:Icons.mic_none_outlined),),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body:  SingleChildScrollView(
          reverse: true,
          child: Container(
            padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
            child: TextHighlight( text: text, words:highlights ,textStyle: TextStyle(
              fontSize: 32,
              color: Colors.black,
              fontWeight: FontWeight.w400
            ),)),
        ),
      ) ;
  }
  void listen() async { 
    if (!isLisening)
{
bool available = await speech!.initialize(
onStatus: (val) => print ('onStatus: $val'),
 onError: (val) => print ('onError: $val'), );
if (available) {
setState(() =>isLisening = true);
speech!.listen(
onResult: (val) => setState(() {
text = val.recognizedWords;
if (val. hasConfidenceRating && val.confidence > 0) {
confidence = val.confidence;
}},)
);
} }else {
setState(() =>isLisening = false);
speech!.stop();
}
}
}