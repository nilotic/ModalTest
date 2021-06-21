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
    var setttings: [String: Any]
    var completion: ((_ settings: [String: Any]) -> Void)? = nil
    
    // MARK: Private
    @State private var offset: CGFloat = 0
    @State private var cornerRadius: CGFloat = 30
    private let height: CGFloat = 370
    private let compactHeight: CGFloat = 80
    @State private var startLocationY: CGFloat = 0
    @State private var delta: CGFloat = 0
    @State private var isDragging = false
    @State private var padding: CGFloat = 30
    
    private var gesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged {
                let ratio = 1 - (offset / (height - compactHeight))
                print("\($0.location.y) \(startLocationY)")
                
                switch isDragging {
                case false:
                    isDragging.toggle()
                    if offset == 0  {
                        startLocationY = $0.startLocation.y
                        
                    } else {
                        delta = offset - ($0.startLocation.y - startLocationY)
                        print("\(offset) \($0.startLocation.y) \($0.location.y) \(delta)")
                    }
                    
                    
                case true:
                    break
                }
                
                offset       = $0.location.y - startLocationY + delta
                cornerRadius = min(max(0, ratio), 1) * 30
                padding      = min(max(0, ratio), 1) * 30
 
            }
            .onEnded { value in
                isDragging = false
                
                let velocity = value.predictedEndLocation.y - value.location.y
                let ratio = offset / height
                
                print("\(velocity) \(ratio)")
                
                if ratio <= 0.5 {
                    if 60 < velocity {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.78)) {
                            offset       = height - compactHeight
                            cornerRadius = 0
                            padding      = 0
                        }
                        
                    } else {
                        withAnimation(.spring(response: 0.5)) {
                            offset         = 0
                            cornerRadius   = 30
                            padding        = 30
                            
                            delta          = 0
                            startLocationY = 0
                        }
                    }
                
                } else {
                    if velocity < -60 {
                        withAnimation(.spring(response: 0.28, dampingFraction: 0.8)) {
                            offset         = 0
                            cornerRadius   = 30
                            padding        = 30
                            
                            delta          = 0
                            startLocationY = 0
                        }
                        
                    } else {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            offset       = height - compactHeight
                            cornerRadius = 0
                            padding      = 0
                        }
                    }
                }
            }
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
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
                            .padding(EdgeInsets(top: 0, leading: padding, bottom: padding, trailing: padding))
                    }
                    .frame(height: height)
                }
                .background(Color.white)
                .cornerRadius(cornerRadius)
                .offset(y: offset)
            }
            .ignoresSafeArea()
        }
        .transition(.move(edge: .bottom))
    }
}

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsView(setttings: [:])
            .preferredColorScheme(.dark)
    }
}
#endif
