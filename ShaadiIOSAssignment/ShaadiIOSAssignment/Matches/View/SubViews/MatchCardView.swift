//
//  MatchCardView.swift
//  ShaadiIOSAssignment
//
//  Created by Mahesh G C on 19/10/24.
//

import SwiftUI

struct MatchCardView: View {
    let match: Match
    var acceptAction: () -> Void
    var declineAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            AsyncImage(url: URL(string: match.photo)) { image in
                image.resizable().aspectRatio(contentMode: .fill)
            } placeholder: {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(match.name).font(.headline)
                Text("\(match.age) years old").font(.subheadline)
                Text(match.location).font(.subheadline)
                Text(match.bio).font(.body)
            }
            
            if match.status == MatchStatus.pending.rawValue {
                HStack {
                    Button(action: acceptAction) {
                        Text("Accept")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                    }
                    Button(action: declineAction) {
                        Text("Decline")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                    }
                }
            } else {
                let status = match.status ?? ""
                Text(status)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(status == MatchStatus.accepted.rawValue ? Color.green : Color.red)
                    .foregroundColor(.white).cornerRadius(16)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 1))
        .padding([.horizontal, .top])
    }
}

