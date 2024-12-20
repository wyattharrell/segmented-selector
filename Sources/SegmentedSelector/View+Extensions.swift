//
//  View+Extensions.swift
//  SegmentedSelector
//
//  Created by Wyatt Harrell on 12/18/24.
//

import SwiftUI

extension View {
    func conditionallyApply<V: View>(@ViewBuilder _ block: (Self) -> V) -> V { block(self) }
}
