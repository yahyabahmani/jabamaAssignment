//
//  ScoreView.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import SwiftUI

struct ScoreView: View {
    var score: Double
    init(score: Double) {
        
        if 0...5 ~= score {
            self.score = score
        } else {
           fatalError("Score must be between 0 and 5")
        }
    }
    var body: some View {
        HStack(spacing:0) {
            ForEach(0..<5) { index in
                Image(systemName: "star.fill")
                    .font(.caption)
                    .foregroundColor(index < Int(score) ? .yellow : .gray)
            }
        }
    }
}

#Preview {
    ScoreView(score: 0)
}
