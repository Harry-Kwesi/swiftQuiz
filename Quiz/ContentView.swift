//
//  ContentView.swift
//  Quiz
//
//  Created by Harry Kwesi De Graft on 07/12/23.
//

import SwiftUI

struct Question {
    let text: String
    let options: [String]
    let correctAnswer: String
}

struct ContentView: View {
    
    @State private var questions = [
            Question(text: "What is the capital of France?", options: ["Berlin", "Paris", "Madrid", "Rome"], correctAnswer: "Paris"),
            Question(text: "Which planet is known as the Red Planet?", options: ["Venus", "Mars", "Jupiter", "Saturn"], correctAnswer: "Mars"),
            Question(text: "What is the largest mammal in the world?", options: ["Elephant", "Blue Whale", "Giraffe", "Hippopotamus"], correctAnswer: "Blue Whale"),
            Question(text: "In which year did the Titanic sink?", options: ["1912", "1920", "1935", "1941"], correctAnswer: "1912"),
            Question(text: "What is the capital of Japan?", options: ["Beijing", "Seoul", "Tokyo", "Bangkok"], correctAnswer: "Tokyo"),
            Question(text: "Who wrote 'Romeo and Juliet'?", options: ["William Shakespeare", "Jane Austen", "Charles Dickens", "Mark Twain"], correctAnswer: "William Shakespeare"),
            Question(text: "Which country is known as the 'Land of the Rising Sun'?", options: ["China", "South Korea", "Japan", "Vietnam"], correctAnswer: "Japan"),
            Question(text: "What is the largest ocean on Earth?", options: ["Atlantic Ocean", "Indian Ocean", "Southern Ocean", "Pacific Ocean"], correctAnswer: "Pacific Ocean"),
            Question(text: "What is the capital of Australia?", options: ["Sydney", "Melbourne", "Canberra", "Brisbane"], correctAnswer: "Canberra"),
            Question(text: "Who painted the Mona Lisa?", options: ["Vincent van Gogh", "Leonardo da Vinci", "Pablo Picasso", "Claude Monet"], correctAnswer: "Leonardo da Vinci"),
            Question(text: "What is the currency of Brazil?", options: ["Euro", "Peso", "Real", "Dollar"], correctAnswer: "Real"),
            // Add more questions as needed
        ]

      @State private var currentQuestionIndex = 0
      @State private var selectedAnswer: String?
      @State private var score = 0
      @State private var timerValue = 10
      @State private var timer: Timer?
      @State private var quizCompleted = false
    
    var body: some View {
        if quizCompleted {
                    SummaryView(score: score, totalQuestions: questions.count)
                } else {
                    VStack {
                        Text("Question \(currentQuestionIndex + 1)")
                            .font(.headline)
                            .padding()

                        Text(questions[currentQuestionIndex].text)
                            .padding()

                        ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                            Button(action: {
                                optionSelected(option)
                            }) {
                                Text(option)
                                    .padding()
                                    .background(selectedAnswer == option ? Color.blue : Color.white)
                            }
                            .disabled(selectedAnswer != nil)
                        }

                        Text("Timer: \(timerValue)")
                            .padding()

                        HStack {
                            Text("Score: \(score)")
                                .padding()
                            Spacer()
                            Button("Next Question") {
                                nextQuestion()
                            }
                            .disabled(selectedAnswer == nil || currentQuestionIndex == questions.count - 1)
                        }
                        .padding()
                    }
                    .background(Color.clear)
                    .edgesIgnoringSafeArea(.all)
                    .onAppear(perform: {
                        startTimer()
                    })
                }
            }

    func optionSelected(_ option: String) {
            selectedAnswer = option
            if option == questions[currentQuestionIndex].correctAnswer {
                score += 1
            }
            stopTimer()
        }

        func nextQuestion() {
            if currentQuestionIndex < questions.count - 1 {
                currentQuestionIndex += 1
                selectedAnswer = nil
                timerValue = 10
                startTimer()
            } else {
                // Quiz completed
                stopTimer()
                quizCompleted = true
            }
        }

        func startTimer() {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if timerValue > 0 {
                    timerValue -= 1
                } else {
                    // Time's up
                    stopTimer()
                    nextQuestion()
                }
            }
        }

        func stopTimer() {
            timer?.invalidate()
            timer = nil
        }
    }

    struct SummaryView: View {
        let score: Int
        let totalQuestions: Int

        var body: some View {
            VStack {
                Text("Quiz Completed!")
                    .font(.title)
                    .padding()

                Text("Your Score: \(score) / \(totalQuestions)")
                    .font(.headline)
                    .padding()

                // You can add more information or actions here, such as a restart button.

                Spacer()
            }
            .padding()
            .background(Color.cyan)
            .edgesIgnoringSafeArea(.all)
        }
    }
#Preview {
    ContentView()
}
