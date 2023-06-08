import Foundation
import Firebase
import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var email = ""
    @State private var password = ""
    @State private var loggedIn = false
    
    var body: some View {
        NavigationView{
            ZStack{
                    Image("login-bg")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                Spacer()
                          .navigationBarBackButtonHidden(true)
                Image("logo").resizable()
                    .frame(width: 200.0, height: 200.0)
                    .padding(.bottom, 500)
                VStack(spacing: 20) {
                        Group {
                            Text("Login")
                                .foregroundColor(.white)
                                .font(.custom("Freight Big Pro Light", size: 46))
                                .offset(y: -20)
                                .padding(.top, 70)
                            Text("Login to your account")
                                .foregroundColor(.white)
                                .offset(y: -30)
                                .font(.custom("Freight Big Pro Light", size:15))
                            TextField("", text: $email)
                                .foregroundColor(.white)
                                .textFieldStyle(.plain)
                                .keyboardType(.emailAddress)
                                .padding(.leading, 25)
                                .placeholder(when: email.isEmpty){
                                    Text("Email")
                                        .foregroundColor(.white)
                                        .bold()
                                        .opacity(0.5)
                                        .padding(.leading, 25)
                                        .font(.custom("Freight Big Pro Light", size:15))
                                }
                            Rectangle()
                                .frame(width: 360, height: 1)
                                .foregroundColor(.white)
                        }
                        SecureField("", text: $password)
                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                            .padding(.leading, 25)
                            .placeholder(when: password.isEmpty) {
                                Text("Password")
                                    .padding(.leading, 25)
                                    .padding(.top, 10)
                                    .foregroundColor(.white)
                                    .bold()
                                    .opacity(0.5)
                                    .font(.custom("Freight Big Pro Light", size:15))
                            }
                        Rectangle()
                            .frame(width: 360, height: 1)
                            .foregroundColor(.white)
                    Button {
                        login()
                    } label: {
                        Text("Login")
                            .bold()
                            .frame(width: 360, height: 60)
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 5))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 30)
                    NavigationLink(destination: SidebarView().navigationBarBackButtonHidden(true), isActive: $loggedIn){
                        EmptyView()
                    }
                    NavigationLink(destination: SigninView().navigationBarBackButtonHidden(true)){
                        Text("Don't have an account? Sign Up")
                            .bold()
                            .foregroundColor(.white)
                            .font(.custom("Freight Big Pro Light", size:15))
                    }
                    .padding(.bottom, 50)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .foregroundColor(Color.primary.opacity(0.35))
                    .foregroundStyle(.ultraThinMaterial)
                    .cornerRadius(35)
                    .offset(y: 180)
                    .ignoresSafeArea()
                    .onTapGesture{
                        self.dismisskeyboard()
                    }
            }
        }
        
    }
    func login(){
        Auth.auth().signIn(withEmail: email, password: password) {
            result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                loggedIn = true
            }
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension View {
    func placeholder<Content: View> (
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1:0)
                self
            }
        }
}
