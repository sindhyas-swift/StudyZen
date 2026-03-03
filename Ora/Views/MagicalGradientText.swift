//
//  MagicGradientText.swift
//  StudyZen
//
//  Created by SINDHYA ANOOP on 3/2/26.
//
import SwiftUI

import SwiftUI

struct MagicalGradientText: View {

    let text: String
    @State private var animate = false

    var body: some View {

        Text(text)
        
            .bold()
            .padding()
            .frame(width: .infinity)
           // .multilineTextAlignment(.center)
            .background(Color.white.opacity(0.2))
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(radius: 5)
            //.shadow(color: Color.white.opacity(0.7), radius: 8)
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
    MagicalGradientText(text: "Release Thoughts")
}
