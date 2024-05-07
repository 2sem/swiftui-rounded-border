//
//  SwiftUI+View+.swift
//  QueensBladeLimitHelper
//
//  Created by 영준 이 on 4/4/24.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
extension View {
    public func roundedBorder<IN_S, OUT_S>(_ content: AnyView,
                       width: CGFloat,
                       cornerRadius: CGFloat,
                       position: RoundedBorderPosition = .outside,
                       in insideStyle: RoundedBorderStyle<IN_S> = DefaultRoundedBorderStyle,
                       out outsideStyle: RoundedBorderStyle<OUT_S> = DefaultRoundedBorderStyle) -> some View where IN_S: ShapeStyle, OUT_S: ShapeStyle {
        modifier(RoundedBorderModifier<IN_S, OUT_S>(width: width,
                                       borderContent: content,
                                       cornerRadius: cornerRadius,
                                       position: position,
                                       insideStyle: insideStyle,
                                       outsideStyle: outsideStyle))
    }
}

public enum RoundedBorderPosition {
    case inside
    case center
    case outside
}

public let DefaultRoundedBorderStyle = RoundedBorderStyle(content: Color.black, width: 0, cornerRadius: -1)

@available(iOS 13.0, *)
public struct RoundedBorderStyle<S: ShapeStyle> {
    var content: S
    var width: CGFloat
    var cornerRadius: CGFloat
    
    public init(content: S, width: CGFloat, cornerRadius: CGFloat = -1) {
        self.content = content
        self.width = width
        self.cornerRadius = cornerRadius
    }
}

@available(iOS 13.0, *)
public struct RoundedBorderModifier<IN_S: ShapeStyle, OUT_S: ShapeStyle>: ViewModifier {
    var width: CGFloat = 1
    let borderContent: AnyView
    let cornerRadius: CGFloat
    var position: RoundedBorderPosition = .outside
    let insideStyle: RoundedBorderStyle<IN_S>
    let outsideStyle: RoundedBorderStyle<OUT_S>
    
    var insideBorderContent: some ShapeStyle {
        return insideStyle.content
    }
    
    var outsideBorderContent: some ShapeStyle {
        return outsideStyle.content
    }
    
    public func body(content: Content) -> some View {
        let offset = makePositionedBorderOffset()
        let insideCornerRadius = makeInsideCornerRadius()
        
        if #available(iOS 15.0, *) {
            return content
                .clipShape(RoundedRectangle(cornerRadius: insideCornerRadius))
                .overlay {
                    GeometryReader(content: { geometry in
                        let borderSize = makePositionedBorderSize(geometry.size)
                        let outsideBorderSize = makePositionedOutsideBorderSize(geometry.size)
                        let insideBorderSize = makePositionedinsideBorderSize(geometry.size)
                        
                        
                        ZStack {
                            borderContent   // desitination
                                .frame(width: borderSize.width,
                                       height: borderSize.height)
                                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                            
                            Color.black    // source
                                .frame(width: insideBorderSize.width,
                                       height: insideBorderSize.height)
                                .blendMode(.destinationOut)
                                .clipShape(RoundedRectangle(cornerRadius: insideCornerRadius))
                                .overlay {
                                    RoundedRectangle(cornerRadius: insideCornerRadius)
                                        .stroke(insideBorderContent, lineWidth: insideStyle.width)
                                        .frame(width: insideBorderSize.width,
                                               height: insideBorderSize.height)
                                }
                        }
                        .compositingGroup()
                        
                        RoundedRectangle(cornerRadius: outsideStyle.cornerRadius > 0 ? insideStyle.cornerRadius : cornerRadius)
                            .stroke(outsideBorderContent, lineWidth: outsideStyle.width)
                            .frame(width: outsideBorderSize.width,
                                   height: outsideBorderSize.height)
                    }).offset(x: offset.width, y: offset.height)
                }
        } else {
            return content
        }
    }
}

// MARK: Make Postioned Border Sizes
@available(iOS 13.0, *)
extension RoundedBorderModifier {
    func makePositionedBorderSize(_ size: CGSize) -> CGSize {
        return switch position {
            case .outside: CGSize.init(width: size.width + width * 2, height: size.height + width * 2)
            case .inside: size
            case .center: CGSize.init(width: size.width + width, height: size.height + width)
        }
    }
    
    func makePositionedOutsideBorderSize(_ size: CGSize) -> CGSize {
        return switch position {
            case .outside: CGSize.init(width: size.width + width * 2, height: size.height + width * 2)
            case .inside: size
            case .center: CGSize.init(width: size.width + width, height: size.height + width)
        }
    }
    
    func makePositionedinsideBorderSize(_ size: CGSize) -> CGSize {
        return switch position {
            case .outside: size
            case .inside: CGSize.init(width: size.width - width * 2, height: size.height - width * 2)
            case .center: CGSize.init(width: size.width - width, height: size.height - width)
        }
    }
}

@available(iOS 13.0, *)
extension RoundedBorderModifier {
    func makePositionedBorderOffset() -> CGSize {
        return switch position {
            case .outside: .init(width: -width, height: -width)
            case .inside: CGSize.zero
            case .center: .init(width: -width/2, height: -width/2)
        }
    }
}

@available(iOS 13.0, *)
extension RoundedBorderModifier {
    func makeInsideCornerRadius() -> CGFloat {
        return if insideStyle.cornerRadius > 0 { insideStyle.cornerRadius }
            else{ cornerRadius }
    }
}

    
