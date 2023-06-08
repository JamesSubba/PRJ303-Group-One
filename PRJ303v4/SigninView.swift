import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct SigninView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var fullname = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmpassword = ""
    @State private var signedIn = false
    
    var body: some View {
        ZStack {
            Image("sign-up-bg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            Spacer()
                      .navigationBarBackButtonHidden(true)
                  .toolbar(content: {
                      ToolbarItem (placement: .navigationBarLeading)  {
                          Button(action: {
                              presentationMode.wrappedValue.dismiss()
                          }, label: {
                              Image(systemName: "arrow.left")
                              .foregroundColor(.white)
                          })
                      }
                      })
            
            VStack(spacing: 20) {
                Group {
                    Text("Register")
                        .foregroundColor(.white)
                        .font(.custom("Freight Big Pro Light", size: 46))
                        .offset(y: -50)
                        .padding(.top, 20)
                    Text("Create your own account")
                        .foregroundColor(.white)
                        .offset(y: -50)
                        .padding(.bottom, 20)
                        .font(.custom("Freight Big Pro Light", size:15))
                    TextField("Full Name", text: $fullname)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: fullname.isEmpty){
                            Text("Full Name")
                                .foregroundColor(.white)
                                .bold()
                                .opacity(0.5)
                                .padding(.leading, 10)
                                .font(.custom("Freight Big Pro Light", size:15))
                        }
                    Rectangle()
                        .frame(width: 360, height: 1)
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                    TextField("Email", text: $email)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: email.isEmpty){
                            Text("Email")
                                .foregroundColor(.white)
                                .bold()
                                .opacity(0.5)
                                .padding(.leading, 10)
                                .font(.custom("Freight Big Pro Light", size:15))
                        }
                    Rectangle()
                        .frame(width: 360, height: 1)
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                    SecureField("Password", text: $password)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: password.isEmpty) {
                            Text("Password")
                                .foregroundColor(.white)
                                .bold()
                                .opacity(0.5)
                                .padding(.leading, 10)
                                .font(.custom("Freight Big Pro Light", size:15))
                        }
                    Rectangle()
                        .frame(width: 360, height: 1)
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                    SecureField("Confirm Password", text: $confirmpassword )
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: confirmpassword.isEmpty) {
                            Text("Confirm Password")
                                .foregroundColor(.white)
                                .bold()
                                .opacity(0.5)
                                .padding(.leading, 10)
                                .font(.custom("Freight Big Pro Light", size:15))
                        }
                    Rectangle()
                        .frame(width: 360, height: 1)
                        .foregroundColor(.white)
                }
                Group {
                    Button {
                        register()
                    } label: {
                        Text("Sign up")
                            .bold()
                            .frame(width: 360, height: 60)
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 5))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 10)
                    .offset(y: 30)
                    NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true), isActive: $signedIn){
                        EmptyView()
                    }
                    NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true)){
                        Text("Already have an account? Login")
                            .bold()
                            .foregroundColor(.white)
                            .font(.custom("Freight Big Pro Light", size:15))
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 0)
                }
            }
            .frame(width: 350)
        }
        .ignoresSafeArea()
    }
    func register(){
        if self.email != "" && self.password != ""{
            if self.fullname != "" && self.confirmpassword != ""{
                if self.password == self.confirmpassword {
                    Auth.auth().createUser(withEmail: email, password: password){
                        result, error in
                        if error != nil {
                            print(error!.localizedDescription)
                        }
                        guard let user = result?.user else { return }
                                    print("DEBUG: Registered user successfully")
                                    let data = [
                                        "uid": user.uid,
                                        "email": email,
                                        "fullname": fullname
                                                ]
                            Firestore.firestore().collection("users")
                            .document(user.uid).setData(data, merge: false)
                        signedIn = true
                                      
                    }
                }
            }
        }

    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}

