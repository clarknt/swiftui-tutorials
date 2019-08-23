//
//  ProfileSummary.swift
//  Landmarks
//
//  Created by clarknt on 2019-08-22.
//  Copyright © 2019 Apple. All rights reserved.
//

import SwiftUI

struct ProfileSummary: View {
    var profile: Profile
    
    static var goalFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter
    }
    
    var body: some View {
        // List present in tutorial breaks the HikeView functionalities
        // like in Home, as a workaround, simulate a List with ScrollView + VStack
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading) {
                Text(profile.username)
                    .bold()
                    .font(.title)
                
                Divider()
                
                Text("Notifications: \(self.profile.prefersNotifications ? "On": "Off" )")
                
                Divider()

                Text("Seasonal Photos: \(self.profile.seasonalPhoto.rawValue)")
                
                Divider()

                Text("Goal Date: \(self.profile.goalDate, formatter: Self.goalFormat)")

                Divider()

                VStack(alignment: .leading) {
                    Text("Completed Badges")
                        .font(.headline)
                    ScrollView {
                        HStack {
                            HikeBadge(name: "First Hike")
                            
                            HikeBadge(name: "Earth Day")
                                .hueRotation(Angle(degrees: 90))
                            
                            
                            HikeBadge(name: "Tenth Hike")
                                .grayscale(0.5)
                                .hueRotation(Angle(degrees: 45))
                        }
                    }
                    .frame(height: 140)
                    
                    
                    Divider()
                }
                
                VStack(alignment: .leading) {
                    Text("Recent Hikes")
                        .font(.headline)
                    
                    // Within a List (top element in the body) like in the turorial,
                    // Heart Rate and Pace buttons don't work (clicking anywhere
                    // has the same effect as the toggle button).
                    // The toggle button color is also off.
                    // In a ScrollView + VStack instead of the list, they work.
                    HikeView(hike: hikeData[0])

                    Divider()
                }
            }
        }
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(profile: Profile.default)
    }
}
