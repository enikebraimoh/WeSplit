//
//  ContentView.swift
//  WeSplit
//
//  Created by Enike Braimoh on 01/07/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.00
    @State private var numberOfPeople = 2
    @State private var tipPercent = 20
    @FocusState private var amountIsFocused : Bool
    private let percentages = [20,40,60,80,100]
    
    var totalPerPerson : Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercent)
        
        let tipValue = (checkAmount / 100) * tipSelection
        let grandTotal = checkAmount + tipValue
        
        let totalPerPerson = grandTotal / peopleCount
        
        return totalPerPerson
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("How much is the meal" , value: $checkAmount, format:
                            .currency(code: Locale.current.currencyCode ?? "NGN"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) People")
                        }
                    }
                }
                Section{
                    Picker("Tip percentage",selection: $tipPercent){
                        ForEach(percentages, id : \.self){
                            Text($0,format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip would you like to leave")
                }
                Section{
                    Text(totalPerPerson,format: .currency(code: Locale.current.currencyCode ?? "NGN"))
                }
            }
            .navigationTitle("We Split😬")
            .toolbar(content: {
                ToolbarItemGroup(placement: .keyboard, content: {
                    Spacer()
                    Button("Done"){
                        amountIsFocused = false
                    }
                })
            })
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
