//
//  DetailView.swift
//  ModalTest
//
//  Created by Den Jo on 2021/06/11.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Value
    // MARK: Public
        
    // MARK: Private
    @ObservedObject private var data = SettingsData()
    private var completion: ((_ settings: [String: Any]) -> Void)? = nil

    private var gesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged {
                data.handle(value: $0, isEnded: false)
            }
            .onEnded {
                data.handle(value: $0, isEnded: true)
            }
    }
    
    
    // MARK: - Initializer
    init(settings: [String: Any] = [:], completion: ((_ settings: [String: Any]) -> Void)? = nil) {
        data.setttings = settings
        self.completion = completion
    }
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                    .frame(maxHeight: .infinity)
                
                VStack(spacing: 0) {
                    HStack{
                        Spacer()
                            .frame(width: 28, height: 28)
                            .padding()
                        
                        Spacer()
                        
                        Color.gray
                            .frame(width: proxy.size.width / 3, height: 8)
                            .cornerRadius(4)
                            .padding(.vertical, 20)
                            .contentShape(Rectangle())
                            .gesture(gesture)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                completion?([:])
                            }
                            
                        }) {
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundColor(.black)
                        }
                        .padding()
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: data.cornerRadius)
                            .fill(Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
                            .padding(EdgeInsets(top: 0, leading: data.padding, bottom: data.padding, trailing: data.padding))
                    }
                    .frame(height: data.height)
                }
                .background(Color.white)
                .cornerRadius(data.cornerRadius)
                .offset(y: data.offset)
            }
            .ignoresSafeArea()
        }
        .transition(.move(edge: .bottom))
    }
}

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}
#endif
