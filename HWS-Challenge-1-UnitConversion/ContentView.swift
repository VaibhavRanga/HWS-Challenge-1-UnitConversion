//
//  ContentView.swift
//  HWS-Challenge-1-UnitConversion
//
//  Created by Vaibhav Ranga on 25/03/24.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit = Units.Celsius
    @State private var outputUnit = Units.Celsius
    @State private var inputValue = 0.0
    @FocusState private var keyboardFocus: Bool
    
    private var fahrenheitToCelsius: Double {
        return ((inputValue - 32) * 5) / 9
    }
    private var fahrenheitToKelvin: Double {
        return ((inputValue - 32) * 5) / 9 + 273.15
    }
    private var kelvinToCelsius: Double {
        return (inputValue - 273.15)
    }
    private var kelvinToFahrenheit: Double {
        return ((inputValue - 273.15) * 9) / 5 + 32
    }
    private var celsiusToFahrenheit: Double {
        return ((inputValue * 9) / 5) + 32
    }
    private var celsiusToKelvin: Double {
        return inputValue + 273.15
    }
    private var outputValue: Double {
        switch inputUnit {
        case .Celsius:
            if outputUnit == .Celsius {
                return inputValue
            } else if outputUnit == .Fahrenheit {
                return celsiusToFahrenheit
            } else if outputUnit == .Kelvin {
                return celsiusToKelvin
            }
        case .Fahrenheit:
            if outputUnit == .Celsius {
                return fahrenheitToCelsius
            } else if outputUnit == .Fahrenheit {
                return inputValue
            } else if outputUnit == .Kelvin {
                return fahrenheitToKelvin
            }
        case .Kelvin:
            if outputUnit == .Celsius {
                return kelvinToCelsius
            } else if outputUnit == .Fahrenheit {
                return kelvinToFahrenheit
            } else if outputUnit == .Kelvin {
                return inputValue
            }
        }
        return 0.0
    }
    
    enum Units: CaseIterable {
        case Celsius
        case Fahrenheit
        case Kelvin
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input unit") {
                    Picker("Select the input unit", selection: $inputUnit) {
                        ForEach(Units.allCases, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Enter input value") {
                    TextField("Enter input value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($keyboardFocus)
                }
                
                Section("Desired output unit") {
                    Picker("Select the input unit", selection: $outputUnit) {
                        ForEach(Units.allCases, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Result") {
                    Text(outputValue, format: .number)
                }
            }
            .navigationTitle("Temperature Converter")
            .toolbar {
                if keyboardFocus {
                    Button("Done") {
                        keyboardFocus = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
