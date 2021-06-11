//
//  ContentView.swift
//  ModalTest
//
//  Created by Den Jo on 2021/06/11.
//

import SwiftUI

struct ContentView: View {

    // MARK: - Value
    // MARK: Private
    @State private var isPresented = false

    
    // MARK: - View
    // MARK: Public
    var body: some View {
        ZStack {
            Button("Show View") {
                withAnimation(.spring(response: 0.38, dampingFraction: 1, blendDuration: 0)) {
                    isPresented = true
                }
            }
            .padding(.bottom, 250)
            
            if isPresented {
                dimView
                DetailView(isPresented: $isPresented)
            }
        }
    }
     
    
    // MARK: - Value
    // MARK: Private
    private var dimView: some View {
        Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2990459033))
            .ignoresSafeArea()
            .transition(.opacity)
            .onTapGesture {
                withAnimation {
                    isPresented = false
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
