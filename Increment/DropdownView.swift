//
//  DropdownView.swift
//  Increment
//
//  Created by Iga Hupalo on 17/11/2022.
//

import SwiftUI

struct DropdownView<T: DropdownProtocol>: View {
    @Binding var viewModel: T
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.headerTitle)
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
            }.padding(.vertical, 10)

            Button(action: {
                viewModel.isFocused = true
            }) {
                HStack {
                    Text(viewModel.dropdownTitle)
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 24, weight: .medium))

                }
            }.buttonStyle(PrimaryButtonStyle())
        }.padding(15)
    }
}

//struct DropdownView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            DropdownView()
//        }
//
//        NavigationView {
//            DropdownView()
//        }.environment(\.colorScheme, .dark)
//    }
//}
