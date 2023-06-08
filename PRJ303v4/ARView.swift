import SwiftUI
struct ARView : View {
    var body: some View{
        ZStack {
            VStack(alignment: .leading){
                Text("Menu 2.0")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .bold()
                Text("AR Experience")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .bold()
                    .padding(.bottom, 10)
                Text("New Immersive Dinning")
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                Text("Experience our variety of dishes in 3 dimension before you place your order making your decision even better. Download our app from the app store for the immersive experience")
                    .foregroundColor(.white)
                    .opacity(0.6)
                    .padding(.bottom, 10)
                Link("App Store", destination: URL(string: "https://google.com")!)
            }.padding(.leading, 20)
                .padding(.trailing, 25)
                .padding(.top, 150)
        }
    }
    struct ARView_Previews: PreviewProvider {
        static var previews: some View{
            ARView()
        }
    }
}
