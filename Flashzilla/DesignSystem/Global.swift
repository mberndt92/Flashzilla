//
//  Global.swift
//  LoanCalculator
//
//  Created by Maximilian Berndt on 2023/05/06.
//

import Foundation

let isDebugging = false

var currencyIdentifier: String {
    return Locale.current.currency?.identifier ?? "USD"
}

var currencySymbol: String {
    return Locale.current.currencySymbol ?? "$"
}

let currencyFormat: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.generatesDecimalNumbers = false
    return formatter
}()

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
