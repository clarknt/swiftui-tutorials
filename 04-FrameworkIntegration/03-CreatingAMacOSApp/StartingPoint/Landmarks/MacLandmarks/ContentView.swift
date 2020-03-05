//
//  ContentView.swift
//  MacLandmarks
//
//  Created by clarknt on 2020-03-04.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedLandmark: Landmark?

    var body: some View {
        NavigationView {
            NavigationMaster(selectedLandmark: $selectedLandmark)

            if selectedLandmark != nil {
                NavigationDetail(landmark: selectedLandmark!)
            }
        }
        .frame(minWidth: 700, minHeight: 300)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserData())
    }
}
