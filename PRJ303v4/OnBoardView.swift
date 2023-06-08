import SwiftUI

struct OnBoardView: View {
    @State private var isUnityAppOpened = false
    var body: some View {
        
        NavigationView{
            ZStack {
                Color("pm-black")
                    .ignoresSafeArea()
                Image("bording")
                    .resizable()
                    .frame(width: 1000, height: 950)
                    .padding(.bottom, 250)
                VStack (alignment: .center, spacing: 30){
                    Image("logo").resizable()
                        .frame(width: 75.0, height: 75.0)
                        .padding(.top,480)
                    Text("Taking you food experience to whole another level with Menu 2.0")
                        .multilineTextAlignment(.center)
                        .frame(width: 370)
                        .foregroundColor(.white)
                    NavigationLink(destination: LoginView()
                        .navigationBarBackButtonHidden(true)){
                            Text("GER STARTED")
                                .bold()
                                .frame(width: 363, height: 60)
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 5))
                                .foregroundColor(.white)
                                .padding(.top, 20)
                    }
                }
            }
        }
    }
}

struct OnBoardView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardView()
    }
}
