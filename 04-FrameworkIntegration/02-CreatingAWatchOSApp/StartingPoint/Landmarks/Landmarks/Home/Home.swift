//
//  CategoryHome.swift
//  Landmarks
//
//  Created by clarknt on 2019-08-20.
//  Copyright © 2019 Apple. All rights reserved.
//

import SwiftUI

struct CategoryHome: View {
    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarkData,
            by: { $0.category.rawValue }
        )
    }

    var featured: [Landmark] {
        landmarkData.filter { $0.isFeatured }
    }

    @State var showingProfile = false
    @EnvironmentObject var userData: UserData

    var profileButton: some View {
        Button(action: { self.showingProfile.toggle() }) {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }

    var body: some View {
        NavigationView {
            List {
                FeaturedLandmarks(landmarks: featured)
                    .aspectRatio(3/2, contentMode: .fill)
                    .frame(height: 200, alignment: .bottom)
                    .clipped()
                    .listRowInsets(EdgeInsets())

                ForEach(categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: self.categories[key]!)
                }
                .listRowInsets(EdgeInsets())

                NavigationLink(destination: LandmarkList { LandmarkDetail(landmark: $0) }) {
                    Text("See All")
                }
            }
            .navigationBarTitle(Text("Featured"))
            .navigationBarItems(trailing: profileButton)
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
                    .environmentObject(self.userData)
            }
        }
    }
}

struct FeaturedLandmarks: View {
    var landmarks: [Landmark]

    @State private var navigateToFeature = false
    @State private var currentFeaturedLandmark: Landmark?

    var body: some View {
        // use a ZStack to hide the navigation arrow
        ZStack {
            NavigationLink(destination: LandmarkDetail(landmark: currentFeaturedLandmark ?? landmarks[0]), isActive: $navigateToFeature) {
                EmptyView()
            }

            PageView(
                features.map { landmark in
                    FeatureCard(landmark: landmark)
                        .onTapGesture {
                            self.currentFeaturedLandmark = landmark
                            self.navigateToFeature.toggle()
                    }
                }
            )
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
    }
}
