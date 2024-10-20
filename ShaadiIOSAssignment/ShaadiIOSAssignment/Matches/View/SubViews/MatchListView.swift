//
//  MatchListView.swift
//  ShaadiIOSAssignment
//
//  Created by Mahesh G C on 19/10/24.
//

import SwiftUI

struct MatchListView: View {
    let matches: [Match]
    @EnvironmentObject var viewModel: MatchViewModel
    
    var body: some View {
        if matches.isEmpty {
            Text("No matches found")
                .foregroundColor(.gray)
        } else {
            ScrollView {
                VStack {
                    ForEach(matches) { match in
                        MatchCardView(match: match,
                                      acceptAction: {
                            viewModel.upadteMatchStatus(match: match, status: MatchStatus.accepted)
                        },
                                      declineAction: {
                            viewModel.upadteMatchStatus(match: match, status: MatchStatus.rejected)
                        })
                    }
                }
            }
        }
    }
}
