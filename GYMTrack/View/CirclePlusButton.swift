//
//  BottomCirclePlusButton.swift
//  GYMTrack
//
//  Created by Metehan Özden on 23.11.2024.
//

import SwiftUI

struct CirclePlusButton: View {
    @Binding var boolControl: Bool
    var body: some View {
        Button {
            boolControl.toggle()
        } label: {
            Image(systemName: "plus")
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(width: 55, height: 55)
                .background(.projectRed.shadow(.drop(radius: 10, x: 5, y: 10)), in: .circle)
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var boolControl: Bool = false
    CirclePlusButton(boolControl: $boolControl)
}
