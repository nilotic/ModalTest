//
//  DetailView.swift
//  ModalTest
//
//  Created by Den Jo on 2021/06/11.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Value
    // MARK: Private
    @ObservedObject private var data = SettingsData()
    @State private var stage: Int = 0
    
    
    
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
                        /*
                        RoundedRectangle(cornerRadius: data.cornerRadius)
                            .fill(Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
                            .padding(EdgeInsets(top: 0, leading: data.padding, bottom: data.padding, trailing: data.padding))
                        */
                        
                        VStack(spacing: 0) {
                            ZStack {
                                HStack {
                                    Text("송금하기")
                                        .foregroundColor(.gray)
                                        .padding(EdgeInsets(top: 13, leading: 25, bottom: 15, trailing: 25))
                                        .cornerRadius(30)
                                    
                                    Text("요청하기")
                                        .foregroundColor(.white)
                                        .padding(EdgeInsets(top: 13, leading: 25, bottom: 15, trailing: 25))
                                        .background(Color(#colorLiteral(red: 0.4929332733, green: 0.2706458867, blue: 1, alpha: 1)))
                                        .cornerRadius(30)
                                }
                            }
                            .background(Color(#colorLiteral(red: 0.9727559686, green: 0.97229141, blue: 0.9852736592, alpha: 1)))
                            .cornerRadius(30)
                            
                            
                            HStack(spacing: 0) {
                                Circle()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color(#colorLiteral(red: 0.115576081, green: 0.2003614008, blue: 0.5157104135, alpha: 1)))
                                    .padding(10)
                                
                                Text("받을계좌")
                                    .foregroundColor(.gray)
                              
                                
                                Text("신한은행 112349040482")
                                    .font(.system(size: 15))
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                
                                Text("⌄")
                                    .foregroundColor(.black)
                                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 10, trailing: 13))
                            }
                            .background(Color(#colorLiteral(red: 0.9727559686, green: 0.97229141, blue: 0.9852736592, alpha: 1)))
                            .cornerRadius(30)
                            .padding(.top, 25)
                            
                            
                            Text("사만원")
                                .foregroundColor(Color(#colorLiteral(red: 0.2747699618, green: 0.279959321, blue: 0.2931069434, alpha: 1)))
                                .font(.system(size: 15, weight: .bold))
                                .padding(.top, 50)
                            
                            HStack(alignment: .bottom, spacing: 2) {
                                Text("40,000")
                                    .font(.system(size: 55, weight: .bold))
                                    
                                Text("원")
                                    .font(.system(size: 20))
                            }
                            .foregroundColor(Color(#colorLiteral(red: 0.4929332733, green: 0.2706458867, blue: 1, alpha: 1)))
                            
                            
                            VStack(spacing: 40) {
                                HStack(spacing: 90) {
                                    Text("1")
                                    Text("2")
                                    Text("3")
                                }
                                
                                HStack(spacing: 90) {
                                    Text("4")
                                    Text("5")
                                    Text("6")
                                }
                                
                                HStack(spacing: 90) {
                                    Text("7")
                                    Text("8")
                                    Text("9")
                                }
                                
                                HStack(spacing: 0) {
                                    Text("X")
                                        .font(.system(size: 18, weight: .semibold))
                                        .frame(width: 60, alignment: .leading)
                                        .padding(.leading, 30)
                                    
                                    Text("0")
                                        .frame(width: 100)
                                        .padding(.leading, 5)
                                    
                                    Button(action: { stage = 1 }) {
                                        Text("다음")
                                            .font(.system(size: 18, weight: .semibold))
                                            .foregroundColor(.white)
                                            .frame(width: 80, height: 50)
                                            .background(Color(#colorLiteral(red: 0.4929332733, green: 0.2706458867, blue: 1, alpha: 1)))
                                            .cornerRadius(50)
                                            .padding(.leading, 20)
                                    }
                                }
                            }
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundColor(Color(#colorLiteral(red: 0.4929332733, green: 0.2706458867, blue: 1, alpha: 1)))
                            .padding(.top, 60)
                        }
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
