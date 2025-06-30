//
//  ContentView.swift
//  MyCalculator
//
//  Created by Dhaval Bhadania on 30/06/25.
//

import SwiftUI

struct ContentView: View {
    @State private var input: String = ""
    @State private var result: String = ""
    
    let calculator = StringCalculator()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {

                TextField("Enter numbers string", text: $input)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Button(action: {
                    calculateResult()
                }) {
                    Text("Calculate")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                Text(result)
                    .font(.title3)
                    .foregroundColor(.primary)
                    .padding()

                Spacer()
            }
            .navigationTitle("MyCalculator")
            .padding()
        }
    }

    func calculateResult() {
        do {
            let value = try calculator.add(input)
            result = "Result: \(value)"
        } catch let error as StringCalculator.CalculatorError {
            result = error.localizedDescription
        } catch {
            result = "Unexpected error occurred."
        }
    }
}
#Preview {
    ContentView()
}
