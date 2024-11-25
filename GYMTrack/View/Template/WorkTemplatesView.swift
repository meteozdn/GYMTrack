//
//  WorkTemplates.swift
//  GYMTrack
//
//  Created by Metehan Özden on 21.11.2024.
//

import SwiftUI

struct WorkTemplatesView: View {
    @State var addTemplateSheet: Bool = false
    var body: some View {
        NavigationStack {
            VStack{
                
            }
            .navigationTitle("Work Templates")
            .vSpacing(.top)
            .overlay(alignment: .bottom, content: {
                Button {
                    print("kenan ability")
                    addTemplateSheet.toggle()
                } label: {
                    HStack {
                        Text("Add Work Template")
                            .font(.headline)
                            .foregroundStyle(.projectWhite)
                            .frame(width: 200)
                        Image(systemName: "plus")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 55, height: 55)
                    } .background(.projectRed.shadow(.drop(radius: 10, x: 5, y: 10)), in: .capsule)
                }
                .offset(y:-15)
                
            })
        }
    }
}

#Preview {
    WorkTemplatesView()
}
