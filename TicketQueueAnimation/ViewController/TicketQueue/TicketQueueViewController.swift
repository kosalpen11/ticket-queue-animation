//
//  TicketQueueViewController.swift
//
//  Created by Kosal Pen on 16/12/24.
//

import UIKit
import Lottie

final class TicketQueueViewController: UIViewController {
    
    // MARK: - CallBack
    var completion: (() -> Void)? = nil
    var cancelCompletion: (() -> Void)? = nil
    
    // MARK: - Outlet
    @IBOutlet private weak var animationView: LottieAnimationView!
    @IBOutlet private weak var coverView: UIView!
    @IBOutlet private weak var backgroundProgressBar: UIView!
    @IBOutlet private weak var progressBar: UIView!
    @IBOutlet private weak var topLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var lastUpdateLabel: UILabel!
    @IBOutlet private weak var queueIdLabel: UILabel!
    @IBOutlet private weak var percentageLabel: UILabel!
    
    // MARK: - Private + Support
    
    private var widthConstraint: NSLayoutConstraint!
    private let updateInterval = 0.1
    private var elapsedTime: Double = 0
    private var totalDuration: Double = .zero
    
    init(segmentQueue: [Int]) {
        super.init(nibName: nil, bundle: nil)
        self.totalDuration = calculateRandomDuration(segmentQueue) ?? 3.0
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCoverView()
        configureLottie()
        configureProgressbar()
        validateRandomTimer()
        updateView()
    }
    
    func updateView() {
        lastUpdateLabel.text = String.init(
            format: "Status last update: %@",
            Date().formatted(custom: "hh:mm a")
        )
        queueIdLabel.text = String.init(
            format: "QID: %.f",
            Date().timeIntervalSince1970
        )
    }
    
    func validateRandomTimer() {
        Timer.scheduledTimer(
            withTimeInterval: updateInterval,
            repeats: true
        ) { [weak self] timer in
            guard let self = self else { return }
            elapsedTime += updateInterval
            let durationRatio = min(1, (elapsedTime / totalDuration))
            let percentage = min(100, (elapsedTime / totalDuration) * 100)
            
            DispatchQueue.main.async {
                self.updatePercentage(percentage: percentage)
                self.fireTimer(durationRatio: durationRatio)
            }
            
            if elapsedTime >= totalDuration {
                timer.invalidate()
                DispatchQueue.main.async { self.finish() }
            }
        }
    }
    
    func finish() {
        dismiss(animated: true, completion: completion)
    }
    
    @IBAction func exitQueueAction() {
        cancelCompletion?()
        dismiss(animated: true)
    }
}
 
// MARK: Private Extension
extension TicketQueueViewController {
    
    private func calculateRandomDuration(_ segmentQueue: [Int]) -> Double? {
        guard let first = segmentQueue.first, let last = segmentQueue.last else { return nil }

        let minElementsForRandom = 2
        return Double(segmentQueue.count > minElementsForRandom ? segmentQueue.randomElement()! : Int.random(in: first...last))
    }

    private func updatePercentage(percentage: Double) {
        percentageLabel.text = String(format: "%.0f%%", percentage)
    }
    
    private func fireTimer(durationRatio: Double) {
        updateMultiplier(multiplier: durationRatio)
    }
    
    private func configureProgressbar() {
        backgroundProgressBar.layer.cornerRadius = 20
        backgroundProgressBar.clipsToBounds = true
        progressBar.clipsToBounds = true
    }
    
    private func configureCoverView() {
        coverView.layer.cornerRadius = 25
    }
    
    private func configureLottie() {
        animationView.animation = LottieAnimation.named("queue-animation")
        animationView.layer.cornerRadius = animationView.bounds.height/2
        animationView.layer.applySketchShadow(
            color: TicketQueueComponents.AppColor.primary,
            x: 0,
            y: 5,
            blur: 20
        )
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.5
        animationView.play()
    }
    
    private func updateMultiplier(multiplier: CGFloat) {
        widthConstraint = progressBar.widthAnchor.constraint(
            equalTo: self.backgroundProgressBar.widthAnchor,
            multiplier: multiplier
        )
        widthConstraint.isActive = true
        
        progressBar.applySmartGradientTranslucency(
            type: .horizontal,
            colors: TicketQueueComponents.Gradient.colors
        )
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}
