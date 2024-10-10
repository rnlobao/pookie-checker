import SwiftUI

struct HomeLoggedInView: View {
    @ObservedObject var viewModel: HomeLoggedInViewModel
    
    var body: some View {
        Text("Your pookie")
            .font(.title)
            .fontWeight(.bold)
            .padding(.top, 20)
    }
}

struct HomeLoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        HomeLoggedInView(viewModel: HomeLoggedInViewModel())
    }
}
