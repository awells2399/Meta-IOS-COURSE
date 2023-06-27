//
//  UserProfile.swift
//  Little Lemon IOS
//
//  Created by Aaron Wells on 6/26/23.
//

import SwiftUI

struct UserProfile: View {
    let fistName = UserDefaults.standard.string(forKey: kFirstName)
    let lastName = UserDefaults.standard.string(forKey: kLastName)
    let email = UserDefaults.standard.string(forKey: kEmail)

    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack {
            Text("Personal Information")
            Image("profile-image-placeholder")

            Text("First Name: \(fistName ?? "")")
            Text("Last Name: \(lastName ?? "")")
            Text("Email: \(email ?? "")")

            Button("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }.buttonStyle(ButtonStyleYellowColorWide())
            Spacer()
        }.padding()
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
