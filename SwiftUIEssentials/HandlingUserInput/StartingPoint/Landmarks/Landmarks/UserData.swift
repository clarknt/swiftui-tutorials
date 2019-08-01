//
//  UserData.swift
//  Landmarks
//
//  Created by clarknt on 2019-07-31.
//  Copyright © 2019 Apple. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: BindableObject {
    let willChange = PassthroughSubject<Void, Never>()

    var showFavoritesOnly = false {
        willSet {
            willChange.send()
        }
    }
    
    var landmarks = landmarkData {
        willSet {
            willChange.send()
        }
    }
}
