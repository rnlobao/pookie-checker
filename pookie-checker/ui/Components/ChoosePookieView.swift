import SwiftUI

struct ChoosePookieView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var animateBorder: Bool = false

    let buttonImages = ["standing-dog", "standing-cat", "standing-panda", "standing-penguin"]
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(0..<buttonImages.count, id: \.self) { index in
                Button(action: {
                    withAnimation {
                        viewModel.currentUserPookieID = index
                        animateBorder = true
                    }
                }) {
                    ZStack {
                        Image(buttonImages[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(20)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(white: 0.8), lineWidth: 2)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .trim(from: 0, to: (viewModel.currentUserPookieID == index && animateBorder) ? 1 : 0)
                            .stroke(viewModel.connectionSuccessful ? Color.green : Color.blue, lineWidth: 2)
                            .animation(.easeInOut(duration: 1), value: animateBorder)
                    )
                }
                .disabled(viewModel.connectionSuccessful)
                .onAppear {
                    animateBorder = false
                }
            }
        }
    }
}
