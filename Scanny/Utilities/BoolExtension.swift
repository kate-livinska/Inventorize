//
//  BoolExtension.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 28/04/2024.
//

import Foundation

extension Bool: Comparable {
    public static func <(lhs: Self, rhs: Self) -> Bool {
        // the only true inequality is false < true
        !lhs && rhs
    }
}
