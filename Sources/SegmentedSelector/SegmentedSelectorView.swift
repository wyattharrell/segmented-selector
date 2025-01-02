//
//  SegmentedSelector.swift
//  SegmentedSelector
//
//  Created by Wyatt Harrell on 12/17/24.
//

import SwiftUI

public struct SegmentedSelector<Data, Selection>: View where Data: RandomAccessCollection, Data.Element == Selection, Selection: Identifiable & SegmentSelectable {

    @Namespace
    private var segmentedControl

    @Binding
    private var selectedSegment: Selection
    private var dataSource: Data
    private var configuration: SegmentedSelectorConfiguration

    public init(
        _ dataSource: Data,
        selectedSegment: Binding<Selection>,
        configuration: SegmentedSelectorConfiguration = SegmentedSelectorConfiguration()
    ) {
        self.dataSource = dataSource
        self._selectedSegment = selectedSegment
        self.configuration = configuration
    }

    public var body: some View {
        HStack {
            ForEach(dataSource, id: \.id) { segment in
                Button {
                    withAnimation(configuration.animation) {
                        selectedSegment = segment
                    }
                } label: {
                    Text(segment.title)
                        .font(configuration.font)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .matchedGeometryEffect(
                    id: segment.title,
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
                        id: selectedSegment.title,
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
                            id: selectedSegment.title,
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
