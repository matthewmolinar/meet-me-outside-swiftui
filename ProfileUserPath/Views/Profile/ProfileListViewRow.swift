//
//  ProfileListViewRow.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/5/22.
//

import SwiftUI

struct ProfileListViewRow: View {
    let event: Event
    @Binding var formType: EventFormType?
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(event.eventType.icon)
                        .font(.system(size: 40))
                    Text(event.note)
                }
                Text(
                    event.date.formatted(date: .abbreviated,
                                         time: .shortened)
                )
                Divider()

            }
            Spacer()
        }
    }
}

