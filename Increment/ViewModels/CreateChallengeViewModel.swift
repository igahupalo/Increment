//
//  CreateChallengeViewModel.swift
//  Increment
//
//  Created by Iga Hupalo on 17/11/2022.
//

import SwiftUI

final class CreateChallengeViewModel: ObservableObject {
    let title = "Create"

    @Published var dropdowns: [DropdownViewModel] = [
        DropdownViewModel(type: .excercise),
        DropdownViewModel(type: .startNumber),
        DropdownViewModel(type: .increase),
        DropdownViewModel(type: .length)
    ]

    enum Action {
        case selectOption(index: Int)
    }

    var hasFocusedDropdown: Bool {
        focusedDropdownIndex != nil
    }

    var focusedDropdownIndex: Int? {
        dropdowns.enumerated().first(where: { $0.element.isFocused })?.offset
    }

    var focusedDropdownOptions: [DropdownOption] {
        guard let selectedDropdownIndex = focusedDropdownIndex else { return [] }
        return dropdowns[selectedDropdownIndex].options
    }

    func send(_ action: Action) {
        switch action {
        case let .selectOption(index):
            guard let selectedDropdownIndex = focusedDropdownIndex else { return }
            clearSelectedOption()
            dropdowns[selectedDropdownIndex].options[index].isSelected = true
            clearSelectedDropdown()
        }
    }

    private func clearSelectedOption() {
        guard let selectedDropdownIndex = focusedDropdownIndex else { return }
        dropdowns[selectedDropdownIndex].options.indices.forEach { index in
            dropdowns[selectedDropdownIndex].options[index].isSelected = false
        }
    }

    private func clearSelectedDropdown() {
        guard let selectedDropdownIndex = focusedDropdownIndex else { return }
        dropdowns[selectedDropdownIndex].isFocused = false

    }
}

extension CreateChallengeViewModel {
    struct DropdownViewModel: DropdownProtocol {

        var options: [DropdownOption]

        var headerTitle: String {
            type.rawValue
        }

        var dropdownTitle: String {
            options.first(where: { $0.isSelected })?.formattedValue ?? ""
        }

        var isFocused: Bool = false

        private let type: DropdownType

        init(type: DropdownType) {
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

        enum DropdownType: String, CaseIterable {
            case excercise = "Excercise"
            case startNumber = "Starting Number"
            case increase = "Daily Increase"
            case length = "Challenge Length"
        }

        enum ExcerciseOption: String, CaseIterable, DropdownOptionProtocol {
            case pullups, pushups, situps

            var toDropdownOption: DropdownOption {
                DropdownOption(type: .text(rawValue),
                               formattedValue: rawValue.capitalized,
                               isSelected: self == .pullups)
            }
        }

        enum StartOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five

            var toDropdownOption: DropdownOption {
                DropdownOption(type: .number(rawValue),
                               formattedValue: "\(rawValue)",
                               isSelected: self == .one)
            }
        }

        enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five

            var toDropdownOption: DropdownOption {
                DropdownOption(type: .number(rawValue),
                               formattedValue: "+\(rawValue)",
                               isSelected: self == .one)
            }
        }

        enum LenghtOption: Int, CaseIterable, DropdownOptionProtocol {
            case seven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28

            var toDropdownOption: DropdownOption {
                DropdownOption(type: .number(rawValue),
                               formattedValue: "\(rawValue) days",
                               isSelected: self == .seven)
            }
        }
    }
}
