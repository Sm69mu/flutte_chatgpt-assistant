import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_assistant/widgets/sidebar_widget.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_chatgpt_assistant/apis/openai_service.dart';
import 'package:flutter_chatgpt_assistant/constants/consts.dart';
import 'package:flutter_chatgpt_assistant/widgets/features_widgets.dart';

// ignore: camel_case_types
class Home_page extends StatefulWidget {
  const Home_page({Key? key, required String title}) : super(key: key);

  @override

  // ignore: library_private_types_in_public_api
  _Home_pageState createState() => _Home_pageState();
}

// ignore: camel_case_types
class _Home_pageState extends State<Home_page> {
  final speechToText = SpeechToText();
  final FlutterTts flutterTts = FlutterTts();
  final OpenAiservice openAiservice = OpenAiservice();
  String? generatedContent;
  String? generatedimageUrl;
  String name = "I am GPT";
  String lastWords = '';
  bool isMuted = false;
  int start = 200;
  int delay = 200;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTexttoSpeech();
  }

  Future<void> initTexttoSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar

      appBar: AppBar(
        title: BounceInDown(child: Text('Hi $name',)),
        centerTitle: true,
        // leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            icon: Icon(
                isMuted ? Icons.volume_off_outlined : Icons.volume_up_outlined),
            onPressed: () {
              setState(() {
                isMuted = !isMuted;
              });
            },
          ),
        ],
      ),
      drawer: const Sidebar_widget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //virtual Assistant Picture

            ZoomIn(
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: const BoxDecoration(
                          color: Pallete.assistantCircleColor,
                          shape: BoxShape.circle),
                    ),
                  ),
                  Container(
                    height: 123,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/virtualAssistant.png'))),
                  )
                ],
              ),
            ),

            //chat Bubble

            FadeInRight(
              child: Visibility(
                visible: generatedimageUrl == null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 40)
                      .copyWith(top: 30),
                  decoration: BoxDecoration(
                      border: Border.all(color: Pallete.borderColor),
                      borderRadius: BorderRadius.circular(20)
                          .copyWith(topLeft: Radius.zero)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      generatedContent == null
                          ? 'Hey 👋 , What task can I do for you '
                          : generatedContent!,
                      style: TextStyle(
                          color: Pallete.mainFontColor,
                          fontSize: generatedContent == null ? 25 : 18,
                          fontFamily: 'Cera-Pro'),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: generatedContent == null && generatedimageUrl == null,
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 10, left: 22),
                child: const Text(
                  'Here are some few commands',
                  style: TextStyle(
                      fontFamily: 'Cera-Pro',
                      color: Pallete.mainFontColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),

            //features

            SlideInLeft(
              child: Visibility(
                visible: generatedContent == null && generatedimageUrl == null,
                child: SlideInLeft(
                  child: Column(
                    children: [
                      SlideInRight(
                        delay: Duration(milliseconds: start),
                        child: const FeatureBox(
                          color: Pallete.firstSuggestionBoxColor,
                          headerText: 'Chat GPT',
                          descriptionText:
                              'A smarter way to stay organized and informed with ChatGPT',
                        ),
                      ),
                      SlideInLeft(
                        delay: Duration(milliseconds: start + delay),
                        child: const FeatureBox(
                          color: Pallete.secondSuggestionBoxColor,
                          headerText: 'Dall-E',
                          descriptionText:
                              'Get inspired and stay creative with your personal assistant powered by Dall-E',
                        ),
                      ),
                      SlideInLeft(
                        delay: Duration(milliseconds: start + 2 * delay),
                        child: const FeatureBox(
                          color: Pallete.thirdSuggestionBoxColor,
                          headerText: 'Smart Voice Assistant',
                          descriptionText:
                              'Get the est of both worlds with a voice assistant powerd by Dall-E and ChatGPT',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),

      //floating mic button

      floatingActionButton: ZoomIn(
        child: FloatingActionButton(
          onPressed: () async {
            if (await speechToText.hasPermission &&
                speechToText.isNotListening) {
              await startListening();
            } else if (speechToText.isListening) {
              final speech = await openAiservice.isArtPromptApi(lastWords);
              if (speech.contains('https')) {
                generatedimageUrl = speech;
                generatedContent = null;
                setState(() {});
              } else {
                generatedimageUrl = null;
                generatedContent = speech;
                setState(() {});
                await systemSpeak(speech);
              }
              await stopListening();
            } else {
              initSpeechToText();
            }
          },
          child: Icon(speechToText.isListening ? Icons.stop : Icons.mic),
        ),
      ),
    );
  }
}
