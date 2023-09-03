import 'package:flutter/material.dart';

// TODO: Add your student ID here
const studentId = '640710176';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _questionIndex = 0;
  List<Map<String, Object>> _questions = [
    {
      'questionText': 'What is the capital of France?',
      'answers': ['Paris', 'London', 'Berlin', 'Madrid'],
      'correctAnswer': 'Paris',
    },
    // Add more questions here
  ];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg_colorful.jpg"),
              opacity: 0.6,
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Good Morning',
                  textAlign: TextAlign.center, style: textTheme.headline6),
              Text(studentId,
                  textAlign: TextAlign.center,
                  style: textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black87)),
              Spacer(),
              _buildQuizView(),
              Spacer(),
              _buildButtonPanel(),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuizView() {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 2.0),
        ),
        child: Column(
          children: [
            Text(
              'Question ${_questionIndex + 1} of ${_questions.length}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              alignment: Alignment.center,
              child: Text(
                _questions[_questionIndex]['questionText'] as String? ?? "",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Column(
              children: List.generate(
                4,
                    (index) {
                  final answerText = (_questions[_questionIndex]['answers'] as List<String>?)!.elementAt(index) ?? "";
                  final isCorrect = answerText == _questions[_questionIndex]['correctAnswer'];
                  return _buildAnswerChoice(
                    answerText: answerText,
                    isCorrect: isCorrect,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerChoice({
    required String answerText,
    required bool isCorrect,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          primary: isCorrect ? Colors.green : Colors.blue,
          minimumSize: Size(double.infinity, 50),
          alignment: Alignment.centerLeft,
        ),
        child: Row(
          children: [
            Text(
              "A",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 16.0),
            Text(answerText),
            if (isCorrect) // Show the checkmark if the answer is correct
              Icon(
                Icons.check,
                color: Colors.green,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonPanel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            // Move to the next question
            setState(() {
              _questionIndex++;
              if (_questionIndex >= _questions.length) {
                // Handle the end of the quiz
              }
            });
          },
          style: ElevatedButton.styleFrom(primary: Colors.red),
          child: Text('Next'),
        ),
        ElevatedButton(
          onPressed: () {
            // Submit the quiz and calculate the score
          },
          style: ElevatedButton.styleFrom(primary: Colors.green),
          child: Text('Submit'),
        ),
      ],
    );
  }
}
