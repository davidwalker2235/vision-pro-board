import SwiftUI

struct DrugsList: View {
    @State var drugsList = DrugList
    @State private var value = 0
    @State private var filterText = ""
    
    func resetValues() {
        for index in drugsList.indices {
            drugsList[index].value = 0
        }
    }
    
    func incrementStep(for drug: Drug) {
        if let index = drugsList.firstIndex(where: { $0.id == drug.id }) {
            drugsList[index].value += 1
        }
    }
    
    func decrementStep(for drug: Drug) {
        if let index = drugsList.firstIndex(where: { $0.id == drug.id }) {
            drugsList[index].value -= 1
        }
    }
    
    var filteredDrugs: [Drug] {
        if filterText.isEmpty {
            return drugsList
        } else {
            return drugsList.filter { $0.name.localizedCaseInsensitiveContains(filterText) }
        }
    }
    
    var body: some View {
        VStack {
            HStack (alignment: .top) {
                Text("Filter").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).padding()
                TextField("", text: $filterText)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(30)
            }
            .padding(20)
            ScrollView(.vertical) {
                ForEach(filteredDrugs, id: \.id) { drug in
                    HStack (alignment: .bottom) {
                        item(for: drug.image, name: drug.name, specifications: "500mg", value: drug.value)
                            .padding()
                        Spacer()
                        Stepper("", value: Binding<Int>(
                            get: { drug.value },
                            set: { newValue in
                                let clampedValue = min(max(0, newValue), 10)
                                if clampedValue != drug.value {
                                    if clampedValue > drug.value {
                                        incrementStep(for: drug)
                                    } else {
                                        decrementStep(for: drug)
                                    }
                                }
                            }
                        ), in: 0...10)
                        .padding()
                    }.background(drug.value > 0 ? Color.black.opacity(0.2) : Color.clear)
                }
            }
            Button(action: {
                resetValues()
            }) {
                Text("Send")
                    .font(.title)
                    .padding()
                    .foregroundColor(.white)
                    .cornerRadius(30)
            }
            .padding(.bottom, 20)
        }
        .glassBackgroundEffect()
    }
}

func item(for image: Image, name: String, specifications: String, value: Int) -> some View {
    HStack {
        image
            .resizable()
            .frame(width: 40, height: 40)
            .padding(10)
        VStack (alignment: .leading) {
            Text(name).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text(specifications).font(.subheadline)
            Text("\(value) every 8 hours")
        }
    }
}

#Preview {
    DrugsList()
}
