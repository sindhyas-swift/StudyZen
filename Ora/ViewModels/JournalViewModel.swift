//
//  JournalViewModel.swift
//  StudyZen
//
//  Created by SINDHYA ANOOP on 2/25/26.
//

import Foundation
import Combine

class JournalViewModel:ObservableObject{
    
    @Published var activity: Activity
    
    init(activity: Activity) {
           self.activity = activity
       }
    
}
