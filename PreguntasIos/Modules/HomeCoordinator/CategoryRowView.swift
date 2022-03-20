//
//  CategoryRowView.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 19/3/22.
//

import SwiftUI

struct CategoryRowView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var buttonTitle: String

    var body: some View {
        VStack {
            Text(buttonTitle)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, 40)
        .padding(2)
        .background(colorScheme == .light ? uiElementLightColor : Color.secondary)
        .cornerRadius(5)
        .shadow(color: colorScheme == .light ? Color.primary : .clear,
                radius: colorScheme == .light ? 5.0 : 0.0,
                x: 0.5,
                y: 0.5)
    }
}

struct CategoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoryRowView(buttonTitle: "Friends")
            CategoryRowView(buttonTitle: "Friends")
                .preferredColorScheme(.dark)
        }
    }
}
