//
//  MagicGradientText.swift
//  StudyZen
//
//  Created by SINDHYA ANOOP on 3/2/26.
//
import SwiftUI

struct MagicalGradientText: View {

    let text: String
    @State private var animate = false

    var body: some View {

        Text(text)
            .font(.system(size: 22, weight: .semibold, design: .serif)) // larger font
            .foregroundStyle(
                LinearGradient(
                    colors: [
                        Color.blue,
                        Color.teal,
                        Color.green,
                        Color.teal,
                        Color.blue
                    ],
                    startPoint: animate ? .leading : .trailing,
                    endPoint: animate ? .trailing : .leading
                )
            )
            .shadow(color: Color.teal.opacity(0.6), radius: 6)
            .animation(
                .linear(duration: 3)
                .repeatForever(autoreverses: true),
                value: animate
            )
            .onAppear {
                animate = true
            }
    }
}

#Preview {
    MagicalGradientText()
}
