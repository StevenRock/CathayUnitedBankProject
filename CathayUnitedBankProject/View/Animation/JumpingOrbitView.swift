//
//  JumpingOrbitView.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/14.
//

import SwiftUI

struct JumpingOrbitView: View {
    @State var size: CGFloat = 4
    
    var repeatingAnimation: Animation {
            Animation
            .easeInOut(duration: 0.5)
                .repeatForever()
        }
    
    var body: some View {
            Text("🌐")
                .padding()
                .scaleEffect(size)
                .onAppear() {
                    withAnimation(self.repeatingAnimation) {
                        self.size = 1.3
                    }
            }
        }
}

#Preview {
    JumpingOrbitView()
        .preferredColorScheme(.dark)
}
