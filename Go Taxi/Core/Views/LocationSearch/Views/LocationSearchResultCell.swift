//
//  LocationSearchResultCell.swift
//  Go Taxi
//
//  Created by apple on 10.08.2023.
//

import SwiftUI

struct LocationSearchResultCell: View {
    var body: some View {
        HStack {
           Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.white)
                .frame().frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Starbucks Coffee")
                    .font(.body)
                
                Text("123 Main St, Cupertino CA")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                
                Divider()
                    
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
        }
        .padding(.leading)
    }
}

struct LocationSearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResultCell()
    }
}
