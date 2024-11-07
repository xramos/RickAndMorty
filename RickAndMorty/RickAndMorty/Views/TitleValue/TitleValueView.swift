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

struct TitleValueViews_ColorScheme_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ForEach(ColorScheme.allCases, id: \.self) {
            
            TitleValueView(title: "Gender",
                           value: "Unknown")
            .preferredColorScheme($0)
        }
    }
}

struct TitleValueView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    
    static var snapshots: PreviewSnapshots<String> {
        
        PreviewSnapshots(configurations: [
            .init(name: "Default", state: "")
        ], configure: { state in
            
            TitleValueView(title: "Gender",
                           value: "Unknown")
        })
    }
}
