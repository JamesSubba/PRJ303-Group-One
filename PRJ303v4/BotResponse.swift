import Foundation

func getBotResponse(message: String) -> String{
    let tempMessage = message.lowercased()
    if tempMessage.contains("hello") {
        return "Hey there!"
    } else if tempMessage.contains("goodbye") {
        return "Talk to you later"
    } else if tempMessage.contains("how are you") {
        return "I am good"
    } else {
        return "That's cool"
    }
}
