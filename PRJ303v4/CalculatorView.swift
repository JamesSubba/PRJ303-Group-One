import SwiftUI

extension View {
    func dismisskeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder
            .resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct CalculatorView: View {
    @State private var selectedTheme = "Dark"
    @State private var numberVal1 = 1
    @State private var numberVal2 = 1
    @State private var number =  6
    @State private var serviceQuality: Double = 1.0
    @State private var foodQuality: Double = 1.0
    @State private var billAmount: Double = 0.0
    @State private var tipAmount: Double = 0.0
    var body: some View {
            NavigationStack {
                ZStack {
                    Color("pm-black")
                        .ignoresSafeArea()
                    VStack {
                        Text("Smart Tip Calculator").foregroundColor(.white).font(.system(size: 20)).padding(.trailing, 190).bold().padding(.bottom,5).padding(.top, 20)
                        Rectangle()
                            .frame(width: 380, height: 1)
                            .foregroundColor(.white)
                            .opacity(0.08)
                            .padding(.bottom, 10)
                        Text("Tip Amount").foregroundColor(.white)
                            .font(.system(size: 13))
                            .padding(.trailing, 290)
                        ZStack {
                            Rectangle()
                                .fill(Color("sc-black"))
                                .frame(width: 360, height: 300)
                                .cornerRadius(10.0)
                            Text("Nu.\(tipAmount, specifier: "%.2f")").foregroundColor(.white)
                                .font(.system(size: 53))
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 30)
                        ZStack {
                            VStack (alignment: .center) {
                                Group{
                                    HStack {
                                        Text("Bill Amount").foregroundColor(.white)
                                            .padding(.leading, 5)
                                            .font(.system(size: 13))
                                        Spacer()
                                        Text("Nu.").foregroundColor(.white)
                                            .padding(.trailing, 5)
                                            .opacity(0.5)
                                            .font(.system(size: 13))
                                    }.padding(.bottom, 10)
                                    TextField("Enter bill amount", value: $billAmount, format: .number)
                                        .keyboardType(.decimalPad)
                                        .padding(.leading, 10)
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                        .opacity(0.5)
                                    Rectangle()
                                        .frame(width: 330, height: 1)
                                        .foregroundColor(.white)
                                        .opacity(0.08)
                                        .padding(.bottom, 20)
                                }
                                Group{
                                    HStack {
                                        Text("Service Quality").foregroundColor(.white)
                                            .padding(.leading, 5)
                                            .font(.system(size: 13))
                                        
                                        Spacer()
                                        Text("(1-10)").foregroundColor(.white)
                                            .padding(.trailing, 5)
                                            .opacity(0.5)
                                            .font(.system(size: 13))
                                    }.padding(.bottom, 10)
                                    TextField("Enter service quality (1-10)", value: $serviceQuality, format: .number)
                                        .keyboardType(.decimalPad)
                                        .padding(.leading, 10)
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                        .opacity(0.5)
                                    Rectangle()
                                        .frame(width: 330, height: 1)
                                        .foregroundColor(.white)
                                        .opacity(0.08)
                                        .padding(.bottom, 20)
                                }
                                Group {
                                    HStack {
                                        Text("Food Quality").foregroundColor(.white)
                                            .padding(.leading, 5)
                                            .font(.system(size: 13))
                                        
                                        Spacer()
                                        Text("(1-10)").foregroundColor(.white)
                                            .padding(.trailing, 5)
                                            .opacity(0.5)
                                            .font(.system(size: 13))
                                    }.padding(.bottom, 10)
                                    TextField("Enter food quality (1-10)", value: $foodQuality, format: .number)
                                        .keyboardType(.decimalPad)
                                        .padding(.leading, 10)
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                        .opacity(0.5)
                                    Rectangle()
                                        .frame(width: 330, height: 1)
                                        .foregroundColor(.white)
                                        .opacity(0.08)
                                        .padding(.bottom, 20)
                                }
                                Group {
                                    Button {
                                        let tipPercentage = calculateTipPercentage(serviceQuality: serviceQuality, foodQuality: foodQuality)
                                        let tipAmount = billAmount * tipPercentage
                                        let totalAmount = billAmount + tipAmount
                                        self.tipAmount = tipAmount
                                    } label: {
                                        Text("Calculate")
                                            .frame(width: 360, height: 60)
                                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 5))
                                            .foregroundColor(.white)
                                    }.padding(.top, 10)
                                }
                            }.padding([.leading, .trailing],30)
                                .padding(.bottom, 50)
                        }
                    }
                    
                }
                .onTapGesture{
                    self.dismisskeyboard()
                }
                .ignoresSafeArea()
            }
        }
    func calculateTipPercentage(serviceQuality: Double, foodQuality: Double) -> Double {
        // Define membership functions for service quality
        let servicePoor: ClosedRange<Double> = 1.0...4.0
        let serviceFair: ClosedRange<Double> = 3.0...7.0
        let serviceGood: ClosedRange<Double> = 6.0...10.0
        
        // Define membership functions for food quality
        let foodPoor: ClosedRange<Double> = 1.0...4.0
        let foodFair: ClosedRange<Double> = 3.0...7.0
        let foodGood: ClosedRange<Double> = 6.0...10.0
        
        // Calculate the degree of membership in each category
        let servicePoorMembership = calculateMembership(value: serviceQuality, range: servicePoor)
        let serviceFairMembership = calculateMembership(value: serviceQuality, range: serviceFair)
        let serviceGoodMembership = calculateMembership(value: serviceQuality, range: serviceGood)
        
        let foodPoorMembership = calculateMembership(value: foodQuality, range: foodPoor)
        let foodFairMembership = calculateMembership(value: foodQuality, range: foodFair)
        let foodGoodMembership = calculateMembership(value: foodQuality, range: foodGood)
        
        // Define fuzzy rules
        let tipPoor = min(servicePoorMembership, foodPoorMembership)
        let tipAverage = max(serviceFairMembership, foodFairMembership)
        let tipGood = min(serviceGoodMembership, foodGoodMembership)
        
        // Apply fuzzy logic to calculate the tip percentage
        let tipPercentage = (5.0 * tipPoor + 10.0 * tipAverage + 15.0 * tipGood) / (tipPoor + tipAverage + tipGood)
        
        return tipPercentage / 100.0
    }
    func calculateMembership(value: Double, range: ClosedRange<Double>) -> Double {
        if value < range.lowerBound || value > range.upperBound {
            return 0.0
        } else if value >= range.lowerBound && value <= range.upperBound {
            return 1.0
        } else if value < range.upperBound {
            return (value - range.lowerBound) / (range.upperBound - range.lowerBound)
        } else {
            return (range.upperBound - value) / (range.upperBound - range.lowerBound)
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
