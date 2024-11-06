//
//  TitleValueView.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import SwiftUI

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
                .font(.caption)
            
            Spacer()
            
            Text(value)
                .font(.caption2)
        }
    }
}

// MARK: - Previews

struct TitleValueView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        TitleValueView(title: "Gender",
                       value: "Unknown")
    }
}
