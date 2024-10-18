//
//  MatchCardView.swift
//  ShaadiIOSAssignment
//
//  Created by Mahesh G C on 18/10/24.
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
                ProgressView()
            }
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
            Text(match.name).font(.headline)
            Text("\(match.age) years old").font(.subheadline)
            Text(match.location).font(.subheadline)
            Text(match.bio).font(.body)
            
            HStack {
                Button(action: acceptAction) {
                    Text("Accept").frame(maxWidth: .infinity).padding().background(Color.green).foregroundColor(.white).cornerRadius(10)
                }
                Button(action: declineAction) {
                    Text("Decline").frame(maxWidth: .infinity).padding().background(Color.red).foregroundColor(.white).cornerRadius(10)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 1))
        .padding([.horizontal, .top])
    }
}

struct MatchCardLandingView: View {
    @StateObject var viewModel = MatchViewModel(dataSource: DataSource()) // Switch to CoreDataService() for offline mode
    
    var body: some View {
        NavigationView {
            List(viewModel.matches) { match in
                MatchCardView(match: match,
                    acceptAction: {
                        viewModel.acceptMatch(match: match)
                    },
                    declineAction: {
                        viewModel.declineMatch(match: match)
                    }
                )
            }
            .onAppear {
                viewModel.fetchMatches()
                viewModel.loadDecisions()
            }
            .navigationTitle("Matrimonial Matches")
        }
    }
}
