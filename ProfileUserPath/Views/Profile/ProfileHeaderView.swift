//
//  ProfileHeaderView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/5/22.
//

import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        VStack {
            Image("batman")
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .shadow(color: .black, radius: 3, x:0.0, y:0.0)
            
            Text("Matthew Molinar")
                .font(.system(size: 16, weight: .semibold))
                .padding(.top, 8)
            
            Text("Description")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack(spacing: 40) {
                Text("19")
                Text("Freshman")
                Text("UT-Austin")
            }.padding()
            
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView()
    }
}
