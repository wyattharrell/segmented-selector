//
//  SegmentedSelectorViewState.swift
//  SegmentedSelector
//
//  Created by Wyatt Harrell on 12/17/24.
//

import SwiftUI

public typealias CRI = CaseIterable & RawRepresentable & Identifiable

public final class SegmentedSelectorViewState<T: CRI>: ObservableObject where T.RawValue == String, T.AllCases: RandomAccessCollection {

    var font: Font
    var animation: Animation
    var cornerRadius: CGFloat
    var padding: CGFloat
    var selectedSegmentColor: Color
    var backgroundColor: Color

    @Published public var selectedSegment: T

    public init(
        selectedSegmentColor: Color = Color.white,
        backgroundColor: Color = Color(UIColor.systemGray6),
        font: Font = Font.system(
            .body,
            design: .rounded,
            weight: .medium
        ),
        animation: Animation = .default,
        cornerRadius: CGFloat = 10,
        padding: CGFloat = 5,
        selectedSegment: T
    ) {
        self.font = font
        self.animation = animation
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.selectedSegment = selectedSegment
        self.selectedSegmentColor = selectedSegmentColor
        self.backgroundColor = backgroundColor
    }
}
