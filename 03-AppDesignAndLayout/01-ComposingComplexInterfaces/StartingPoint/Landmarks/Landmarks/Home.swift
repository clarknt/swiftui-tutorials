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
            // tutorial has a List, but it breaks the inner NavigationLink in CategoryRow
            // replace List with ScrollView, VStack, Divider, padding, row simulation
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    FeaturedLandmarks(landmarks: featured)
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                        // .listRowInsets(EdgeInsets())
                    
                    ForEach(categories.keys.sorted(), id: \.self) { key in
                        VStack {
                            CategoryRow(categoryName: key, items: self.categories[key]!)
                            
                            Divider()
                                .padding(.leading, 15)
                        }
                    }
                    //.listRowInsets(EdgeInsets())

                    NavigationLink(destination: LandmarkList()) {
                        // simulate list row
                        HStack {
                            Text("See All")
                            .padding(.leading, 15)
                            .foregroundColor(.primary)

                            Spacer()
                            
                            // don't bother with correct color, scale or weight
                            // just wait for NavigationLink to work correctly within List
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.trailing, 15)
                        }
                        
                    }

                    Divider()
                        .padding(.leading, 15)
                }
                .navigationBarTitle(Text("Featured"))
                .navigationBarItems(trailing: profileButton)
            }
            // move out of scrollview else the sheet shows once only
            // when in ScrollView + VStack (worked fine with List)
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
