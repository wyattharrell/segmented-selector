//
//  SegmentedSelector.swift
//  SegmentedSelector
//
//  Created by Wyatt Harrell on 12/17/24.
//

import SwiftUI

public struct SegmentedSelector<ViewModel: SegmentedSelectorViewModel>: View {

    @Namespace
    private var segmentedControl
    private let viewModel: ViewModel

    @ObservedObject
    var viewState: SegmentedSelectorViewState<ViewModel.T>

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.viewState = viewModel.viewState
    }

    public var body: some View {
        HStack {
            ForEach(ViewModel.T.allCases, id: \.id) { segment in
                Button {
                    withAnimation(viewState.animation) {
                        viewState.selectedSegment = segment
                    }

                    viewModel.selectionChanged()
                } label: {
                    Text(segment.rawValue)
                        .font(viewState.font)
                        .multilineTextAlignment(.center)
                        .padding(10)
                }
                .matchedGeometryEffect(
                    id: segment.rawValue,
                    in: segmentedControl
                )
            }
        }
        .conditionallyApply { view in
            if case .roundedRectangle(let cornerRadius) = viewState.shape {
                view.background(
                    RoundedRectangle(
                        cornerRadius: cornerRadius,
                        style: .continuous
                    )
                    .fill(viewState.selectedSegmentColor)
                    .matchedGeometryEffect(
                        id: viewState.selectedSegment.rawValue,
                        in: segmentedControl,
                        isSource: false
                    )
                )
                .padding(viewState.padding)
                .background(viewState.backgroundColor)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: cornerRadius + viewState.padding,
                        style: .continuous
                    )
                )
                .buttonStyle(.plain)
            }
            else if case .capsule = viewState.shape {
                view.background(
                    Capsule()
                        .fill(viewState.selectedSegmentColor)
                        .matchedGeometryEffect(
                            id: viewState.selectedSegment.rawValue,
                            in: segmentedControl,
                            isSource: false
                        )
                )
                .padding(viewState.padding)
                .background(viewState.backgroundColor)
                .clipShape(
                    Capsule()
                )
                .buttonStyle(.plain)
            }
        }
    }
}

enum ExampleEnum: String, CaseIterable, Identifiable {
    var id: Self { self }

    case option1 = "Option 1"
    case option2 = "Option 2"
    case option3 = "Option 3"
}


class TestViewModel: SegmentedSelectorViewModel {
    init(viewState: SegmentedSelectorViewState<ExampleEnum>) {
        self.viewState = viewState
    }

    var viewState: SegmentedSelectorViewState<ExampleEnum>

    func selectionChanged() {
        print("Changed")
    }
}

@MainActor let a = TestViewModel(
    viewState: SegmentedSelectorViewState(selectedSegment: .option1)
)

#Preview {




    SegmentedSelector(viewModel: a)
}
