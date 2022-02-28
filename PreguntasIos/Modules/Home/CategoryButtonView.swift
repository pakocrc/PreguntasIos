//
//  CategoryButtonView.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 27/2/22.
//

import SwiftUI

struct CategoryButtonView: View {
    var category: String
    var action: () -> Void

    var body: some View {
        Button(NSLocalizedString("category_\(category.lowercased())", comment: ""), action: action)
            .font(Font.body)
            .foregroundColor(Color.primary)
            .padding()
            .frame(width: UIScreen.main.bounds.width - 20, height: 150, alignment: .center)
            .background(Color.secondary)
            .cornerRadius(10)
    }
}

struct CategoryButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryButtonView(category: QuestionCategory.friends.rawValue, action: { })
    }
}
