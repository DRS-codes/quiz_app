import 'package:flutter/material.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Quiz Exam',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int score = 0;
  int currentQuestionIndex = 0;
  List<String> questions = [
    "What is the capital of France?",
    "What is 2 + 2?",
    "Which planet is known as the Red Planet?",
  ];
  List<List<String>> options = [
    ["Paris", "London", "Berlin", "Rome"],
    ["3", "4", "5", "6"],
    ["Earth", "Mars", "Venus", "Jupiter"],
  ];
  List<int> correctAnswers = [
    0, // Paris
    1, // 4
    1, // Mars
  ];
  List<int> selectedAnswers = [-1, -1, -1]; // -1 means no answer selected yet.

  // Function to check the selected answer and update score immediately
  void _checkAnswer(int selectedIndex) {
    setState(() {
      selectedAnswers[currentQuestionIndex] = selectedIndex;
      // If the selected answer is correct, increase the score
      if (selectedIndex == correctAnswers[currentQuestionIndex]) {
        score++;
      }
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  // Reset the score when retaking the quiz
  void _resetQuiz() {
    setState(() {
      score = 0;
      currentQuestionIndex = 0;
      selectedAnswers = [-1, -1, -1]; // Reset answers as well
    });
  }

  void _submitQuiz() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ResultPage(score: score, onRetake: _resetQuiz)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 100,
        flexibleSpace: Padding(
          padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(colors: [
                  const Color.fromARGB(255, 218, 9, 255),
                  const Color.fromARGB(255, 245, 191, 255)
                ])),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quiz',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 30,
                  )
                ],
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isTablet = constraints.maxWidth > 600;
          return Padding(
            padding: EdgeInsets.all(isTablet ? 20 : 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        const Color.fromARGB(255, 218, 9, 255),
                        const Color.fromARGB(255, 245, 191, 255)
                      ])),
                  child: Center(
                    child: Text(
                      questions[currentQuestionIndex],
                      style: TextStyle(
                        fontSize: isTablet ? 24 : 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ...List.generate(options[currentQuestionIndex].length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            const Color.fromARGB(255, 218, 9, 255),
                            const Color.fromARGB(255, 245, 191, 255)
                          ])),
                      child: RadioListTile<int>(
                        activeColor: Colors.white,
                        title: Text(
                          options[currentQuestionIndex][index],
                          style: TextStyle(
                            fontSize: isTablet ? 24 : 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        value: index,
                        groupValue: selectedAnswers[currentQuestionIndex],
                        onChanged: (value) {
                          _checkAnswer(value!);
                        },
                      ),
                    ),
                  );
                }),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (currentQuestionIndex > 0)
                      GestureDetector(
                        onTap: _previousQuestion,
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                const Color.fromARGB(255, 218, 9, 255),
                                const Color.fromARGB(255, 245, 191, 255)
                              ])),
                          child: Center(
                              child: Text(
                            'Previous',
                            style: TextStyle(
                              fontSize: isTablet ? 24 : 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )),
                        ),
                      ),
                    GestureDetector(
                      onTap: currentQuestionIndex == questions.length - 1
                          ? _submitQuiz
                          : _nextQuestion,
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              const Color.fromARGB(255, 218, 9, 255),
                              const Color.fromARGB(255, 245, 191, 255)
                            ])),
                        child: Center(
                          child: Text(
                            currentQuestionIndex == questions.length - 1
                                ? "Submit"
                                : "Next",
                            style: TextStyle(
                              fontSize: isTablet ? 24 : 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int score;
  final VoidCallback onRetake;

  ResultPage({required this.score, required this.onRetake});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 100,
        flexibleSpace: Padding(
          padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(colors: [
                  const Color.fromARGB(255, 218, 9, 255),
                  const Color.fromARGB(255, 245, 191, 255)
                ])),
            child: Center(
              child: Text(
                'Quiz Results',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Your Score: $score",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Reset the quiz state and navigate back
                  onRetake(); // Reset the score and quiz state
                  Navigator.pop(context); // Go back to the quiz page
                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        const Color.fromARGB(255, 218, 9, 255),
                        const Color.fromARGB(255, 245, 191, 255)
                      ])),
                  child: Center(
                    child: Text(
                      'Retake Quiz',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
