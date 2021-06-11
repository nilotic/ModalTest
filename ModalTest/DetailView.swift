//
//  DetailView.swift
//  ModalTest
//
//  Created by Den Jo on 2021/06/11.
//

import SwiftUI

struct DetailView: View {
    
    // MARK: - Value
    // MARK: Public
    @Binding var isPresented: Bool
    
    // MARK: Private
    @State private var offset: CGFloat = 0
    
    private var gesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged {
                offset = $0.location.y - $0.startLocation.y
            }
            .onEnded { value in
                let velocity = value.predictedEndLocation.y - value.location.y
                let ratio = offset / 370
                print("\(velocity) \(ratio)")
                if 60 < velocity || 0.3...1.2 ~= ratio {
                    withAnimation(.spring(response: 1)) {
                        offset = UIScreen.main.bounds.height
                        isPresented = false
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        offset = 0
                    }
                    
                } else {
                    withAnimation(.spring(response: 0.5)) {
                        offset = 0
                    }
                }
            }
    }
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .center) {
                Spacer()
                    .frame(maxHeight: .infinity)
                
                VStack {
                    Color.gray
                        .frame(width: proxy.size.width / 3, height: 8)
                        .cornerRadius(4)
                        .padding(.vertical, 20)
                        .contentShape(Rectangle())
                        .gesture(gesture)
                        
                        
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
                            .padding(EdgeInsets(top: 10, leading: 40, bottom: 40, trailing: 40))
                    }
                    .frame(height: 370)
                }
                .background(Color.white)
                .cornerRadius(30)
                .offset(y: offset)
            }
            .ignoresSafeArea()
        }
        .transition(.move(edge: .bottom))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(isPresented: .constant(true))
            .preferredColorScheme(.dark)
    }
}
