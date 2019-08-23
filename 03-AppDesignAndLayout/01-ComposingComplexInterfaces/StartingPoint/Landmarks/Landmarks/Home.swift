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
            // tutorial has a List instead of ScrollView + VStack
            // but the List breaks the inner NavigationLink in CategoryRow
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    FeaturedLandmarks(landmarks: featured)
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                        .listRowInsets(EdgeInsets())
                        
                    ForEach(categories.keys.sorted(), id: \.self) { key in
                        CategoryRow(categoryName: key, items: self.categories[key]!)
                    }
                    .listRowInsets(EdgeInsets())
                    
                    NavigationLink(destination: LandmarkList()) {
                        Text("See All")
                    }
                }
                .navigationBarTitle(Text("Featured"))
                .navigationBarItems(trailing: profileButton)
            }
            // move out of scrollview else the sheet shows once only
            .sheet(isPresented: $showingProfile) {
                Text("User Profile")
            }
        }
    }
}

struct FeaturedLandmarks: View {
    var landmarks: [Landmark]
    var body: some View {
        NavigationLink(destination: LandmarkDetail(landmark: landmarks[0])) {
            landmarks[0].image
                .resizable()
                .renderingMode(.original)
        }
    }
}

#if DEBUG
struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
    }
}
#endif
