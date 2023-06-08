import Foundation
import SwiftUI

struct DetailOneView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showingCredits = false
    @State private var showingBottomSheet = false
    
    var body: some View {
            ZStack {
                    Color("pm-black")
                        .ignoresSafeArea()
                        .navigationBarBackButtonHidden(true)
                VStack(){
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .frame(width: 20, height: 15)
                                .foregroundColor(.white)
                                .padding(.trailing, 115)
                        })
                        HStack(alignment: .center) {
                            Rectangle()
                                .frame(width: 10, height: 2)
                                .foregroundColor(.white)
                            Rectangle()
                                .frame(width: 30, height: 3)
                                .foregroundColor(.white)
                            Rectangle()
                                .frame(width: 10, height: 2)
                                .foregroundColor(.white)
                        }.padding(.trailing, 150)
                    }
                    .padding(.bottom, 70)
                    Image("detailonescreen-img").resizable()
                        .frame(width: 320, height: 300)
                        .offset(y: -20)
                        .shadow(color: Color.white.opacity(0.2), radius: 50, x: 0, y: 10)
                    HStack {
                        Text("French Fries").foregroundColor(.white)
                            .bold()
                            .padding(.leading,9)
                        Spacer()
                        Text("Nu.200").foregroundColor(.white).padding(.trailing, 13)
                            .bold()
                    }.padding([.top], 40)
                    HStack{
                        VStack{
                            Text("Size").foregroundColor(.white)
                                .opacity(0.5)
                                .padding(.bottom,3)
                            Text("Medium").foregroundColor(.white)
                        }
                        Rectangle()
                            .frame(width: 1, height: 30)
                            .foregroundColor(.white)
                            .padding([.leading, .trailing], 40)
                            .opacity(0.5)
                        VStack{
                            Text("Size").foregroundColor(.white)
                                .opacity(0.5)
                                .padding(.bottom,3)
                            Text("Medium").foregroundColor(.white)
                        }
                        Rectangle()
                            .frame(width: 1, height: 30)
                            .foregroundColor(.white)
                            .padding([.leading, .trailing], 40)
                            .opacity(0.5)
                        VStack{
                            Text("Size").foregroundColor(.white)
                                .opacity(0.5)
                                .padding(.bottom,3)
                            Text("Medium").foregroundColor(.white)
                        }
                    }.padding(.top)
                    Text("Lorem ipsum dolor sit amet, consectetur aelit, sed do eiusmod tempor incididunt ut laborolore magna aliqua. Ut enim ad minim veniam, quisuf nostrud exercitation Lorem ipsum dolor sit aet Lorem ipsum dolor sit ")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 20)
                        .opacity(0.8)
                        .padding([.bottom], 30)
                        .padding(.leading, 10)
                        .padding(.trailing, 7)
                    Button {
                        showingCredits.toggle()
                    } label: {
                        Text("Read Reviews")
                            .bold()
                            .frame(width: 380, height: 60)
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 5))
                            .foregroundColor(.white)
                    }
                }.padding()
            }
            .ignoresSafeArea()
            .sheet(isPresented: $showingCredits) {
               ReviewView()
                    .presentationDetents([.medium, .large])
            }
    }
}

struct DetailOneView_Previews: PreviewProvider {
    static var previews: some View {
        DetailOneView()
    }
}

var bottomSheetView: some View {
    VStack(spacing: 20) {
        Text("This is Bottom Sheet")
    }
}
