//
//  SegmentedSelectorViewState.swift
//  SegmentedSelector
//
//  Created by Wyatt Harrell on 12/17/24.
//

import SwiftUI

public typealias CRI = CaseIterable & RawRepresentable & Identifiable

public final class SegmentedSelectorViewState<T: CRI>: ObservableObject where T.RawValue == String, T.AllCases: RandomAccessCollection {

    public enum Shape {
        case roundedRectangle(cornerRadius: CGFloat)
        case capsule
    }

    let shape: Shape
    let font: Font
    let animation: Animation
    let padding: CGFloat
    let selectedSegmentColor: Color
    let backgroundColor: Color

    @Published public var selectedSegment: T

    public init(
        shape: Shape = .roundedRectangle(cornerRadius: 10),
        selectedSegmentColor: Color = Color.white,
        backgroundColor: Color = Color(UIColor.systemGray6),
        font: Font = Font.system(
            .body,
            design: .rounded,
            weight: .medium
        ),
        animation: Animation = .default,
        padding: CGFloat = 5,
        selectedSegment: T
    ) {
        self.font = font
        self.animation = animation
        self.padding = padding
        self.selectedSegment = selectedSegment
        self.selectedSegmentColor = selectedSegmentColor
        self.backgroundColor = backgroundColor
        self.shape = shape
    }
}
