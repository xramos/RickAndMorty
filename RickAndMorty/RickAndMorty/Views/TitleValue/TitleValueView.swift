//
//  TitleValueView.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import SwiftUI
import PreviewSnapshots

struct TitleValueView: View {
    
    var title: String
    var value: String
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
    }
    
    var body: some View {
        
        HStack {
            
            Text(title)
                .font(.callout)
                .foregroundStyle(Color.primary)
            
            Spacer()
            
            Text(value)
                .font(.callout)
                .foregroundStyle(Color.secondary)
        }
    }
}

// MARK: - Previews

struct TitleValueView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    
    static var snapshots: PreviewSnapshots<ColorScheme> {
                
        PreviewSnapshots(configurations: [
            .init(name: "Light", state: .light),
            .init(name: "Dark", state: .dark)
        ], configure: { state in
            
            TitleValueView(title: "Gender",
                           value: "Unknown")
            .preferredColorScheme(state)
        })
    }
}
