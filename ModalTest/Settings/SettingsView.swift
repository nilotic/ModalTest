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
    @State private var ratio: CGFloat = 0
    
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
    
    private var priceFontModifier: FontModifier {
        switch stage {
        case 0:     return FontModifier(size: 55, weight: .bold)
        case 1:     return FontModifier(size: 40, weight: .bold)
        default:    return FontModifier(size: 20, weight: .semibold)
        }
    }
    
    private var currencyFontModifier: FontModifier {
        switch stage {
        case 0:     return FontModifier(size: 20, weight: .regular)
        case 1:     return FontModifier(size: 15, weight: .bold)
        default:    return FontModifier(size: 10, weight: .semibold)
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
                            if stage == 0 {
                              stage1Header
                            }
                            
                            
                            HStack(alignment: .bottom, spacing: 2) {
                                Text("40,000")
                                    .modifier(priceFontModifier)
                                
                                
                                Text("원")
                                    .modifier(currencyFontModifier)
                            }
                            .foregroundColor(Color(#colorLiteral(red: 0.4929332733, green: 0.2706458867, blue: 1, alpha: 1)))
                            
                            
                            
                            
                            if stage == 0 {
                                numberPadView
                                
                            } else if (stage == 1 || stage == 2) {
                                VStack {
                                    if stage == 1 {
                                        splitterView
                                        description
                                    }
                                    
                                    accounts
                                    
                                    if stage == 1 {
                                        requestButton
                                    
                                    } else if stage == 2 {
                                        numberPadView
                                    }
                                }
                                .padding(.top, 40)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: data.padding, bottom: data.padding, trailing: data.padding))
                    }
                    .frame(height: data.height)
                    .clipped()
                }
                .background(Color.white)
                .cornerRadius(data.cornerRadius)
                .offset(y: data.offset)
            }
            .ignoresSafeArea()
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
    
    // MARK: Private
    private var stage1Header: some View {
        VStack {
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
        }
        .transition(.move(edge: .top).combined(with: .opacity))
    }
    
    private var numberPadView: some View {
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
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.7)) {
                        stage = 1
                    }
                    
                }) {
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
        .padding(.top, stage == 2 ? 100 : 60)
        .transition(.move(edge: stage == 2 ? .bottom : .top).combined(with: .opacity))
    }
    
    private var splitterView: some View {
        ZStack {
            HStack {
                Text("나누기")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.leading, 30)
                    .frame(height: 40)
                
                SplitterSlider(value: $ratio, in: 0...1, step: 0.001)
                    .padding(.horizontal, 25)
                    
                Text("모으기")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.trailing, 30)
                    .frame(height: 40)
            }
        }
        .frame(height: 80)
        .background(Color(#colorLiteral(red: 0.9727559686, green: 0.97229141, blue: 0.9852736592, alpha: 1)))
        .cornerRadius(10)
        .transition(.move(edge: stage == 2 ? .bottom : .top).combined(with: .opacity))
    }
    
    private var description: some View {
         HStack(spacing: 0) {
             Text("40,000원")
                 .font(.system(size: 15, weight: .semibold))
                 .foregroundColor(Color(#colorLiteral(red: 0.3876618147, green: 0.3994019628, blue: 0.4427378774, alpha: 1)))
             
             Text("을 ")
                 .font(.system(size: 15, weight: .regular))
                 .foregroundColor(Color(#colorLiteral(red: 0.7372612357, green: 0.7407440543, blue: 0.7668042183, alpha: 1)))
             
             Text("1/N")
                 .font(.system(size: 15, weight: .regular))
                 .foregroundColor(Color(#colorLiteral(red: 0.3876618147, green: 0.3994019628, blue: 0.4427378774, alpha: 1)))
             
             Text(" 합니다")
                 .font(.system(size: 15, weight: .regular))
                 .foregroundColor(Color(#colorLiteral(red: 0.7372612357, green: 0.7407440543, blue: 0.7668042183, alpha: 1)))
         }
         .padding(.top, 10)
         .transition(.move(edge: stage == 2 ? .bottom : .top).combined(with: .opacity))
    }
    
    private var accounts: some View {
        VStack(spacing: 0) {
            HStack(spacing: 70) {
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(#colorLiteral(red: 0.7772348523, green: 0.530770421, blue: 0.8661416173, alpha: 1)))
                
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0.7548418045, blue: 0.483674705, alpha: 1)))
                
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(#colorLiteral(red: 0.7745447755, green: 0.8321439028, blue: 0.8874315619, alpha: 1)))
            }
            .padding(.top, stage == 2 ? 0 : 80)
            
            HStack(spacing: 70) {
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(#colorLiteral(red: 0.3346823454, green: 0.6042745709, blue: 0.8460275531, alpha: 1)))
                
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(#colorLiteral(red: 0.9727559686, green: 0.97229141, blue: 0.9852736592, alpha: 1)))
                
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            }
            .padding(.top, 50)
        }
    }
    
    private var requestButton: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.7)) {
                    stage = 2
                }
                
            }) {
                Text("요청하기")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .regular))
                    .padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
                    .frame(maxWidth: .infinity)
                    .background(Color(#colorLiteral(red: 0.4929332733, green: 0.2706458867, blue: 1, alpha: 1)))
                    .cornerRadius(15)
            }
            .padding(.top, 80)
    
        }
        .transition(.move(edge: stage == 2 ? .bottom : .top).combined(with: .opacity))
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
