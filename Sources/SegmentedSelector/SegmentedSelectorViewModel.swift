//
//  SegmentedSelectorViewModel.swift
//  SegmentedSelector
//
//  Created by Wyatt Harrell on 12/17/24.
//

import Foundation

public protocol SegmentedSelectorViewModel {
    associatedtype T: CRI where T.RawValue == String, T.AllCases: RandomAccessCollection

    var viewState: SegmentedSelectorViewState<T> { get }

    func selectionChanged()
}
