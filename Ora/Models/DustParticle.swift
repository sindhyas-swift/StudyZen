//
//  ParticleModel.swift
//  StudyZen
//
//  Created by SINDHYA ANOOP on 3/2/26.
//

import Foundation

struct DustParticle: Identifiable,Equatable {
    let id = UUID()
    var position: CGPoint
    var size: CGFloat
    var opacity: Double
}
