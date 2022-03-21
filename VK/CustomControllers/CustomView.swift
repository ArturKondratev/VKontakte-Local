//
//  CustomView.swift
//  VK
//
//  Created by Артур Кондратьев on 25.02.2022.
//

import UIKit

@IBDesignable class CustomView: UIView {

    var image: UIImage = UIImage() {
        didSet {
            imageView.image = image
        }
    }

    private var imageView: UIImageView = UIImageView()
    private var containaerView: UIView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupImage()
        tapOnView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupImage()
        tapOnView()
    }

    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            self.updateColor()
        }
    }

    @IBInspectable var shadowOpacity: Float = 3.0 {
        didSet {
            self.updateOpacity()
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 4.0 {
        didSet {
            self.updateRadius()
        }
    }

    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            self.updateOffset()
        }
    }

    private func setupImage() {
        
        containaerView.frame = self.bounds
        containaerView.layer.cornerRadius = 28

        imageView.layer.masksToBounds = true
        imageView.frame = containaerView.bounds
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 28
        imageView.image = image

        containaerView.addSubview(imageView)
        self.addSubview(containaerView)
        updateShadows()
        
    }

    private func updateOpacity() {
        self.containaerView.layer.shadowOpacity = shadowOpacity
    }

    private func updateColor() {
        self.containaerView.layer.shadowColor = shadowColor.cgColor
    }

    private func updateOffset() {
        self.containaerView.layer.shadowOffset = shadowOffset
    }

    private func updateRadius() {
        self.containaerView.layer.shadowRadius = shadowRadius
    }

    private func updateShadows() {
        self.containaerView.layer.shadowOpacity = shadowOpacity
        self.containaerView.layer.shadowRadius = shadowRadius
        self.containaerView.layer.shadowColor = shadowColor.cgColor
        self.containaerView.layer.shadowOffset = shadowOffset
    }
    

    func tapOnView() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        recognizer.numberOfTapsRequired = 1 // сколько нажатий нужно
        //recognizer.numberOfTouchesRequired = 1 // сколько пальцев надо прижать
        self.addGestureRecognizer(recognizer) //добавить наблюдение
    }

    // анимация при тапе на аватар
    @objc func onTap(gestureRecognizer: UITapGestureRecognizer) {
        let original = self.transform // начальное состояние вьюхи
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.1,
                       options: [ .autoreverse],
                       animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9) //08 меняем размер вьюхи анимировано
        }, completion: { _ in
            self.transform = original // возврат состояния вьюхи на сохраненное значение
            //self.transform = .identity // возврат состояния вьюхи
        })
    }
}


