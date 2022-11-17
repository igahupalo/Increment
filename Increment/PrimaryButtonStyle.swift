//
//  PrimaryButtonStyle.swift
//  Increment
//
//  Created by Iga Hupalo on 17/11/2022.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    var fillColor: Color = .primaryButton

    func makeBody(configuration: Configuration) -> some View {
        return PrimaryButton(configuration: configuration, fillColor: fillColor)
    }

    struct PrimaryButton: View {
        let configuration: Configuration
        let fillColor: Color

        var body: some View {
            return configuration.label
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(fillColor)
                )
        }
    }
}


struct Previews_PrimaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}) {
            Text("Button")
        }.buttonStyle(PrimaryButtonStyle())
    }
}
