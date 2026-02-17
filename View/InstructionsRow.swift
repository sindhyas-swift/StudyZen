//
//  InstructionsRow.swift
//  StudyZen
//
//  Created by SINDHYA ANOOP on 2/5/26.
//

import SwiftUI

struct InstructionRow: View {
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .font(.body.weight(.bold))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 24)    // Inner capsule padding
            .padding(.vertical, 12)
            .background(
                Capsule()
                    .fill(Color.white.opacity(0.15))
            )
            .overlay(
                Capsule()
                    .stroke(Color.white.opacity(0.25), lineWidth: 1)
            )
            .padding(.horizontal, 12)    // Outer spacing
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    InstructionRow(text: "Wake up and stretch gently")
}
