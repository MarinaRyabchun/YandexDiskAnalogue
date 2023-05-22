//
//  ExtensionInt.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 13.04.2023.
//

import Foundation

extension Int {
    
    func formatterForSizeCharts () -> Double {
        var number: Double
        if self >= 1024 {
            number = Double((Double(self)/1024)/1024)
            return number
        }
        return Double(self)
    }
    
    func formatterForSizeValueFile () -> String  {
            switch self {
            case ...1023:
                return "\(self) \(Constants.TextProfile.profileLabelBt)"
            case 1024...1048575:
                let text = Double(Double(self)/1024)
                return "\((String(format: "%.0f", text))) \(Constants.TextProfile.profileLabelKb)"
            case 1048576...1073741823:
                let text = Double((Double(self)/1024)/1024)
                return "\((String(format: "%.0f", text))) \(Constants.TextProfile.profileLabelMb)"
            case 1073741824...:
                let text = Double(Double((Double(self)/1024)/1024)/1024)
                return "\((String(format: "%.0f", text))) \(Constants.TextProfile.profileLabelGb)"
            default: print ("\(self) вне диапазона")
                break
            }
        return "\(self) \(Constants.TextProfile.profileLabelBt)"
    }
}
