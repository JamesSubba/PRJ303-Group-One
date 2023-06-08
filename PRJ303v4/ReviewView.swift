import SwiftUI
import Foundation
import Firebase
import NaturalLanguage

class UserProfileViewModel: ObservableObject {
    @Published private(set) var user: DBUser? = nil
    func loadCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        self.user = try await DataManager.shared.fetchUserInfo(userID: uid )
    }
}

struct ReviewView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showingCredits = false
    @State private var newReview = ""
    @State private var sentimentResult = ""
    @State var value : CGFloat = 0
    @StateObject private var viewModel = UserProfileViewModel()
    @ObservedObject var model = ViewModel()

    var body: some View {
            ZStack(alignment: .top){
                Color("pm-black")
                VStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: 150, height: 1)
                        .foregroundColor(.white)
                        .opacity(0.7)
                        .offset(x:92, y: -30)
                    Text("Overview").foregroundColor(.white)
                        .bold()
                        .font(.system(size: 20))
                    HStack{
                        VStack(spacing: 10){
                            Text("Neg").foregroundColor(.white)
                                .font(.system(size: 13))
                                .opacity(0.5)
                            Text("\(Int(model.negativeper))%").foregroundColor(.white)
                        }
                        Rectangle()
                            .frame(width: 1, height: 30)
                            .foregroundColor(.white)
                            .padding([.leading, .trailing], 50)
                            .opacity(0.5)
                        VStack (spacing: 10){
                            Text("Neu").foregroundColor(.white)
                                .font(.system(size: 13))
                                .opacity(0.5)
                            Text( "\(Int(model.neutralper))%").foregroundColor(.white)
                        }
                        Rectangle()
                            .frame(width: 1, height: 30)
                            .foregroundColor(.white)
                            .padding([.leading, .trailing], 50)
                            .opacity(0.5)
                        VStack (spacing: 7){
                            Text("Pos").foregroundColor(.white)
                                .font(.system(size: 13))
                                .opacity(0.5)
                            Text("\(Int(model.positiveper))%").foregroundColor(.white)
                        }
                    }.padding(.top)
                    Rectangle()
                        .frame(width: 330, height: 1)
                        .foregroundColor(.white)
                        .opacity(0.2)
                        .offset(x:3)
                        .padding(.top)
                    Text("People said").foregroundColor(.white)
                        .padding(.top)
                        .font(.system(size: 20))
                        .bold()
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(model.list){ item in
                            VStack(alignment: .leading) {
                                HStack(alignment: .center) {
                                    Image(systemName:"person.circle.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 40))
                                        .opacity(0.9)
                                    VStack(alignment: .leading, spacing: 7) {
                                        Text(item.createdBy).foregroundColor(.white)
                                            .bold()
                                        Text(item.createdAt).foregroundColor(.white)
                                            .font(.system(size: 13))
                                            .opacity(0.5)
                                    }.padding(.leading, 30)
                                    .task {
                                        try? await viewModel.loadCurrentUser()
                                        }
                                    Text(item.sentiment).foregroundColor(.white)
                                        .padding(.leading, 89)
                                        .font(.system(size: 13))
                                }.padding(.top)
                                Text(item.review)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.white)
                                    .padding(.leading, 85)
                                    .padding(.top, 5)
                                    .font(.system(size: 13))
                                    .frame(width: 350)
                                    .opacity(0.5)
                                Rectangle()
                                    .frame(width: 250, height: 1)
                                    .foregroundColor(.white)
                                    .padding(.leading, 85)
                                    .opacity(0.3)
                                    .padding(.top, 10)
                            }
                        }
                    }
                }.padding(.top, 40)
                    .safeAreaInset(edge: .bottom){
                        ZStack {
                            Rectangle()
                                .background(.ultraThinMaterial)
                                .frame(width: 370, height: 60)
                                .cornerRadius(15)
                            VStack (){
                                HStack {
                                    TextField("", text: $newReview)
                                        .foregroundColor(.white)
                                        .frame(width: 240)
                                        .offset(x: -15)
                                        .textFieldStyle(.plain)
                                        .placeholder(when: newReview.isEmpty){
                                            Text("Write your review here")
                                                .foregroundColor(.white)
                                                .bold()
                                                .font(.system(size: 13))
                                                .opacity(0.5)
                                                .offset(x: 60)
                                        }
                                        .placeholder(when: !newReview.isEmpty) {
                                            Button {
                                                analyzeSentiment()
                                                if let user = viewModel.user {
                                                    model.addReviewData(review: newReview, sentiment: sentimentResult,createdBy: user.username)
                                                    newReview = ""
                                                }
                                            } label: {
                                                Image(systemName: "paperplane.fill")
                                                    .rotationEffect(.degrees(45))
                                            }
                                            .offset(x: 240)
                                            .padding(.leading, 5)
                                        }
                                }

                            }.padding()
                        }.offset(y: -20)
                            .offset(y: -self.value)
                            .onAppear{
                                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) {
                                    (noti) in
                                    let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                                    let height = value.height
                                    self.value = height
                                }
                                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) {
                                    (noti) in
                                    self.value = 0
                                }
                            }
                    }
                    .ignoresSafeArea()
            }
            .onTapGesture{
                self.dismisskeyboard()
            }
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.hidden)
                .cornerRadius(5)
                .ignoresSafeArea()
    }
    func analyzeSentiment() {
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = newReview
        let (sentiment, _) = tagger.tag(at: newReview.startIndex, unit: .paragraph, scheme: .sentimentScore)
        if let sentiment = sentiment, let score = Float(sentiment.rawValue) {
            if score >= 0.5 {
                sentimentResult = "Positive"
            } else if score < 0.5 && score > -0.5  {
                sentimentResult = "Neutral"
            }
            else {
                sentimentResult = "Negative"
            }
        } else {
            sentimentResult = "Unable to determine sentiment."
        }
    }
    
    init() {
        model.getReviewData()
        model.getSentimentData()
        model.calculateSentimentPer()
    }
}
struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
