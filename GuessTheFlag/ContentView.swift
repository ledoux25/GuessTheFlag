//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sanguo Joseph Ledoux on 8/25/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    var body: some View {
        ZStack{
        RadialGradient(
            
            colors : [.red, .blue],
            center: .center,
            startRadius: 20,
            endRadius: 200
        )
            Text("Your content")
                .foregroundStyle(.secondary)
                .padding(50)
                .background(.red.gradient)
        }
        .ignoresSafeArea()
        
        Button("Delete Section", systemImage: "pencil",role: .destructive) {
    
        }.buttonStyle(.borderedProminent)
            .tint(.green)
        
        Image(systemName: "pencil")
        Button("Show alert"){
            showingAlert = true
        }
        .alert("Important Message", isPresented:$showingAlert){
            Button("Delete", role: .destructive){}
            Button("Cancel", role: .cancel){}
        } message: {
            Text("Swift is soooo Damn Hard")
        }
        }
    
        
}

#Preview {
    ContentView()
}
