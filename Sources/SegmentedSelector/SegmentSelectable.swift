//
//  SegmentSelectable.swift
//  SegmentedSelector
//
//  Created by Wyatt Harrell on 1/1/25.
//

import Foundation

public protocol SegmentSelectable: Identifiable where ID: Hashable {
    var title: String { get }
    var id: ID { get }
}
