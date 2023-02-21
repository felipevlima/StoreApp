//
//  Locale+Ext.swift
//  StoreApp
//
//  Created by Felipe Lima on 17/02/23.
//

import Foundation

extension Locale {
    static var currencyCode: String {
        Locale.current.currency?.identifier ?? "USD"
    }
}
