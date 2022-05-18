//
//  ReminderView.swift
//  Increment
//
//  Created by Uzair Mughal on 03/09/2021.
//

import SwiftUI

struct ReminderView: View {
    var body: some View {
        VStack {
            Button(action: { }, label: {
                Text("Create")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
            })
            .padding(.bottom, 15)
            Button(action: { }, label: {
                Text("Skip")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
            })
        }
        .navigationTitle("Remind")
        .padding(.bottom, 15)
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReminderView()
        }
    }
}
