//
//  ProfileHost.swift
//  Landmarks
//
//  Created by clarknt on 2019-08-22.
//  Copyright © 2019 Apple. All rights reserved.
//

import SwiftUI

struct ProfileHost: View {
    @Environment(\.editMode) var mode
    @State var profile = Profile.default
    @State var draftProfile = Profile.default

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                if self.mode?.wrappedValue == .active {
                    Button(action: {
                        self.draftProfile = self.profile // correct edit button behaviour
                        self.mode?.animation().wrappedValue = .inactive
                    }) {
                        Text("Cancel")
                    }
                }

                Spacer()
                
                EditButton()
            }
            if self.mode?.wrappedValue == .inactive {
                ProfileSummary(profile: profile)
            } else {
                ProfileEditor(profile: $draftProfile)
                    .onDisappear {
                        self.profile = self.draftProfile // correct edit button behaviour
                }
            }
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
    }
}
