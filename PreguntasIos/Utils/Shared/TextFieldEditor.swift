//
//  TextFieldEditor.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 19/3/22.
//

import SwiftUI

struct TextFieldEditor: View {
    @Environment(\.colorScheme) private var colorScheme

    @Binding var textValue: String
    @State private var textEditorHeight: CGFloat = 50.0

    private let textFieldLightColor = Color(
        red: 239.0/255.0,
        green: 243.0/255.0,
        blue: 244.0/255.0,
        opacity: 1.0)

    var body: some View {
        TextEditor(text: $textValue)
            .multilineTextAlignment(.leading)
            .frame(height: textEditorHeight, alignment: .center)
            .foregroundColor(colorScheme == .light ? Color.black : Color.primary)
            .padding(2)
            .background(colorScheme == .light ? textFieldLightColor : Color.secondary)
            .cornerRadius(5)
            .padding(.horizontal)
            .onChange(of: textValue) { newValue in
                setHeight(newValue)
            }
    }

    private func setHeight(_ newText: String) {
        switch newText.split(separator: " ").count {
        case 0...5:
            textEditorHeight = 50.0
        case 6...10:
            textEditorHeight = 75.0
        case 11...21:
            textEditorHeight = 100.0
        case 22...30:
            textEditorHeight = 125.0
        default:
            textEditorHeight = 150.0
        }
    }
}

struct TextFieldEditor_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextFieldEditor(textValue: Binding<String>.constant(""))
            TextFieldEditor(textValue: Binding<String>.constant(""))
                .preferredColorScheme(.dark)
        }
    }
}
