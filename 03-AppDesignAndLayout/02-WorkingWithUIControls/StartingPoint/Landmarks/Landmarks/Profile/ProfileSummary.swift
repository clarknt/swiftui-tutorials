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
        List {
            Text(profile.username)
                .bold()
                .font(.title)
            
            Text("Notifications: \(self.profile.prefersNotifications ? "On": "Off" )")
            
            Text("Seasonal Photos: \(self.profile.seasonalPhoto.rawValue)")
            
            Text("Goal Date: \(self.profile.goalDate, formatter: Self.goalFormat)")
            
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
            }

            VStack(alignment: .leading) {
                Text("Recent Hikes")
                    .font(.headline)
            
                // Within a List (top element in the body) like in the turorial,
                // Heart Rate and Pace buttons don't work (clicking anywhere
                // has the same effect as the toggle button).
                // In a ScrollView + VStack instead of the list, they work
                // (but then the layout is different).
                // The toggle button color is also off.
                HikeView(hike: hikeData[0])
            }
            // turn off animation for the title or it goes over the other elements
            .animation(nil)
        }
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(profile: Profile.default)
    }
}
