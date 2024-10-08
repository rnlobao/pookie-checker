import SwiftUI

struct PartnersPookieView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State var imageFromPookie = UIImage()
    
    var body: some View {
        HStack {
            Image(uiImage: imageFromPookie)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
            
            Button(action: {
                imageFromPookie = viewModel.returnPookieInteraction()
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    imageFromPookie = viewModel.returnPookieImage()
                }
            }) {
                Text("♥️")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 55)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(white: 0.8), lineWidth: 2)
                    )
            }
            .padding(.horizontal, 20)
        }
        .onAppear {
            imageFromPookie = viewModel.returnPookieImage()
        }
    }
}

struct PartnersPookieViewView_Previews: PreviewProvider {
    static var previews: some View {
        PartnersPookieView(viewModel: HomeViewModel())
    }
}

