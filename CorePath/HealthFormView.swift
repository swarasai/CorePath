//
//  HealthFormView.swift
//  CorePath
//
//  Created by Swarasai Mulagari on 10/26/24.
//

import SwiftUI

struct MultiSelector<T: Hashable>: View {
    let label: Text
    let options: [T]
    let optionToString: (T) -> String
    
    @Binding var selected: Set<T>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            label
            ForEach(options, id: \.self) { option in
                Button(action: { toggleSelection(option: option) }) {
                    HStack {
                        Image(systemName: selected.contains(option) ? "checkmark.square.fill" : "square")
                            .foregroundColor(selected.contains(option) ? .blue : .gray)
                        Text(optionToString(option))
                            .font(.custom("AvenirNext-Regular", size: 16))
                    }
                }
                .foregroundColor(.primary)
            }
        }
    }
    
    private func toggleSelection(option: T) {
        if selected.contains(option) {
            selected.remove(option)
        } else {
            selected.insert(option)
        }
    }
}

struct HealthFormView: View {
    @Binding var name: String
    @Binding var currentWeight: String
    @Binding var goalWeight: String
    @Binding var height: String
    @Binding var age: String
    @Binding var gender: Int
    @Binding var fitnessGoals: Set<String>
    @Binding var exercisePreferences: Set<String>

    var onSubmit: () -> Void

    let genderOptions = ["Male", "Female", "Other"]
    let fitnessGoalOptions = ["Weight Loss", "Muscle Gain", "Improve Endurance", "Increase Flexibility", "Maintain Current Fitness"]
    let exercisePreferenceOptions = ["Cardio", "Strength Training", "Yoga", "Sports", "HIIT", "Swimming", "Cycling"]
    let supplementOptions = ["Multivitamin", "Protein", "Omega-3", "Vitamin D", "Probiotics"]
    let medicalConditionOptions = ["None", "Asthma", "Allergies", "ADHD", "Anxiety", "Depression"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Health Form")
                    .font(.custom("AvenirNext-Heavy", size: 48))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.blue, .cyan],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .padding()

                Group {
                    textField(question: "What is your name?", text: $name)
                    textField(question: "What is your current weight in kg?", text: $currentWeight)
                    textField(question: "What is your goal weight in kg?", text: $goalWeight)
                    textField(question: "What is your height in cm?", text: $height)
                    textField(question: "What is your age?", text: $age)
                    
                    VStack(alignment: .leading) {
                        Text("What is your gender?")
                            .font(.custom("AvenirNext-Bold", size: 18))
                            .foregroundColor(.blue)
                        Picker("Gender", selection: $gender) {
                            ForEach(0..<genderOptions.count) {
                                Text(self.genderOptions[$0])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                Group {
                    MultiSelector(
                        label: Text("What are your fitness goals?").font(.custom("AvenirNext-Bold", size: 18)).foregroundColor(.blue),
                        options: fitnessGoalOptions,
                        optionToString: { $0 },
                        selected: $fitnessGoals
                    )
                    
                    MultiSelector(
                        label: Text("What types of exercise do you prefer?").font(.custom("AvenirNext-Bold", size: 18)).foregroundColor(.blue),
                        options: exercisePreferenceOptions,
                        optionToString: { $0 },
                        selected: $exercisePreferences
                    )
                    
                }

                Button(action: {
                    onSubmit()
                }) {
                    Text("Submit")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .font(.custom("AvenirNext-Bold", size: 20))
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .background(Color(red: 0.9, green: 0.95, blue: 1.0))
    }

    private func textField(question: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(question)
                .font(.custom("AvenirNext-Bold", size: 18))
                .foregroundColor(.blue)
            TextField("Enter your answer", text: text)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .font(.custom("AvenirNext-Regular", size: 18))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue.opacity(0.5), lineWidth: 1)
                )
        }
    }
    
    private func customSlider(title: String, value: Binding<Double>, range: ClosedRange<Double>, step: Double) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom("AvenirNext-Bold", size: 18))
                .foregroundColor(.blue)
            HStack {
                Slider(value: value, in: range, step: step)
                    .accentColor(.blue)
                Text(String(format: "%.1f", value.wrappedValue))
                    .font(.custom("AvenirNext-Regular", size: 16))
            }
        }
    }
}
