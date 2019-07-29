//
//  ViewController.swift
//  VoiceOverSample
//
//  Created by Leena Mansour on 7/28/19.
//  Copyright © 2019 leena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)

        populateStackView()
        setAccessibilityAttributes()

        addRotorAction(to: ratingStackView)
    }


    // Where all the fun is happening
    func setAccessibilityAttributes() {
        // Set the StackView to be the accesibilityElement. This is false by default for
        // stackviews since they are containers. The defaults for UI elements such as UILabels is
        // always true
        // Since the container is now set to true, the children won't be reached by VO
        formatStackView.isAccessibilityElement = true

        // Set the accessibility label and value on it. VO will read out both.
        formatStackView.accessibilityLabel = formatLabel.text
        formatStackView.accessibilityValue = formatValueLabel.text

        // Do the same for the other rows
        authorStackView.isAccessibilityElement = true
        authorStackView.accessibilityLabel = authorLabel.text
        authorStackView.accessibilityValue = authorValueLabel.text

        releaseDateStackView.isAccessibilityElement = true
        releaseDateStackView.accessibilityLabel = releaseDateLabel.text
        releaseDateStackView.accessibilityValue = releaseDateValueLabel.text

        // This one is a fun one!
        ratingStackView.isAccessibilityElement = true
        ratingStackView.accessibilityLabel = ratingLabel.text

        // Formulate the accessibility value to include all the information needed to convey what's on the screen
        // Since the star rating is an image, we have to figure out how many stars from somewhere else
        let starCount = 5 // code to find star rating
        let numberOfReviews = reviewCountLabel.text ?? "0"

        // put them all together in one string and set that to be the value
        let ratingAccessibilityValue = "\(starCount) out of 5 stars. \(numberOfReviews) user reviews."
        ratingStackView.accessibilityValue = ratingAccessibilityValue


        // This is unnecessary here since the order is correct, but you can use .accesibilityElements to order
        // your items in the best order contextually, if your design makes the order less clear.
        // Go ahead, change this order around then test the app out!
        view.accessibilityElements = [formatStackView,
                                      authorStackView,
                                      releaseDateStackView,
                                      ratingStackView]
    }

    func addRotorAction(to view: UIView) {
        let sampleAction = UIAccessibilityCustomAction(name: "Sample Action",
                                                             target: self,
                                                             selector: #selector(doAction))

        view.accessibilityCustomActions = [sampleAction]
    }

    @objc func doAction() {
        print("Cool")
    }

    // Creating all of our views
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let formatStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    let formatLabel: UILabel = {
        let label = UILabel()
        label.text = "Format:"

        return label
    }()

    let formatValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Book"

        return label
    }()

    let authorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 50
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Author:"

        return label
    }()

    let authorValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Chuck Palahniuk"

        return label
    }()

    let releaseDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 50
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Release Date:"

        return label
    }()

    let releaseDateValueLabel: UILabel = {
        let label = UILabel()
        label.text = "May 8 2018"

        return label
    }()

    let ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 50
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    let ratingImageView: UIImageView = {
        let image = UIImage(named: "5stars")
        let imageView = UIImageView(image: image)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 70),
            imageView.heightAnchor.constraint(equalToConstant: 25)
            ])

        return imageView
    }()

    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "Rating:"

        return label
    }()

    let reviewCountLabel: UILabel = {
        let label = UILabel()
        label.text = "193"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)

        return label
    }()

    let ratingValueStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    // Populating our fake data stack view
    func populateStackView() {
        formatStackView.addArrangedSubview(formatLabel)
        formatStackView.addArrangedSubview(formatValueLabel)

        authorStackView.addArrangedSubview(authorLabel)
        authorStackView.addArrangedSubview(authorValueLabel)

        releaseDateStackView.addArrangedSubview(releaseDateLabel)
        releaseDateStackView.addArrangedSubview(releaseDateValueLabel)

        ratingValueStackView.addArrangedSubview(ratingImageView)
        ratingValueStackView.addArrangedSubview(reviewCountLabel)

        ratingStackView.addArrangedSubview(ratingLabel)
        ratingStackView.addArrangedSubview(ratingValueStackView)

        mainStackView.addArrangedSubview(formatStackView)
        mainStackView.addArrangedSubview(authorStackView)
        mainStackView.addArrangedSubview(releaseDateStackView)
        mainStackView.addArrangedSubview(ratingStackView)

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
    }
}

