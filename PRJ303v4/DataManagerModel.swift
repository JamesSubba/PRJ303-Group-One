import Foundation
import Firebase
import FirebaseFirestore

class ViewModel: ObservableObject {
    @Published var list = [Review]()
    @Published var positive: Double = 0.0
    @Published var neutral: Double = 0.0
    @Published var negative: Double = 0.0
    @Published var positiveper: Double = 0.0
    @Published var neutralper: Double = 0.0
    @Published var negativeper: Double = 0.0
    @Published var total: Double = 0.0
    
    func addReviewData(review: String, sentiment: String, createdBy: String) {
        let db = Firestore.firestore()
        
        db.collection("reviews").addDocument(data: ["review": review, "sentiment": sentiment,  "createdBy": createdBy, "createdAt": Timestamp(date: Date())] ) {error in
            if error == nil {
                self.getReviewData()
            }
            else {
            }
        }
    }
    
    func getReviewData() {
        let db = Firestore.firestore()
        db.collection("reviews").getDocuments {snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.list = snapshot.documents.map{
                            d in
                            let createdAt = (d["createdAt"] as AnyObject).dateValue()
                            return Review(id: d.documentID,
                                          review: d["review"] as? String ?? "",
                                          sentiment: d["sentiment"] as? String ?? "",
                                          createdBy: d["createdBy"] as? String ?? "",
                                          createdAt: createdAt.formatDate()
                            )
                        }
                    }
                    
                }
            }
            else {
            }
        }
    }
    
    func getSentimentData(){
        let db = Firestore.firestore()
        let collectionRef = db.collection("reviews")
        
        collectionRef.getDocuments { querySnapshot, error in
            if let error = error {
                // Handle the error
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    // Access the specific field in the document
                    if let field = document.data()["sentiment"] as? String {
                        // Determine the category of the field value
                        let category = getCategory(for: field)
                        
                        func getCategory(for fieldValue: String) -> String {
                            if fieldValue.contains("Positive") {
                                return "Positive"
                            } else if fieldValue.contains("Neutral") {
                                return "Neutral"
                            } else {
                                return "Negative"
                            }
                        }
                        if category == "Positive" {
                            self.total += 1
                            self.positive += 1
                        } else if category == "Neutral" {
                            self.total += 1
                            self.neutral += 1
                        } else {
                            self.total += 1
                            self.negative += 1
                        }
                    }
                }
                self.positiveper = (self.positive / self.total) * 100.0
                self.neutralper = (self.neutral / self.total) * 100.0
                self.negativeper = (self.negative / self.total) * 100.0
            }
        }

    }
    func calculateSentimentPer() {
    }
}

extension Date {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM d, yyyy")
        return dateFormatter.string(from: self)
    }
}
