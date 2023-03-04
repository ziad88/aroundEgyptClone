//
//  ExperienceScreen.swift
//  AroundEgypt_Clone
//
//  Created by Ziad Alfakharany on 04/03/2023.
//

import SwiftUI

struct ExperienceScreen: View {
    
    var pic: String = "imgNef"
    var title: String = "Nefertari Tomb (QV66)"
    var description: String = "The tomb of Queen Nefertari (QV 66), the favourite Great Royal Wife of King Ramses II (lifetime ca. 1303–1213 BC), was discovered by Ernesto Schiaparelli (1856–1928) in the Valley of the Queens in 1904. Her burial had been looted in antiquity, so no trace of the original entrance had been preserved.it is arguably the most beautiful and well preserved tomb in the Theban necropolis."
    
    @State var showSheet = true
    var body: some View {
        VStack(spacing: 0){
            
            AsyncImage(url: URL(string: pic))
                .fixedSize()
                .edgesIgnoringSafeArea(.all)
                .frame(width: 390, height: 300)
                .scaledToFill()
                .clipped()
            
            
            Text(title)
                .bold()
                .font(.system(size: 22))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            Divider()
                .padding(.bottom)
            
            Text("Description")
                .bold()
                .font(.system(size: 30))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            Text(description)
                .lineLimit(nil)
                .bold()
                .font(.system(size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
           Spacer()
        }
    }
       
}

struct ExperienceScreen_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceScreen()
    }
}
