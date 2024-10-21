import SwiftUI

struct InteractPookieView: View {
    @ObservedObject var viewModel = InteractPookieViewModel()

    var body: some View {
        if !viewModel.userIsConnected() {
            Text("Connect to your Pookie first! Go to the tab Connection")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
        } else {
            Text("You are connected")
        }
    }
}

struct InteractPookieView_Previews: PreviewProvider {
    static var previews: some View {
        InteractPookieView()
    }
}
