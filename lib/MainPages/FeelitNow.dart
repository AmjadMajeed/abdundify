import 'package:abundify/Utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeelItNow extends StatefulWidget {
  @override
  _FeelItNowState createState() => _FeelItNowState();
}

class _FeelItNowState extends State<FeelItNow> {
  late TextEditingController _textController1;
  late TextEditingController _textController2;
  late TextEditingController _textController3;
  late TextEditingController _textController4;
  late TextEditingController _textController5;
  late TextEditingController _textController6;
  late TextEditingController _textController7;
  late TextEditingController _textController8;

  @override
  void initState() {
    super.initState();
    _textController1 = TextEditingController();
    _textController2 = TextEditingController();
    _textController3 = TextEditingController();
    _textController4 = TextEditingController();
    _textController5 = TextEditingController();
    _textController6 = TextEditingController();
    _textController7 = TextEditingController();
    _textController8 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.MainBGColor,
      appBar: AppBar(
        backgroundColor:AppColors.MainBGColor,
        title: Center(child: Text('feel it now!',style: TextStyle(color: Colors.white),)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 50),

              _buildQuestionTextField("Write down something you've really wanted for a long time."),
              _buildQuestionTextField("How would you feel if you got what you wanted right now, what emotions would you have?"),
              _buildQuestionTextField("What would your life be like?"),
              _buildQuestionTextField("Who's the first person you'd tell the great news to?"),
              _buildQuestionTextField("What would you be doing now that you've got it?"),
              _buildQuestionTextField("What positive changes does it add to your life?"),
              _buildQuestionTextField("What do success and abundance look and feel like for you?"),
              _buildQuestionTextField("Write how grateful you are for getting to feel these feelings before it happens."),

              SizedBox(height: MediaQuery.of(context).size.height / 60),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Embody the emotions of your desires, "
                    "even before they materialize. Feel the joy and fulfillment"
                    " as if it's already yours. Doing so allows you to align your energy, "
                    "drawing your desires closer to you. "
                    "Keep the faith, for what you seek is already a part of you.",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 10),

              ElevatedButton(
                onPressed: () {
                  // Get the user's answers from the text controllers
                  String answer1 = _textController1.text;
                  String answer2 = _textController2.text;
                  String answer3 = _textController3.text;
                  String answer4 = _textController4.text;
                  String answer5 = _textController5.text;
                  String answer6 = _textController6.text;
                  String answer7 = _textController7.text;
                  String answer8 = _textController8.text;

                  // Do something with the answers, e.g., save or process them
                },
                child: Text('Done'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionTextField(String question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: _getTextControllerForQuestion(question),
          maxLines: null, // Allow multiline input
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: 'Answer here...',
            contentPadding: EdgeInsets.all(16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }

  TextEditingController _getTextControllerForQuestion(String question) {
    switch (question) {
      case "Q1) Write down something you've really wanted for a long time.":
        return _textController1;
      case "Q2) How would you feel if you got what you wanted right now, what emotions would you have?":
        return _textController2;
      case "Q3) What would your life be like?":
        return _textController3;
      case "Q4) Who's the first person you'd tell the great news to?":
        return _textController4;
      case "Q5) What would you be doing now that you've got it?":
        return _textController5;
      case "Q6) What positive changes does it add to your life?":
        return _textController6;
      case "Q7) What do success and abundance look and feel like for you?":
        return _textController7;
      case "Q8) Write how grateful you are for getting to feel these feelings before it happens.":
        return _textController8;
      default:
        return TextEditingController();
    }
  }
}
