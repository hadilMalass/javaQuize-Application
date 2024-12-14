import 'package:flutter/material.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  // List of questions and answers
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is the main method signature in Java?',
      'options': [
        'public void main(String[] args)',
        'public static void main(String[] args)',
        'void main(String args)',
        'public static main(String[] args)'
      ],
      'answer': 'public static void main(String[] args)',
    },
    {
      'question': 'Which keyword is used to inherit a class in Java?',
      'options': ['import', 'extend', 'inherit', 'implements'],
      'answer': 'extend',
    },
    {
      'question': 'What is the default value of a boolean in Java?',
      'options': ['true', 'null', 'false', '0'],
      'answer': 'false',
    },
    {
      'question': 'Which of these is NOT a primitive data type in Java?',
      'options': ['int', 'boolean', 'String', 'char'],
      'answer': 'String',
    },
    {
      'question': 'What does the `final` keyword in Java signify?',
      'options': [
        'A variable can be reassigned',
        'A class cannot be subclassed',
        'A method cannot be overridden',
        'Both class cannot be subclassed and method cannot be overridden'
      ],
      'answer': 'Both class cannot be subclassed and method cannot be overridden',
    },
  ];


  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _quizCompleted = false;

  // Function to handle answer selection
  void _answerQuestion(String selectedOption) {
    if (selectedOption == _questions[_currentQuestionIndex]['answer']) {
      setState(() {
        _score++;
      });
    }

    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _quizCompleted = true;
      }
    });
  }

  // Function to reset the quiz
  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _quizCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz App'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _quizCompleted
              ? _buildResultScreen()
              : _buildQuestionScreen(),
        ),
      ),
    );
  }

  // Widget to display questions and options
  Widget _buildQuestionScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,   ),
        ),
        SizedBox(height: 20),
        Text(
          _questions[_currentQuestionIndex]['question'],
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 20),
        ..._questions[_currentQuestionIndex]['options'].map<Widget>((option) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,

            ),
            child: Text(option, style: TextStyle(color: Colors.white), ),


            onPressed: () => _answerQuestion(option),
          );
        }).toList(),
      ],
    );
  }

  // Widget to display quiz results
  Widget _buildResultScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Quiz Completed!',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(
          'Your Score: $_score / ${_questions.length}',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
          ),
          onPressed: _resetQuiz,
          child: Text('Restart Quiz' ,style: TextStyle(color: Colors.white),),
        ),
      ],
    );
  }
}
