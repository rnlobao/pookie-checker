import SwiftUI

struct HomeLoggedInView: View {
    @ObservedObject var viewModel: HomeLoggedInViewModel
    
    var body: some View {
        Text("oi")
    }
}

struct HomeLoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        HomeLoggedInView(viewModel: HomeLoggedInViewModel())
    }
}
