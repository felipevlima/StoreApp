//
//  Double+Ext.swift
//  StoreApp
//
//  Created by Felipe Lima on 21/02/23.
//

import Foundation

extension Double {
    func formatAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self)) ?? "0.00"
    }
}
