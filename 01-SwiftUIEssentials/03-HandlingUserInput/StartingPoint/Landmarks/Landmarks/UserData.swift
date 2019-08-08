//
//  UserData.swift
//  Landmarks
//
//  Created by clarknt on 2019-07-31.
//  Copyright © 2019 Apple. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
}
