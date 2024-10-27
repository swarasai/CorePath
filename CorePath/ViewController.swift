//
//  ViewController.swift
//  CorePath
//
//  Created by Swarasai Mulagari on 10/26/24.
//

import UIKit
import SwiftUI
import CoreML

class ViewController: UIViewController {
    private var shouldShowOptions = false {
        didSet {
            updateUI()
        }
    }
    private var formHostingController: UIHostingController<HealthFormView>?
    private var splashScreenHostingController: UIHostingController<SplashScreenView>?
    
    private var name = ""
    private var currentWeight = ""
    private var goalWeight = ""
    private var height = ""
    private var age = ""
    private var gender = 0
    private var fitnessGoals = Set<String>()
    private var exercisePreferences = Set<String>()
    private var activityLevel = 0.0
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "MarkerFelt-Wide", size: 24)
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.5, alpha: 1)
        label.text = ""
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.9, green: 0.95, blue: 1.0, alpha: 1.0)
        
        showSplashScreen {
            self.showHealthForm()
            self.setupUIElements()
        }
    }
    
    private func showSplashScreen(completion: @escaping () -> Void) {
        let splashScreenView = SplashScreenView()
        splashScreenHostingController = UIHostingController(rootView: splashScreenView)
        
        if let hostingController = splashScreenHostingController {
            addChild(hostingController)
            hostingController.view.frame = view.bounds
            view.addSubview(hostingController.view)
            hostingController.didMove(toParent: self)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.splashScreenHostingController?.view.removeFromSuperview()
            self.splashScreenHostingController?.removeFromParent()
            completion()
        }
    }

    private func showHealthForm() {
        let formView = HealthFormView(
            name: Binding(
                get: { self.name },
                set: { self.name = $0 }
            ),
            currentWeight: Binding(
                get: { self.currentWeight },
                set: { self.currentWeight = $0 }
            ),
            goalWeight: Binding(
                get: { self.goalWeight },
                set: { self.goalWeight = $0 }
            ),
            height: Binding(
                get: { self.height },
                set: { self.height = $0 }
            ),
            age: Binding(
                get: { self.age },
                set: { self.age = $0 }
            ),
            gender: Binding(
                get: { self.gender },
                set: { self.gender = $0 }
            ),
            fitnessGoals: Binding(
                get: { self.fitnessGoals },
                set: { self.fitnessGoals = $0 }
            ),
            exercisePreferences: Binding(
                get: { self.exercisePreferences },
                set: { self.exercisePreferences = $0 }
            ),
            onSubmit: { [weak self] in
                self?.navigateToFitnessTracker()
            }
        )

        formHostingController = UIHostingController(rootView: formView)
        if let hostingController = formHostingController {
            addChild(hostingController)
            hostingController.view.frame = view.bounds
            view.addSubview(hostingController.view)
            hostingController.didMove(toParent: self)
        }
    }
    
    
    private func navigateToFitnessTracker() {
        let fitnessTrackerView = FitnessTrackerView(
            fitnessGoals: fitnessGoals, 
            name: name,
            currentWeight: currentWeight,
            goalWeight: goalWeight, 
            activityLevel: activityLevel
        )
        let fitnessTrackerHostingController = UIHostingController(rootView: fitnessTrackerView)
        
        addChild(fitnessTrackerHostingController)
        fitnessTrackerHostingController.view.frame = view.bounds
        view.addSubview(fitnessTrackerHostingController.view)
        fitnessTrackerHostingController.didMove(toParent: self)
        
        formHostingController?.view.removeFromSuperview()
        formHostingController?.removeFromParent()
    }

    private func updateUI() {
        // Update your UI based on the shouldShowOptions value
        // For example, you might want to show/hide certain views
    }



    private func setupUIElements() {
        view.addSubview(resultLabel)
        view.addSubview(backButton)
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    @objc private func backButtonTapped() {
        print("Back button tapped")
        // Add functionality to go back
    }
    
}
