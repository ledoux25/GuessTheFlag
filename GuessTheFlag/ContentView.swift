//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sanguo Joseph Ledoux on 8/25/25.
//

import SwiftUI


struct ContentView: View {
        
    
    @State private var showingAlert = false

    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland",
        "Spain", "UK", "Ukraine", "US",
    ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var showingReset = false
    @State private var scoreTitle = ""
    @State private var answer: [String] = []
    @State private var score = 0
    @State private var numberSelected: Int?
    @State private var start = Date().addingTimeInterval(0)
    @State private var end = Date().addingTimeInterval(8)

    


    
    
    struct FlagImage: View {
        var imageUrl: String

        var body: some View {
            Image(imageUrl)
                .border(Color(red: 0.82, green: 0.82, blue: 0.82), width: 0.5)
                .clipShape(.rect(cornerRadius: 10))
                .scaleEffect(1.5)
        }
    }
    
    




    func flagTapped(_ number: Int) {

        numberSelected = number
        if number == correctAnswer {
            answer.append("\(countries[correctAnswer]) true ")

            score += 1
        } else {
            answer.append("\(countries[correctAnswer]) false")
            scoreTitle = "Wrong"

        }

        if answer.count >= 8 {
            showingAlert = true

        }

        showingScore = true
    }

    func askQuestion() {

        if answer.count == 8 {
            showingAlert = true
        }

        start = Date().addingTimeInterval(0)
        end = Date().addingTimeInterval(8)
        countries.shuffle()
        numberSelected = nil
        correctAnswer = Int.random(in: 0...2)
    }

    func restart() {
        score = 0
        answer.removeAll()
        showingAlert = false
        askQuestion()
    }
    
    

    var body: some View {

        NavigationStack {

            ZStack {
                Color(red: 0.99, green: 1, blue: 0.98)
                VStack {
                    Spacer()
                    ProgressView(timerInterval: start...end) {

                        EmptyView()

                    }
                    Spacer()
                    Spacer()
                    FlagImage(imageUrl: countries[correctAnswer])
                    Spacer()
                    Spacer()

                    Text(
                        numberSelected == nil
                            ? "_________" : countries[correctAnswer]
                    )
                    .font(.title.bold())
                    Spacer()
                    Spacer()

                    VStack(spacing: 15) {

                        ForEach(0..<3, id: \.self) { number in
                            Button {
                                flagTapped(number)
                            } label: {
                                ZStack(alignment: .leading) {
                                    Color.white
                                    if number == numberSelected
                                        && number != correctAnswer
                                    {
                                        Color(red: 0.9, green: 0.1, blue: 0.2)

                                    }
                                    if numberSelected != nil
                                        && number == correctAnswer
                                    {
                                        Color(red: 0.3, green: 0.7, blue: 0.4)
                                    }
                                    Text("\(number + 1). \(countries[number])")
                                        .foregroundStyle(
                                            numberSelected == number
                                                || number == correctAnswer
                                                    && numberSelected != nil
                                                ? Color.white : Color.black
                                        )
                                        .font(.body.bold())
                                        .padding(.horizontal, 15)

                                }.clipShape(.rect(cornerRadius: 10))

                            }.frame(maxHeight: 45)
                                .padding(.horizontal, 30)

                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 35)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 40))
                    Spacer()
                    Spacer()
                    HStack {
                        ForEach(answer, id: \.self) { ans in
                            Text("")
                                .scoreBubbleMod(ans: ans)
                                .clipShape(.rect(cornerRadius: 20))
                        }
                        ForEach(0..<(8 - answer.count), id: \.self) { id in

                            Text("")
                                .frame(maxWidth: .infinity, maxHeight: 10)
                                .background(.gray)
                                .clipShape(.rect(cornerRadius: 20))
                        }

                    }
                    .padding(.horizontal, 10)
                    Spacer()

                    Spacer()
                    HStack(spacing: 150) {
                        Button("Reset") {
                            showingReset = true
                        }.alert("! RESET !", isPresented: $showingReset) {
                            Button("Cancel", role: .cancel) {
                                showingReset = false
                            }
                            Button("Reset", role: .destructive) {
                                restart()
                            }
                        } message: {
                            Text(
                                "Are you sure \n all your progress is gonna be lost"
                            )
                        }
                        Button {
                            askQuestion()
                        } label: {
                            Text(answer.count < 8 ? "Next" : "Results")
                                .clipShape(.buttonBorder)
                        }.alert(
                            "GAME OVER : \(score)/8",
                            isPresented: $showingAlert,
                        ) {

                            Button("Nah!", role: .cancel) {
                                showingAlert = false
                            }
                            Button("For sure !", role: .cancel) {
                                restart()
                            }
                        } message: {
                            Text("Wanna give it another try ?")
                        }
                    }
                }.padding()
                    .navigationTitle("Guess the country")
                    .navigationBarTitleDisplayMode(.inline)

            }

        }.ignoresSafeArea()

    }

}

struct scoreBubble: ViewModifier {
    
    var ans : String
    
    func body(content: Content) -> some View {
        
        content
            .frame(maxWidth: .infinity, maxHeight: 10)
            .background(
                ans.contains("true")
                    ? Color(red: 0.3, green: 0.7, blue: 0.4)
                    : Color(red: 0.9, green: 0.1, blue: 0.2)
            )
            .clipShape(.rect(cornerRadius: 20))
    }
}

extension View {
    func scoreBubbleMod (ans : String) -> some View{
        modifier(scoreBubble(ans: ans))
    }
}

#Preview {
    ContentView()
}
