//
//  MultiSliderTableViewCell.swift
//  MultiSliderSample
//
//  Created by Matteo Vidotto on 24/07/24.
//

import UIKit
import MultiSlider

class MultiSliderTableViewCell: UITableViewCell {
    static let reuseIdentifier = "MultiSliderTableViewCell"

    let slider = MultiSlider()
    var sliderValuesChanged: (((min: CGFloat, max: CGFloat)) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildViews()
    }
}

private extension MultiSliderTableViewCell {

    func buildViews() {
        slider.translatesAutoresizingMaskIntoConstraints = false

        addSubview(slider)

        addConstraints([
            slider.heightAnchor.constraint(equalToConstant: 46),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            bottomAnchor.constraint(equalTo: slider.bottomAnchor, constant: 16),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            trailingAnchor.constraint(equalTo: slider.trailingAnchor, constant: 20)
        ])
        contentView.isUserInteractionEnabled = false
        setupSlider()
    }

    @objc func sliderChanged(_ slider: MultiSlider) {
        guard let minValue = slider.value.first,
              let maxValue = slider.value.last else { return }
        sliderValuesChanged?((min: minValue, max: maxValue))
    }

    private func setupSlider() {
        slider.orientation = .horizontal
        slider.minimumValue = 0
        slider.maximumValue = 9
        slider.outerTrackColor = UIColor.lightGray
        slider.value = [0, 9]
        slider.valueLabelPosition = .top
        slider.tintColor = UIColor.blue
        slider.trackWidth = 4
        slider.snapStepSize = 1
        slider.showsThumbImageShadow = false
        slider.keepsDistanceBetweenThumbs = true
        slider.distanceBetweenThumbs = 1
        slider.valueLabelFormatter.positiveSuffix = " ML"
        slider.valueLabelColor = UIColor.blue
        slider.valueLabelFont = UIFont.systemFont(ofSize: 14)

        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
    }
}
