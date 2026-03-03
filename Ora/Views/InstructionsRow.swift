//
//  InstructionsRow.swift
//  StudyZen
//
//  Created by SINDHYA ANOOP on 2/5/26.
//

import SwiftUI

struct InstructionRow: View {
    var text: String
    let isActive: Bool

    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .font(.body.weight(.bold))
            .lineLimit(nil)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, 24)    // Inner capsule padding
            .padding(.vertical, 12)
            .background(
                Capsule()
                    .fill(isActive ? Color.white.opacity(0.35) : Color.white.opacity(0.15))
            )
            .overlay(
                Capsule()
                    .stroke(Color.white.opacity(isActive ? 0.5 : 0.25), lineWidth: 1)
            )
            .padding(.horizontal, 12)    // Outer spacing
            .frame(maxWidth: .infinity, alignment: .center)
            .scaleEffect(isActive ? 1.05 : 1.0) // subtle grow when active
                        .animation(.easeInOut(duration: 0.3), value: isActive)    }
}

#Preview {
    InstructionRow(text: "Slowly exhale through your mouth until your lungs feel empty", isActive: true)
}
