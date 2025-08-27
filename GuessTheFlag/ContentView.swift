//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sanguo Joseph Ledoux on 8/25/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    
    @State private var countries  = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var tries = 0
    
    
    func flagTapped(_ number : Int) {
        tries += 1
        if tries == 8{
            scoreTitle = "Finished"
            
        }else if(number == correctAnswer){
            scoreTitle = "Correct"
            score += 1
        }else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    var body: some View {
     

        ZStack {
            RadialGradient(
                stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26) , location: 0.3)
                ],
                center: .top,
                startRadius: 200, endRadius: 700

                
            )
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                Spacer()
                Text("Score : \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
                VStack(spacing:15){
                    
                    VStack(spacing: 10,){                    Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.heavy))
                            
                    }
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                            
                            
                        }
                        .alert(scoreTitle,isPresented: $showingScore){
                            Button( tries < 8 ? "Next" : " Restart", role: .cancel){
                                if(tries == 8){
                                    score = 0
                                    tries = 0
                                    return
                                }
                                askQuestion()
                            }
                        } message : {
                            Text("Your score is \(score)/8")
                        }.clipShape(.buttonBorder)
                            .shadow(radius: 5)
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical,20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 40))
                
                
                
            }.padding()
        
        
        }
        
    }
    
        
}

#Preview {
    ContentView()
}
