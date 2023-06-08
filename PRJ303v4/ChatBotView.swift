import OpenAISwift
import Foundation
import SwiftUI

final class VViewModel: ObservableObject {
    init() {}
    private var client: OpenAISwift?
    func setup() {
        client = OpenAISwift(authToken: "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")
    }
    func send(text: String,
              completion: @escaping (String) -> Void){
        client?.sendCompletion(with: text,
                               maxTokens: 500,
                               completionHandler: { result in
            switch result {
            case .success(let model):

                let output = model.choices?.first?.text ?? ""
                completion(output)
            case .failure:
                break
            }
            })
    }
}
struct ChatBotView: View {
    @ObservedObject var viewmodel = VViewModel()
    @State private var chat = ""
    @State var text = ""
    @State var models: [String] = ["Welcome, how can I help you?"]
    @State var messages: [String] = ["Welcome, how can I help you?"]
    @State var value : CGFloat = 0

    var body: some View {
        ZStack {
            Color("pm-black")
                .ignoresSafeArea()
            VStack(alignment:.center) {
                Rectangle()
                    .frame(width: .infinity, height: 1)
                    .foregroundColor(.white)
                    .opacity(0.3)
           Spacer()
                ScrollView(.vertical, showsIndicators: false){
                    ForEach(models, id: \.self) {
                        message in
                        if message.contains("Me") {
                            HStack{
                                Spacer()
                                Text(message)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(.blue.opacity(0.8))
                                    .cornerRadius(10)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 10)
                            }
                        }
                        else {
                            HStack {
                                Text(message)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(.gray.opacity(0.15))
                                    .cornerRadius(10)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 10)
                                Spacer()
                            }
                        }
                    }.rotationEffect(.degrees(180))
                }
                .rotationEffect(.degrees(180))
                .padding(.bottom, 25)
                    .safeAreaInset(edge: .bottom){
                        ZStack {
                            Rectangle()
                                .background(.ultraThinMaterial)
                                .frame(width: 365, height: 60)
                                .cornerRadius(15)
                            VStack (){
                                HStack {
                                    TextField("", text: $text)
                                        .foregroundColor(.white)
                                        .frame(width: 240)
                                        .offset(x: -15)
                                        .textFieldStyle(.plain)
                                        .onSubmit {
                                            send()
                                        }
                                        .placeholder(when: text.isEmpty){
                                            Text("Write your quries here")
                                                .foregroundColor(.white)
                                                .bold()
                                                .font(.system(size: 13))
                                                .opacity(0.5)
                                                .offset(x: 50)
                                        }
                                        .placeholder(when: !text.isEmpty) {
                                            Button {
                                                send()
                                            } label: {
                                                Image(systemName: "paperplane.fill")
                                                    .rotationEffect(.degrees(45))
                                            }
                                            .offset(x: 240)
                                            .padding(.leading, 5)
                                        }
                                }.onAppear {
                                    viewmodel.setup()
                                }
                            }.padding()
                            
                        }.offset(y: -30)
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
                    .onTapGesture{
                        self.dismisskeyboard()
                    }
                    .ignoresSafeArea()
            }.padding()
        }
        .ignoresSafeArea()
    }
    func sendMessage(message: String) {
        withAnimation {
            messages.append("[USER]" + message)
            self.chat = ""
        }
        DispatchQueue.main.asyncAfter(deadline:.now()+1) {
            withAnimation {
                messages.append(getBotResponse(message: message))
            }
        }
    }
    func send() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                    return
                }
                models.append("Me : \(text)")
                viewmodel.send(text: text) {
                    result in print(result)
                    self.models.append("chatGpt :" + result)
                }
                self.text = ""
            }
    }

struct ChatBotView_Previews: PreviewProvider {
    static var previews: some View {
        ChatBotView()
    }
}



