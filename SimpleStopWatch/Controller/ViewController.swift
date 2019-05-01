//
//  ViewController.swift
//  SimpleStopWatch
//
//  Created by Janin Culhaoglu on 01/05/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    var timer = Timer()
    var runTime: Float = 0.0
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?
    
    // MARK: - Outlets
    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    // MARK: - Actions
    @IBAction func reset(_ sender: UIButton) {
        timer.invalidate()
        runTime = 0.0
        updateDisplay()
    }
    
    @IBAction func didTapPlay(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runTimeAction), userInfo: nil, repeats: true)
    }
    
    @objc func runTimeAction() {
        runTime += 0.1
        updateDisplay()
        playButton.isEnabled = false
        pauseButton.isEnabled = true
    }
    
    @IBAction func didTapPause(_ sender: UIButton) {
        timer.invalidate()
        playButton.isEnabled = true
        pauseButton.isEnabled = false
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        AddBorderToLayers()
        backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            UIApplication.shared.endBackgroundTask((self.backgroundTaskIdentifier!))
        })
    }
    
    private func AddBorderToLayers() {
        playButton.layer.borderWidth = 1.0
        playButton.layer.borderColor = UIColor.black.cgColor
        pauseButton.layer.borderWidth = 1.0
        pauseButton.layer.borderColor = UIColor.black.cgColor
    }
    
    private func updateDisplay() {
        textView.text = String(runTime.cleanValue)
    }
}

extension Float {
    var cleanValue: String {
        return String(format: "%.1f", self)
    }
}
