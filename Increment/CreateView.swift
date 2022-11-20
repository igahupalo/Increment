//
//  CreateView.swift
//  Increment
//
//  Created by Iga Hupalo on 17/11/2022.
//

import SwiftUI

struct CreateView: View {
    @StateObject  var viewModel = CreateChallengeViewModel()
    @State private var isActive = false

    var dropdownList: some View {
        ForEach(viewModel.dropdowns.indices, id: \.self) { index in
            DropdownView(viewModel: $viewModel.dropdowns[index])
        }
    }

    var actionSheet: ActionSheet {
        ActionSheet(title: Text("Select"), buttons: viewModel.focusedDropdownOptions.indices.map { index in
            let option = viewModel.focusedDropdownOptions[index]
            return .default(Text(option.formattedValue)) {
                viewModel.send(.selectOption(index: index))
            }
        })
    }

    var body: some View {
        ScrollView {
            VStack {
                dropdownList
                Spacer()
                NavigationLink(destination: RemindView(), isActive: $isActive) {
                    Button(action: {
                        isActive = true
                    }) {
                        Text("Next")
                            .font(.system(size: 24, weight: .medium))
                    }
                }
            }
            .actionSheet(isPresented: Binding<Bool>(
                get: {
                    viewModel.hasFocusedDropdown
                },
                set: { _ in }), content: { () -> ActionSheet in
                    actionSheet
                })
            .navigationBarTitle(viewModel.title)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.large)
            .padding(.bottom, 15)
        }
    }
}

struct Previews_CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
