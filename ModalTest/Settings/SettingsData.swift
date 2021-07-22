//
//  SettingsData.swift
//  ModalTest
//
//  Created by Den Jo on 2021/06/21.
//

import SwiftUI

final class SettingsData: ObservableObject {
    
    // MARK: - Value
    // MARK: Public
    @Published var offset: CGFloat = 0
    @Published var cornerRadius: CGFloat = 30
    @Published var startLocationY: CGFloat = 0
    @Published var delta: CGFloat = 0
    @Published var isDragging = false
    @Published var padding: CGFloat = 30
    
    let height: CGFloat = 670
    let compactHeight: CGFloat = 80
    
    var setttings = [String: Any]()

    
    // MARK: - Function
    // MARK: Public
    func handle(value: DragGesture.Value, isEnded: Bool) {
        switch isEnded {
        case false:
            let ratio = 1 - (offset / (height - compactHeight))
            
            switch isDragging {
            case false:
                isDragging.toggle()
                if offset == 0  {
                    startLocationY = value.startLocation.y
                    
                } else {
                    delta = offset - (value.startLocation.y - startLocationY)
                }
                
            case true:
                break
            }
            
            offset       = value.location.y - startLocationY + delta
            cornerRadius = min(max(0, ratio), 1) * 30
            padding      = min(max(0, ratio), 1) * 30

            
        case true:
            isDragging = false
            
            let velocity = value.predictedEndLocation.y - value.location.y
            let ratio = offset / height
            
            if ratio <= 0.5 {
                if 60 < velocity {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        update(isExpanded: false)
                    }
                    
                } else {
                    withAnimation(.spring(response: velocity < -700 ? 0.3 : 0.5, dampingFraction: velocity < -700 ? 0.6 : 1)) {
                        update(isExpanded: true)
                    }
                }
            
            } else {
                if velocity < -60 {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        update(isExpanded: true)
                    }
                    
                } else {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                        update(isExpanded: false)
                    }
                }
            }
        }
    }
    
    // MARK: Private
    private func update(isExpanded: Bool) {
        switch isExpanded {
        case false:
            offset       = height - compactHeight
            cornerRadius = 0
            padding      = 0
            
        case true:
            offset         = 0
            cornerRadius   = 30
            padding        = 30
            
            delta          = 0
            startLocationY = 0
        }
    }
}
