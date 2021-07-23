//
//  FontModifier.swift
//  ModalTest
//
//  Created by Den Jo on 2021/07/23.
//

import SwiftUI

struct FontModifier: AnimatableModifier {

    // MARK: - Value
    // MARK: Public
    var size: CGFloat
    var weight: Font.Weight = .regular
    var design: Font.Design = .default

    var animatableData: CGFloat {
        get { size }
        set { size = newValue }
    }

    
    // MARK: - Function
    // MARK: Public
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight, design: design))
    }
}
