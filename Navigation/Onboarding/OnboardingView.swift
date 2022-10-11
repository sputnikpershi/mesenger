//
//  OnboardingView.swift
//  Navigation
//
//  Created by Kiryl Rakk on 11/10/22.
//

import UIKit
import SwiftUI

struct OnboardingView: View {
    var doneRequested: () -> ()
    var body: some View {
        TabView {
            ScaledImageView(name: "dog")
            ScaledImageView(name: "cat")
                .tag(1)
            ScaledImageView(name: "bug")
                .tag(2)
            Button("done") {
                doneRequested()           }
        }
        .tabViewStyle(PageTabViewStyle())
        .background(Color.black)
        .ignoresSafeArea(.all )
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView (doneRequested: {})
    }
}

struct ScaledImageView: View {
    let name: String
    var body: some View {
        Image(name)
            .resizable()
            .scaledToFit()
    }
}
