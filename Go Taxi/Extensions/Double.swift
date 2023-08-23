//
//  Double.swift
//  Go Taxi
//
//  Created by apple on 23.08.2023.
//

import Foundation

extension Double {
    private var curencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func toCurrency() -> String {
        return curencyFormatter.string(for: self) ?? ""
    }
    
}
