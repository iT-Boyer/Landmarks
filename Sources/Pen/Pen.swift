//
//  SwiftUIView.swift
//  
//
//  Created by boyer on 2022/2/24.
//

import SwiftUI
struct Pen: View {
    @State var numberOfSegments = 3.0
    var body: some View {
        VStack {
            HStack {
                Text("命运之笔")
                  .font(.system(size: 28))
                  .fontWeight(.bold)
                  .frame(alignment:.leading)
                Spacer()
            }.padding()
            Button {
                //action
            } label: {
                //
                Image("sharpie", bundle: Bundle.module)
                    .resizable()
                    .frame(width: 300, height: 400, alignment: .top)
            }
            Slider(value: $numberOfSegments, in: 2...12, step: 1.0)
              .padding()
            Text("设置可选择的人数为：\(numberOfSegments, specifier:"%.f")")
        }
    }
}

struct Pen_Previews: PreviewProvider {
    static var previews: some View {
        Pen()
    }
}
