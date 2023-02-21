//
//  String+Ext.swift
//  StoreApp
//
//  Created by Felipe Lima on 18/02/23.
//

import Foundation

extension String {
    var isNumeric: Bool {
        Double(self) != nil
    }
}
