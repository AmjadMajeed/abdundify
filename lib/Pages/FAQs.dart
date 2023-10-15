import 'package:abundify/Utils/Colors.dart';
import 'package:flutter/material.dart';

class FAQs extends StatefulWidget {
  @override
  _FAQsState createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
  List<Item> _items = [
    Item('1. What is the purpose of this app?', 'This app is made to help you cultivate high states of being and an abundant mindset through multiple practices designed to help you maintain positive emotions and high vibrations throughout the day. It provides a range of tools to empower you in manifesting positivity, gratitude, and abundance in all aspects of your life. Often, the constant exposure to fake, idealized lives on social media can inadvertently lead us to overlook our own blessings and lose sight of all that is good around us. Abundify is meant to shift your focus, allowing you to channel your energy towards the blessings in your life. “Where focus goes, energy flows”. And where energy flows, whatever youre focusing on grows. Your life is controlled by what you focus on. Thats why you need to focus on what you want to grow, not on what you lack. The purpose of this app is to be a constant reminder for you to appreciate what you have and become a magnet for what you want.'),
    Item('2. How do affirmations work, and how can they benefit me?', 'Affirmations are positive statements that you repeat to yourself. They work by reprogramming your subconscious mind, with positive messages. Through repetition, they help rewire ingrained thought patterns, replacing Negative beliefs with Positive ones.'),
    Item('3. How can the gratitude journal and list of blessings enhance my mindset?', 'The gratitude journal and list of blessings are powerful tools for shifting your focus toward positivity. By regularly noting down what you are grateful for, you train your mind to recognize and appreciate the abundance already present in your life. These practices are meant to program your subconscious mind for abundance. "You attract what you are not what you want”- Dr. Wayne Dyer.  The two practices help you embody the qualities and values of your aspirations By feeling that you are abundant and rich in all areas of your life this creates a magnetic energy that draws aligned opportunities and experiences into your life. By becoming the person you desire to be, you naturally align with the manifestations you seek. After a few days of regularly counting your blessings and feeling grateful for them your mind will do it automatically for you and youll become a person who only focuses on the positives and attracts more and more of them.'),
    Item('4. What is the "Feel It Now" exercise and how does it work?','The "Feel It Now" exercise is a technique that helps you immerse yourself in the emotions of achieving your desires. By visualizing and feeling the experience as if it is happening right now you align your energy with your goals and stay in those feelings for as long as you can, you will manifest your desires and shape your destiny. True transformation begins with adopting the identity and the mindset of the person who has already achieved what you desire. '),
    Item('5. How can sending gratitude messages to loved ones benefit them and me?','Expressing gratitude towards loved ones strengthens your relationships and fosters a deeper connection. It also creates a positive feedback loop of love and appreciation, benefiting both you and the recipient. This practice is a great positive emotion booster when you express gratitude; it often inspires others to reciprocate. This creates a positive cycle of appreciation within the relationship, further reinforcing the connection between you and your loved ones. '),
    Item('6. What is the purpose of the vision board?','A vision board is a visual representation of your goals and desires. By creating and regularly viewing your vision board, you reinforce your intentions and keep them at the forefront of your mind. This helps in manifesting your dreams into reality. Its vivid images, quotes, and aspirations form a tangible representation of ones deepest desires, offering a visual sanctuary where ambitions are given form and substance. As you gaze upon it, a surge of purpose courses through, infusing each day with renewed determination. It not only cultivates unwavering focus but also sparks a relentless drive to transform those visions into reality. It is a daily reminder that your potential is boundless, igniting a fire within, urging you to march steadfastly toward the life you envision.'),
    Item('7. How does the "Abundant Bank Account" work?','The "Abundant Bank Account" is a symbolic tool to help you feel abundant and prosperous. Its a visual representation of your increasing wealth, a powerful reminder of your financial goals and aspirations. Set the proper notifications for you and watch your wealth grow constantly. You can also share the money you have to reprogram your subconscious mind that you are rich, abundant, and have enough to share with the rest of the world. Remember your subconscious mind makes no difference between whats real and whats   imagined so feel the wealth until it becomes a reality.'),
    Item('8. What is the purpose of the Net Worth section?','A net worth vision board is a masterwork of financial aspirations, precisely designed with threads of ambition and fiscal dreams. It represents wealth milestones, investment goals, and the financial freedom one’s dreams about. Each glance invites you into a realm of abundance, where your economic potential is vividly illustrated, fostering a deep-seated belief in your capacity to build and protect that wealth. It’s a visual method to implant the abundance and wealth you desire and make it a reality. It stands as a daily testament to the boundless possibilities, urging you to walk confidently toward a future of financial abundance where money will never be a problem. '),
    Item('9. How can I customize the notifications to suit my preferences?','You can personalize the notification pace in the apps settings. This allows you to receive reminders at a frequency and time that best aligns with you.'),
    Item('10. Is my personal information and usage data secure within the app?','Yes, we take privacy and security seriously. All your personal information and usage data are encrypted and stored securely. We do not share any data with third parties.'),
    Item('11. How can I get in touch if I have further questions or need support?','If you have any additional questions or need support, feel free to contact our customer support team at [support@abundify.org]. Your suggestions and ideas to improve the app are more than welcome. We are here to assist you on your journey towards a high-vibe and abundant mindset.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.MainBGColor,
      appBar: AppBar(
        backgroundColor: AppColors.MainBGColor,
        title: Center(child: Text('FAQs')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///FAQS
            Column(
              children: _items.map<Widget>((Item item) {
                return CustomExpansionPanel(item: item);
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Tips and Tricks ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.white),),
            ),
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 8.0),
                  child: Text("	•	Consistency is Key:",style: TextStyle(color: Colors.white,fontSize: 18),),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.only(left: 20.0,top: 6,bottom: 6),
              child: Text("Make a daily habit of using the app. Consistent practice of affirmations,"
                  " gratitude, and other features will amplify their effectiveness.",style: TextStyle(color: Colors.white,fontSize: 16),),
            ),
            SizedBox(height: 20,),
            ///2
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 8.0),
                  child: Text("	•	Personalize Your Affirmations:",style: TextStyle(color: Colors.white,fontSize: 18),),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.only(left: 20.0,top: 6,bottom: 6),
              child: Text("Write affirmations to your specific goals and desires. This makes them more impactful and aligned with what you want.",style: TextStyle(color: Colors.white,fontSize: 16),),
            ),
            SizedBox(height: 20,),
            ///3
            Padding(
              padding:  EdgeInsets.only(left: 8.0),
              child: Text("	•	Make Gratitude an unconscious practice in your \n life:",style: TextStyle(color: Colors.white,fontSize: 18),),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 20.0,top: 6,bottom: 6),
              child: Text("Don't just list things you're grateful for. Take a moment to truly feel the gratitude in your heart for each blessing you note down. When you make a conscious effort to see and appreciate the blessings in your life, you're essentially turning into a mindset of gratitude. This mindset will attract you more and more blessings to feel grateful for. Turn on notifications to be consistently reminded of those blessings, feel a deep sense of gratitude for them, and watch them multiply.",style: TextStyle(color: Colors.white,fontSize: 16),),
            ),
            SizedBox(height: 20,),
            ///4
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 8.0),
                  child: Text("	•	Utilize the Journal Effectively:",style: TextStyle(color: Colors.white,fontSize: 18),),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.only(left: 20.0,top: 6,bottom: 6),
              child: Text("Use the journal for self-reflection, setting intentions, and tracking progress. This can provide valuable insights into your personal growth.",style: TextStyle(color: Colors.white,fontSize: 16),),
            ),

            SizedBox(height: 20,),
            ///5
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 8.0),
                  child: Text("	•	Amplify Feel It Now Exercise:",style: TextStyle(color: Colors.white,fontSize: 18),),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.only(left: 20.0,top: 6,bottom: 6),
              child: Text("Engage all your senses in the 'Feel It Now' exercise. Visualize, feel, and embody the experience as vividly as possible. Try to stay in those feelings for as long as possible after that exercise. Think, feel, speak, and act like the person you want to become throughout the day.",style: TextStyle(color: Colors.white,fontSize: 16),),
            ),
            SizedBox(height: 20,),
            ///6
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 8.0),
                  child: Text("	•	Send Heartfelt Messages:",style: TextStyle(color: Colors.white,fontSize: 18),),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.only(left: 20.0,top: 6,bottom: 6),
              child: Text("When sending gratitude messages, be specific about what you appreciate in the person. This creates a deeper connection and resonates more profoundly. When you write the message you’re gonna feel a surge of positive energy flowing inside you, Feel it and be grateful for it, and do it as often as possible. This type of energy is magnetic not only to the people you send the messages to but to all goals and experiences at the same frequency. ",style: TextStyle(color: Colors.white,fontSize: 16),),
            ),

            SizedBox(height: 20,),
            ///7
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 8.0),
                  child: Text("	•	Create an Inspiring Vision Board:",style: TextStyle(color: Colors.white,fontSize: 18),),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.only(left: 20.0,top: 6,bottom: 6),
              child: Text("Choose images and words that evoke strong emotions and a sense of achievement. Your vision board should inspire and motivate you daily.",style: TextStyle(color: Colors.white,fontSize: 16),),
            ),

            SizedBox(height: 20,),
            ///8
            Padding(
              padding:  EdgeInsets.only(left: 8.0),
              child: Text("	•	Engage with Your 'Abundant Bank Account' and \n 'Net Worth':",style: TextStyle(color: Colors.white,fontSize: 18),),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 20.0,top: 6,bottom: 6),
              child: Text("Each time you check your 'Abundant Bank Account,' or 'Net Worth' take a moment to immerse yourself in the feeling of financial abundance. Imagine what achieving your financial goals will feel like and be thankful for them as if they exist right now.",style: TextStyle(color: Colors.white,fontSize: 16),),
            ),
            SizedBox(height: 20,),
            ///9
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 8.0),
                  child: Text("	•	Customize Notifications for Optimal Impact:",style: TextStyle(color: Colors.white,fontSize: 18),),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.only(left: 20.0,top: 6,bottom: 6),
              child: Text("Set notifications at times when you're most receptive. These gentle reminders will help keep your mindset aligned with abundance throughout the day.",style: TextStyle(color: Colors.white,fontSize: 16),),
            ),
            SizedBox(height: 20,),
            ///10
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 8.0),
                  child: Text("	•	Share Your Journey:",style: TextStyle(color: Colors.white,fontSize: 18),),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.only(left: 20.0,top: 6,bottom: 6),
              child: Text("Use the app to connect with like-minded individuals. Sharing your experiences and insights can provide mutual support and inspiration.",style: TextStyle(color: Colors.white,fontSize: 16),),
            ),
            ///11
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 8.0),
                  child: Text("	•	Practice Patience and Trust the Process:",style: TextStyle(color: Colors.white,fontSize: 18),),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.only(left: 20.0,top: 6,bottom: 6),
              child: Text("Transformations take time. Trust in the power of the practices and be patient with yourself. Small, consistent steps lead to significant shifts. ",style: TextStyle(color: Colors.white,fontSize: 16),),
            ),
            ///12
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 8.0),
                  child: Text("	•	Celebrate Your Wins:",style: TextStyle(color: Colors.white,fontSize: 18),),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.only(left: 20.0,top: 6,bottom: 6),
              child: Text("Acknowledge and celebrate your achievements, no matter how small they are. This reinforces a positive mindset and encourages further progress.",style: TextStyle(color: Colors.white,fontSize: 16),),
            ),

            SizedBox(height: 200,),
          ],
        ),
      ),
    );
  }
}

class Item {
  String question;
  String answer;
  bool isExpanded;

  Item(this.question, this.answer, {this.isExpanded = false});
}

class CustomExpansionPanel extends StatefulWidget {
  final Item item;

  CustomExpansionPanel({required this.item});

  @override
  _CustomExpansionPanelState createState() => _CustomExpansionPanelState();
}

class _CustomExpansionPanelState extends State<CustomExpansionPanel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            setState(() {
              widget.item.isExpanded = !widget.item.isExpanded;
            });
          },
          title: Text(widget.item.question,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          trailing: Icon(
            widget.item.isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            color: Colors.white,
          ),
        ),
        if (widget.item.isExpanded)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.item.answer,style: TextStyle(color: Colors.white)),
          ),
        Divider(height: 1, color: Colors.grey),
      ],
    );
  }
}
