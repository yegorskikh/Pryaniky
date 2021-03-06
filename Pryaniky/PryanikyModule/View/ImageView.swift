//
//  ImageView.swift
//  Pryaniky
//
//  Created by Egor Gorskikh on 22.07.2021.
//

import UIKit

class ImageView: UIView {

    lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    lazy var nameImagelabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    private var tapViewCallback: (() -> Void)?

    // MARK: - Life Cycle

    init(tapViewCallback: @escaping () -> Void) {
        super.init(frame: .zero)
        self.tapViewCallback = tapViewCallback
        setupConstraint()
        addTap()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
        addTap()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setupConstraint() {
        self.addSubview(imageView)
        self.addSubview(nameImagelabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            nameImagelabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            nameImagelabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            nameImagelabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameImagelabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }

    private func addTap() {
        let selector = #selector(self.viewlDidTapped)
        self.addGTapRecognizer(selector: selector)
    }

    @objc private func viewlDidTapped() {
        tapViewCallback?()
    }

    // MARK: - Public Methods

    public func showContent(content: PictureModel) {
        if let url = URL(string: content.url) {
            imageView.loadImage(byUrl: url)
        }
        nameImagelabel.text = content.text
    }

}
