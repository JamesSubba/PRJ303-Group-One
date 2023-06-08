import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    @Published private(set) var user: DBUser? = nil
    func loadCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        self.user = try await DataManager.shared.fetchUserInfo(userID: uid )
    }
}

struct HomeView: View {
    @Binding var showLogo: Int
    @StateObject private var viewModel = ProfileViewModel()
    @State private var goNext = false

    var body: some View {
        NavigationView{
            ZStack{
                Color("pm-black")
                    .onAppear{
                        self.showLogo=8
                    }
                    .ignoresSafeArea()
                VStack(){
                    VStack(alignment: .leading){
                        if let user = viewModel.user {
                            Text("Hi \(user.username)!")
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                                .bold()
                            Text("Let's find your favorite dish today")
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.trailing, 125)
                    .task {
                        try? await viewModel.loadCurrentUser()
                        }
                    Image("homescreen-img-1")
                        .resizable()
                        .padding(.top, 10)
                        .frame(width: 380.0, height: 180.0)
                    HStack {
                        Text("5 Items")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                            .padding(.leading,15)
                        Spacer()
                        Text("See all")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                            .padding(.trailing, 15)
                    }.padding(.top)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 7) {
                            ZStack {
                                Image("homescreen-img-2")
                                    .resizable()
                                    .frame(width: 385.0, height: 120.0)
                                    .overlay{
                                        VStack (alignment: .leading){
                                            Text("French Fries")
                                                .foregroundColor(.white)
                                            Text("Potatoes Fried in Oil and Salt")
                                                .font(.system(size: 10))
                                                .foregroundColor(.white)
                                            Text("Nu. 200")
                                                .font(.system(size: 15))
                                                .foregroundColor(.white)
                                                .padding([.top], 1)
                                        }.offset(x:25)
                                    }
                                Button (
                                    action: {
                                        self.showLogo = 9
                                        self.goNext.toggle()
                                    }
                                ) {
                                    Image("homescreen-button")
                                        .padding(.leading, 280)
                                }
                                NavigationLink(destination:DetailOneView().navigationBarBackButtonHidden(true), isActive: $goNext){
                                    EmptyView()
                                }
                            }.padding(.top, 7)
                                .padding(.bottom, 4)
                            ZStack {
                                Image("homescreen-img-2")
                                    .resizable()
                                    .frame(width: 385.0, height: 120.0)
                                    .overlay{
                                        VStack (alignment: .leading){
                                            Text("French Fries")
                                                .foregroundColor(.white)
                                            Text("Potatoes Fried in Oil and Salt")
                                                .font(.system(size: 10))
                                                .foregroundColor(.white)
                                            Text("Nu. 200")
                                                .font(.system(size: 15))
                                                .foregroundColor(.white)
                                                .padding([.top], 1)
                                        }.offset(x:25)
                                    }
                                Button (
                                    action: {
                                        self.showLogo = 9
                                        self.goNext.toggle()
                                    }
                                ) {
                                    Image("homescreen-button")
                                        .padding(.leading, 280)
                                }
                                NavigationLink(destination:DetailOneView().navigationBarBackButtonHidden(true), isActive: $goNext){
                                    EmptyView()
                                }
                            }.padding(.bottom, 4)
                            ZStack {
                                Image("homescreen-img-2")
                                    .resizable()
                                    .frame(width: 385.0, height: 120.0)
                                    .overlay{
                                        VStack (alignment: .leading){
                                            Text("French Fries")
                                                .foregroundColor(.white)
                                            Text("Potatoes Fried in Oil and Salt")
                                                .font(.system(size: 10))
                                                .foregroundColor(.white)
                                            Text("Nu. 200")
                                                .font(.system(size: 15))
                                                .foregroundColor(.white)
                                                .padding([.top], 1)
                                        }.offset(x:25)
                                    }
                                Button (
                                    action: {
                                        self.showLogo = 9
                                        self.goNext.toggle()
                                    }
                                ) {
                                    Image("homescreen-button")
                                        .padding(.leading, 280)
                                }
                                NavigationLink(destination:DetailOneView().navigationBarBackButtonHidden(true), isActive: $goNext){
                                    EmptyView()
                                }
                            }.padding(.bottom, 4)
                            ZStack {
                                Image("homescreen-img-2")
                                    .resizable()
                                    .frame(width: 385.0, height: 120.0)
                                    .overlay{
                                        VStack (alignment: .leading){
                                            Text("French Fries")
                                                .foregroundColor(.white)
                                            Text("Potatoes Fried in Oil and Salt")
                                                .font(.system(size: 10))
                                                .foregroundColor(.white)
                                            Text("Nu. 200")
                                                .font(.system(size: 15))
                                                .foregroundColor(.white)
                                                .padding([.top], 1)
                                        }.offset(x:25)
                                    }
                                Button (
                                    action: {
                                        self.showLogo = 9
                                        self.goNext.toggle()
                                    }
                                ) {
                                    Image("homescreen-button")
                                        .padding(.leading, 280)
                                }
                                NavigationLink(destination:DetailOneView().navigationBarBackButtonHidden(true), isActive: $goNext){
                                    EmptyView()
                                }
                            }.padding(.bottom, 4)
                            ZStack {
                                Image("homescreen-img-2")
                                    .resizable()
                                    .frame(width: 385.0, height: 120.0)
                                    .overlay{
                                        VStack (alignment: .leading){
                                            Text("French Fries")
                                                .foregroundColor(.white)
                                            Text("Potatoes Fried in Oil and Salt")
                                                .font(.system(size: 10))
                                                .foregroundColor(.white)
                                            Text("Nu. 200")
                                                .font(.system(size: 15))
                                                .foregroundColor(.white)
                                                .padding([.top], 1)
                                        }.offset(x:25)
                                    }
                                Button (
                                    action: {
                                        self.showLogo = 9
                                        self.goNext.toggle()
                                    }
                                ) {
                                    Image("homescreen-button")
                                        .padding(.leading, 280)
                                }
                                NavigationLink(destination:DetailOneView().navigationBarBackButtonHidden(true), isActive: $goNext){
                                    EmptyView()
                                }
                            }.padding(.bottom, 4)
                        }
                    }
                }.padding()
                    .ignoresSafeArea()
            }
        }
    }
}
