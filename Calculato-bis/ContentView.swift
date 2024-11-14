import SwiftUI

struct CalculatorButtonStyle: ButtonStyle {
    var isPlusMinus: Bool = false
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .padding()
            .frame(width: 80, height: 80)
            .background(
                            configuration.isPressed ?
                            Color(.systemGray3) : Color(UIColor.lightGray)
                        )
            .clipShape(Circle())
            .shadow(radius: 3)
            .font(
                isPlusMinus ?
                    .custom("BIG", size: 40) : .largeTitle
            )
            .foregroundColor(Color(UIColor.black))
        }
}
struct NumberButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .padding()
            .frame(width: 80, height: 80)
            .background(
                            configuration.isPressed ?
                            Color(.systemGray3) : Color(UIColor.gray)
                        )
            .clipShape(Circle())
            .shadow(radius: 3)
            .font(.largeTitle)
            .foregroundColor(.white)
            
        }
}
struct ActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .padding()
            .frame(width: 80, height: 80)
            .background(
                            configuration.isPressed ?
                            Color(UIColor.white) : Color(UIColor.orange)
                        )
            .clipShape(Circle())
            .shadow(radius: 3)
            .font(.custom("BIG", size: 40))
            .foregroundColor(configuration.isPressed ? .orange : .white)
        }
}


struct ContentView: View {
    
    @State private var display = "0"
    @State private var currentInput = ""
    @State private var lastOperator = ""
    
    let gridItems = [GridItem(.adaptive(minimum: .infinity, maximum: .infinity)), GridItem(.adaptive(minimum: .infinity, maximum: .infinity)), GridItem(.adaptive(minimum: .infinity, maximum: .infinity)),GridItem(.adaptive(minimum: .infinity, maximum: .infinity))]
    
    var body: some View {
        VStack {
            Spacer()
            Text(display)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.custom("BIG", size: 80))
                .padding(.trailing,20)
            
            Grid{
                // Other buttons
                GridRow{
                    Button("C") {clear()}.buttonStyle(CalculatorButtonStyle())
                    Button("±") {changeSign()}
                        .buttonStyle(CalculatorButtonStyle(isPlusMinus: true))
                        
                    Button("%") {percent()}.buttonStyle(CalculatorButtonStyle())
                    Button("÷") {}.buttonStyle(ActionButtonStyle())
                }
                GridRow{
                    Button("1") {appendNumber(sNum: "1")}.buttonStyle(NumberButtonStyle())
                    Button("2") {appendNumber(sNum: "2")}.buttonStyle(NumberButtonStyle())
                    Button("3") {appendNumber(sNum: "3")}.buttonStyle(NumberButtonStyle())
                    Button("×") {}.buttonStyle(ActionButtonStyle())
                }
                GridRow{
                    Button("4") {appendNumber(sNum: "4")}.buttonStyle(NumberButtonStyle())
                    Button("5") {appendNumber(sNum: "5")}.buttonStyle(NumberButtonStyle())
                    Button("6") {appendNumber(sNum: "6")}.buttonStyle(NumberButtonStyle())
                    Button("-") {}.buttonStyle(ActionButtonStyle())
                }
                GridRow{
                    Button("7") {appendNumber(sNum: "7")}.buttonStyle(NumberButtonStyle())
                    Button("8") {appendNumber(sNum: "8")}.buttonStyle(NumberButtonStyle())
                    Button("9") {appendNumber(sNum: "9")}.buttonStyle(NumberButtonStyle())
                    Button("+") {}.buttonStyle(ActionButtonStyle())
                }
                GridRow{
                    Button(action: {appendNumber(sNum: "0")}) {
                        Text("0")
                            .padding(.horizontal)
                        Spacer()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(UIColor.gray))
                    .font(.largeTitle)
                    .shadow(radius: 3)
                    .gridCellColumns(2)
                    .cornerRadius(.infinity)
                    Button(",") {
                      if (!currentInput.contains(".")) {
                        appendNumber(sNum: ".");
                      }
                    }.buttonStyle(NumberButtonStyle())
                    Button("=") {}.buttonStyle(ActionButtonStyle())
                }
            }.frame(height: 500)
        }
        .padding()
    }
    
    func appendNumber(sNum: String){
        currentInput += sNum
        display = currentInput
    }
    
    func clear(){
        display="0"
        currentInput=""
        lastOperator=""
    }
    
    func changeSign(){
        if(currentInput.contains(".")){
            var val = Double(currentInput) ?? 0.0
            val = -val
            currentInput = String(val)
            display = currentInput
        }else{
            var val = Int(currentInput) ?? 0
            val = -val
            currentInput = String(val)
            display = currentInput
        }
    }
    
    func percent() {
        if let val = Double(currentInput) {
            let result = val / 100
            currentInput = String(result)
            display = currentInput
        } else {
            currentInput = "Error"
            display = currentInput
        }
    }
}
#Preview {
    ContentView()
}
