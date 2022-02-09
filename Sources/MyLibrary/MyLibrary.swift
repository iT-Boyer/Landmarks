//
//  SwiftUIView.swift
//  
//
//  Created by boyer on 2022/2/9.
//

import SwiftUI

public struct MyLibrary: View {
    var image: Image
    var borderColor: Color
    var shadowRadius: CGFloat
 
    public var body: some View {
        image
            .clipShape(Circle())
            .overlay(Circle().stroke(borderColor, lineWidth: 4))
            .shadow(radius: shadowRadius)
    }
     
    public init(image: Image,
                borderColor: Color = .white,
                shadowRadius: CGFloat = 10) {
        self.image = image
        self.borderColor = borderColor
        self.shadowRadius = shadowRadius
    }
}

struct MyLibrary_Previews: PreviewProvider {
    static var previews: some View {
        MyLibrary(image: .init(systemName: "star.slash.fill"))
           .offset(x: 0, y: -130)
           .padding(.bottom, -130)
    }
}
