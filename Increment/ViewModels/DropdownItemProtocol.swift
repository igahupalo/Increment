//
//  DropdownItemProtocol.swift
//  Increment
//
//  Created by Iga Hupalo on 17/11/2022.
//

import Foundation

protocol DropdownItemProtocol {
    var options: [DropdownOption] { get }
    var headerTitle: String { get }
    var dropdownTitle: String { get }
    var isSelected: Bool { get set }
}

protocol DropdownOptionProtocol {
    var toDropdownOption: DropdownOption { get }
}

struct DropdownOption {
    enum DropdownOptionType {
        case text(String)
        case number(Int)
    }

    let type: DropdownOptionType
    let formattedValue: String
    var isSelected: Bool
}
