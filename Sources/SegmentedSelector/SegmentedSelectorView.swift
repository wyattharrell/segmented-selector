//
//  SegmentedSelector.swift
//  SegmentedSelector
//
//  Created by Wyatt Harrell on 12/17/24.
//

import SwiftUI

public struct SegmentedSelector<T>:
    View where T: CaseIterable & RawRepresentable & Identifiable, T.RawValue == String, T.AllCases: RandomAccessCollection {

    @Namespace
    private var segmentedControl

    @Binding
    private var selectedSegment: T
    private var configuration: SegmentedSelectorConfiguration

    public init(
        configuration: SegmentedSelectorConfiguration = SegmentedSelectorConfiguration(),
        selectedSegment: Binding<T>
    ) {
        self._selectedSegment = selectedSegment
        self.configuration = configuration
    }

    public var body: some View {
        HStack {
            ForEach(T.allCases, id: \.id) { segment in
                Button {
                    withAnimation(configuration.animation) {
                        selectedSegment = segment
                    }
                } label: {
                    Text(segment.rawValue)
                        .font(configuration.font)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .matchedGeometryEffect(
                    id: segment.rawValue,
                    in: segmentedControl
                )
            }
        }
        .conditionallyApply { view in
            if case .roundedRectangle(let cornerRadius) = configuration.shape {
                view.background(
                    RoundedRectangle(
                        cornerRadius: cornerRadius,
                        style: .continuous
                    )
                    .fill(configuration.selectedSegmentColor)
                    .matchedGeometryEffect(
                        id: selectedSegment.rawValue,
                        in: segmentedControl,
                        isSource: false
                    )
                )
                .padding(configuration.padding)
                .background(configuration.backgroundColor)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: cornerRadius + configuration.padding,
                        style: .continuous
                    )
                )
                .buttonStyle(.plain)
            }
            else if case .capsule = configuration.shape {
                view.background(
                    Capsule()
                        .fill(configuration.selectedSegmentColor)
                        .matchedGeometryEffect(
                            id: selectedSegment.rawValue,
                            in: segmentedControl,
                            isSource: false
                        )
                )
                .padding(configuration.padding)
                .background(configuration.backgroundColor)
                .clipShape(
                    Capsule()
                )
                .buttonStyle(.plain)
            }
        }
    }
}
