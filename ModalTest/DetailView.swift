//
//  DetailView.swift
//  ModalTest
//
//  Created by Den Jo on 2021/06/11.
//

import SwiftUI

struct DetailView: View {
    
    @State private var offset: CGFloat = 0
    
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
                        .gesture(
                            DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                .onChanged { value in
                                    offset = value.location.y - (proxy.size.height - 370 + 48)
                                    print(value.location)
                                }
                                .onEnded { value in
                                    print(value)
                                }
                        )
                        
                    
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
                            .padding(EdgeInsets(top: 10, leading: 40, bottom: 40, trailing: 40))
                    }
                    .frame(height: 370)
                }
                .background(Color.white)
                .clipShape(RoundedCorner(radius: 30, corners: [.topLeft, .topRight]))
                .offset(y: offset)
            }
            .ignoresSafeArea()
        }
        .transition(.move(edge: .bottom))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
            .preferredColorScheme(.dark)
    }
}
