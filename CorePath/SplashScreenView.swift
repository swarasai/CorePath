//
//  SplashScreenView.swift
//  CorePath
//
//  Created by Swarasai Mulagari on 10/26/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var navigateToForm = false
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 0.0
    @State private var navigateToFitnessTracker = false

    // State variables to hold user input
    @State private var name = ""
    @State private var currentWeight = ""
    @State private var goalWeight = ""
    @State private var height = ""
    @State private var age = ""
    @State private var gender = 0
    @State private var activityLevel = 2.0
    @State private var dailyWaterIntake = 2.0
    @State private var exerciseHours = 3.0
    @State private var sleepHours = 7.0
    @State private var stressLevel = 5
    @State private var energyLevel = 5
    @State private var moodRating = 5
    @State private var sittingHours = 6.0
    @State private var motivationLevel = 5
    @State private var fitnessGoals = Set<String>()
    @State private var exercisePreferences = Set<String>()
    @State private var dietaryRestrictions = Set<String>()
    @State private var supplements = Set<String>()
    @State private var medicalConditions = Set<String>()
    @State private var isVegan = false
    @State private var isVegetarian = false
    @State private var isLactoseIntolerant = false
    @State private var wantsClearSkin = false
    @State private var participatesInSports = false
    @State private var hasRegularMealSchedule = false
    @State private var studiesLate = false
    @State private var usesScreenBeforeBed = false
    @State private var hasExtracurricularActivities = false
    @State private var experiencesTestAnxiety = false
    @State private var hasDifficultiesConcentrating = false
    

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.cyan.opacity(0.3)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            if !navigateToForm {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.8)
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.5)) {
                            opacity = 1.0
                            scale = 1.0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation(.easeInOut(duration: 1.5)) {
                                opacity = 0.0
                                scale = 1.2
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                navigateToForm = true
                            }
                        }
                    }
            } else {
                HealthFormView(
                    name: $name,
                    currentWeight: $currentWeight,
                    goalWeight: $goalWeight,
                    height: $height,
                    age: $age,
                    gender: $gender,
                    fitnessGoals: $fitnessGoals,
                    exercisePreferences: $exercisePreferences,
                    onSubmit: {
                        navigateToFitnessTracker = true
                    }
                )
                .fullScreenCover(isPresented: $navigateToFitnessTracker) {
                    FitnessTrackerView(
                        fitnessGoals: fitnessGoals, 
                        name: name,
                        currentWeight: currentWeight,
                        goalWeight: goalWeight,
                        activityLevel: activityLevel
                    )
                }
            }
        }
    }
}
