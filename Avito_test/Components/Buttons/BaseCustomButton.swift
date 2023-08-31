//
//  BaseCustomButton.swift
//  Avito_test
//
//  Created by Евгений on 31.08.2023.
//

import UIKit

enum StateButton {
    case call
    case write
}

final class BaseCustomButton: UIButton {
    
    // MARK: - Constants and Variables:
    private var stateButton: StateButton
    
    // MARK: - Lifecycle:
    init(state: StateButton) {
        self.stateButton = state
        super.init(frame: .zero)
        self.setupStateButton()
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override Methods:
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        transform = .identity
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        transform = .identity
    }
    
    // MARK: - Private Methods:
    private func setupStateButton() {
        switch stateButton {
        case .call:
            backgroundColor = .lightGreen
            setTitle(L10n.BaseButton.call, for: .normal)
            titleLabel?.font = .titleFont
        case .write:
            backgroundColor = .lightBlue
            setTitle(L10n.BaseButton.write, for: .normal)
            titleLabel?.font = .titleFont
        }
    }
}

// MARK: - Setup Views:
extension BaseCustomButton {
    private func setupViews() {
        layer.cornerRadius = 10
    }
}

// MARK: - Setup Constraints:
extension BaseCustomButton {
    private func setupConstraints() {
        heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
