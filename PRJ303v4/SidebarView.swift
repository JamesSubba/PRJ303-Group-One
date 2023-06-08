import SwiftUI
import Firebase

struct SidebarView : View {
    @State var index = 0
    @State var show = false
    @State var showLogo : Int = 8
    @State private var loggedIn = false
    @State private var showingPermissionAlert = false
    
    var body: some View{
        ZStack{
            Image("login-bg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            HStack{
                VStack(alignment: .leading, spacing: 12) {
                    Button(action: {
                        self.index = 0
                        withAnimation{
                            self.show.toggle()
                        }
                    }) {
                        HStack(spacing: 25){
                            Text("Home")
                                .foregroundColor(self.index == 0 ? Color.white : Color.white)
                                .opacity(self.index == 0 ? 1 : 0.5)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 0 ? Color("Color1").opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                    }
                    Button(action: {
                        self.index = 1
                        withAnimation{
                            self.show.toggle()
                        }
                    }) {
                        HStack(spacing: 25){
                            Text("AR Experience")
                                .foregroundColor(self.index == 1 ? Color.white : Color.white)
                                .opacity(self.index == 1 ? 1 : 0.5)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 1 ? Color("Color1").opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                    }
                    Button(action: {
                        self.index = 2
                        withAnimation{
                            self.show.toggle()
                        }
                    }) {
                        HStack(spacing: 25){
                            Text("Chatbot")
                                .foregroundColor(self.index == 2 ? Color.white : Color.white)
                                .opacity(self.index == 2 ? 1 : 0.5)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 2 ? Color("Color1").opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                    }
                    Button(action: {
                        self.index = 3
                        withAnimation{
                            self.show.toggle()
                        }
                    }) {
                        HStack(spacing: 25){

                            Text("Tip Calculator")
                                .foregroundColor(self.index == 3 ? Color.white : Color.white)
                                .opacity(self.index == 3 ? 1 : 0.5)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 3 ? Color("Color1").opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                    }
                    Button(action: {
                        withAnimation{
//                            logout()
                            showingPermissionAlert = true
                        }
                    }) {
                        HStack(spacing: 25){
                            Text("Logout")
                                .foregroundColor(self.index == 1 ? Color.white : Color.white)
                                .opacity(self.index == 1 ? 1 : 0.5)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 1 ? Color("Color1").opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                    }
                    NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true), isActive: $loggedIn){
                        EmptyView()
                    }
                }
                .alert(isPresented: $showingPermissionAlert) {
                            Alert(
                                title: Text("Permission Required"),
                                message: Text("Are you sure you want to logout?"),
                                primaryButton: .default(Text("Logout"), action: {
                                    logout()
                                }),
                                secondaryButton: .cancel()
                            )
                        }
                .padding(.top,25)
                .padding(.horizontal,20)
                Spacer(minLength: 0)
            }
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            VStack(spacing: 0){
                if showLogo == 8 {
                    HStack(spacing: 15){
                        Image(showLogo == 8 ? "logo":"logo").resizable()
                            .frame(width: 32.0, height: 32.0)
                            .padding(.leading, 10)
                        Button(action: {
                            withAnimation{
                                self.show.toggle()
                            }
                        }) {
                            Spacer()
                            Image(systemName: self.show ? "xmark" : "line.horizontal.3")
                                .resizable()
                                .frame(width: self.show ? 18 : 30, height: self.show ? 18: 20)
                                .foregroundColor(Color.white.opacity(1))
                                .offset(x: 5)
                        }
                        Spacer(minLength: 0)
                    }
                    .padding(.top, 40)
                    .padding()
                    .offset(y: 10)
                }
                GeometryReader{_ in
                    VStack{
                        if self.index == 0{
                            HomeView(showLogo: $showLogo)
                        }
                        else if self.index == 1{
                            ARView()
                        }
                        else if self.index == 2{
                            ChatBotView()
                        }
                        else{
                            CalculatorView()
                        }
                    }
                }
            }
            .background(Color("pm-black"))
                .cornerRadius(self.show ? 30 : 0)
                .scaleEffect(self.show ? 0.8 : 1)
                .offset(x: self.show ? UIScreen.main.bounds.width / 2 : 0, y: self.show ? 15 : 0)
        }
        .background(Color("Color").edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
    }
    func logout(){
        try! Auth.auth().signOut()
        self.loggedIn = true
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}
