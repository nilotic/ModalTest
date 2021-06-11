//
//  ContentView.swift
//  ModalTest
//
//  Created by Den Jo on 2021/06/11.
//

import SwiftUI

struct ContentView: View {

    @State private var showingSheet = false

    var body: some View {
        ZStack {
            Button("Show Sheet") {
                withAnimation(.spring(response: 0.38, dampingFraction: 1, blendDuration: 0)) {
                    showingSheet.toggle()
                }
            }
            .padding(.bottom, 250)
            
            if showingSheet {
                dimView
                DetailView()
            }
        }
    }
    
        
    private var dimView: some View {
        Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2990459033))
            .ignoresSafeArea()
            .transition(.opacity)
            .onTapGesture {
                withAnimation {
                    showingSheet = false
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
