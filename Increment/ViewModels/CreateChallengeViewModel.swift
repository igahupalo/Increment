//
//  CreateChallengeViewModel.swift
//  Increment
//
//  Created by Iga Hupalo on 17/11/2022.
//

import SwiftUI

final class CreateChallengeViewModel: ObservableObject {
    @Published var dropdowns: [ChallengePartViewModel] = [
        .init(type: .excercise),
        .init(type: .startNumber),
        .init(type: .increase),
        .init(type: .length)
    ]
}

extension CreateChallengeViewModel {
    struct ChallengePartViewModel: DropdownItemProtocol {

        var options: [DropdownOption]

        var headerTitle: String {
            type.rawValue
        }

        var dropdownTitle: String {
            options.first(where: { $0.isSelected })?.formattedValue ?? ""
        }

        var isSelected: Bool = false

        private let type: ChallengePartType

        init(type: ChallengePartType) {
            self.type = type

            switch type {
            case .excercise:
                self.options = ExcerciseOption.allCases.map { $0.toDropdownOption }
            case .startNumber:
                self.options = StartOption.allCases.map { $0.toDropdownOption }
            case .increase:
                self.options = IncreaseOption.allCases.map { $0.toDropdownOption }
            case .length:
                self.options = LenghtOption.allCases.map { $0.toDropdownOption }
            }
        }

        enum ChallengePartType: String, CaseIterable {
            case excercise = "Excercise"
            case startNumber = "Starting Number"
            case increase = "Daily Increase"
            case length = "Challenge Length"
        }

        enum ExcerciseOption: String, CaseIterable, DropdownOptionProtocol {
            case pullups, pushups, situps

            var toDropdownOption: DropdownOption {
                .init(type: .text(rawValue),
                      formattedValue: rawValue.capitalized,
                      isSelected: self == .pullups)
            }
        }

        enum StartOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five

            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue),
                      formattedValue: "\(rawValue)",
                      isSelected: self == .one)
            }
        }

        enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five

            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue),
                      formattedValue: "+\(rawValue)",
                      isSelected: self == .one)
            }
        }

        enum LenghtOption: Int, CaseIterable, DropdownOptionProtocol {
            case seven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28

            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue),
                      formattedValue: "\(rawValue) days",
                      isSelected: self == .seven)
            }
        }
    }
}
