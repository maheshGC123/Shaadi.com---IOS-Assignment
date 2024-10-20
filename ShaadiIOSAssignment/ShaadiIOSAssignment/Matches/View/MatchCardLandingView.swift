//
//  MatchCardLandingView.swift
//  ShaadiIOSAssignment
//
//  Created by Mahesh G C on 18/10/24.
//


import SwiftUI


struct MatchCardLandingView: View {
    @StateObject var viewModel = MatchViewModel(dataSource: DataSource())
    
    var body: some View {
        NavigationView {
            ZStack {
                TabView {
                    MatchListView(matches: viewModel.newMatches)
                        .tabItem {
                            Label("New Matches", systemImage: "star")
                        }
                        .environmentObject(viewModel)
                    MatchListView(matches: viewModel.descionMatches)
                        .tabItem {
                            Label("Your Decisions", systemImage: "checkmark.circle")
                        }
                        .environmentObject(viewModel)
                }
                
                if viewModel.showLoader {
                    ProgressView()
                }
                
                if  viewModel.showErrorView {
                    VStack {
                        Text("Oops something went wrong!")
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Button(action: {
                            viewModel.fetchMatches() // Retry fetching matches
                        }) {
                            Text("Try Again")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchMatches()
            }
        }
    }
}

