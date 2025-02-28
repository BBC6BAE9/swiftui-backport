//
//  View+Corner.swift
//  Nova
//
//  Created by huanghong on 8/26/24.
//  Copyright © 2024 Fooman Inc. All rights reserved.
//

import SwiftUI

/// a replacement of UnevenRoundedRectangle
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
struct BackportUnevenRoundedRectangle: Shape {
    
    var topLeadingRadius: CGFloat = 0.0
    var bottomLeadingRadius: CGFloat = 0.0
    var bottomTrailingRadius: CGFloat = 0.0
    var topTrailingRadius: CGFloat = 0.0
    
    func path(in rect: CGRect) -> Path {
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
            return UnevenRoundedRectangle(
                topLeadingRadius: topLeadingRadius,
                bottomLeadingRadius: bottomLeadingRadius,
                bottomTrailingRadius: bottomTrailingRadius,
                topTrailingRadius: topTrailingRadius
            ).path(in: rect)
        }else{
            var path = Path()
            let w = rect.size.width
            let h = rect.size.height
            
            let tr = min(min(self.topTrailingRadius, h/2), w/2)
            let tl = min(min(self.topLeadingRadius, h/2), w/2)
            let bl = min(min(self.bottomLeadingRadius, h/2), w/2)
            let br = min(min(self.bottomTrailingRadius, h/2), w/2)
            
            path.move(to: CGPoint(x: w/2.0, y: 0))
            path.addLine(to: CGPoint(x: w - tr, y: 0))
            path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
            path.addLine(to: CGPoint(x: w, y: h - br))
            path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
            path.addLine(to: CGPoint(x: bl, y: h))
            path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
            path.addLine(to: CGPoint(x: 0, y: tl))
            path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            
            return path
        }
    }
}


#Preview {
    Text("Hello, world!")
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
          .background(.yellow)
          .mask {
              BackportUnevenRoundedRectangle(topLeadingRadius: 10, bottomTrailingRadius: 10)
          }
}
