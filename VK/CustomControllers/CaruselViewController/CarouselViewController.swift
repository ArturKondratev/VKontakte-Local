//
//  CarouselViewController.swift
//  VK
//
//  Created by Артур Кондратьев on 28.02.2022.
//

import UIKit

final class CarouselViewController: UIViewController {

    // Должно приходить от контроллера со всеми фото
    var photos: [UIImage] = []
    var photoViews: [UIImageView] = []

    var selectedPhoto = 0

    // Создаём три переменные, которые будут отвечать за то, что мы видим на экране и с чем взаимодействуем
    private var leftImageView: UIImageView!
    private var middleImageView: UIImageView!
    private var rightImageView: UIImageView!

    // UIViewPropertyAnimator, задаём доступные нам жесты
    var swipeToRight: UIViewPropertyAnimator!
    var swipeToLeft: UIViewPropertyAnimator!

    //  создаём массив вьюх с картинками для галлереи
    func createImageViews() {
        for photo in photos {
            let view = UIImageView()
            view.image = photo
            view.contentMode = .scaleAspectFit

            photoViews.append(view)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        // создаём вьюхи с картинками
        createImageViews()

        // создадим вьюхи для отображения
        leftImageView = UIImageView()
        middleImageView = UIImageView()
        rightImageView = UIImageView()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // регистрируем распознаватель жестов
        let gestPan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        view.addGestureRecognizer(gestPan)



        setImage()
        startAnimate()
    }

    // чистим вьюхи, чтобы не накладывались
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.subviews.forEach({ $0.removeFromSuperview() }) // проходится по всем сабвью этой вьюхи и удаляет её из родителя
    }

    // конфигурируем отображение
    func setImage(){
        var indexPhotoLeft = selectedPhoto - 1
        let indexPhotoMid = selectedPhoto
        var indexPhotoRight = selectedPhoto + 1

        // делаем круговую прокрутку, чтобы если левый индекс меньше 0, то его ставит последним
        if indexPhotoLeft < 0 {
            indexPhotoLeft = photoViews.count - 1

        }
        if indexPhotoRight > photoViews.count - 1 {
            indexPhotoRight = 0
        }

        // чистим вьюхи, т.к. мы постоянно добавляем новые
        view.subviews.forEach({ $0.removeFromSuperview() })

        // Присваиваем видимым картинкам нужные вьюхи
        leftImageView = photoViews[indexPhotoLeft]
        middleImageView = photoViews[indexPhotoMid]
        rightImageView = photoViews[indexPhotoRight]

        view.addSubview(leftImageView)
        view.addSubview(middleImageView)
        view.addSubview(rightImageView)

        // чистим констрейнты
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        middleImageView.translatesAutoresizingMaskIntoConstraints = false
        rightImageView.translatesAutoresizingMaskIntoConstraints = false

        // пишем свои
        NSLayoutConstraint.activate([
            middleImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            middleImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            middleImageView.heightAnchor.constraint(equalTo: middleImageView.widthAnchor, multiplier: 1),
            middleImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            leftImageView.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10), // выступает на 10 из-за левого края экрана
            leftImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            leftImageView.heightAnchor.constraint(equalTo: middleImageView.heightAnchor),
            leftImageView.widthAnchor.constraint(equalTo: middleImageView.widthAnchor),

            rightImageView.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10), // выступает на 10 из-за правого края экрана
            rightImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rightImageView.heightAnchor.constraint(equalTo: middleImageView.heightAnchor),
            rightImageView.widthAnchor.constraint(equalTo: middleImageView.widthAnchor),
        ])

        middleImageView.layer.cornerRadius = 8
        rightImageView.layer.cornerRadius = 8
        leftImageView.layer.cornerRadius = 8

        middleImageView.clipsToBounds = true
        rightImageView.clipsToBounds = true
        leftImageView.clipsToBounds = true

        // изначально уменьшаем картинки, чтобы их потом можно было увеличить, СGAffineTransform имеет св-во .identity и можно вернуть к оригиналу
        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)

        self.middleImageView.transform = scale
        self.rightImageView.transform = scale
        self.leftImageView.transform = scale

    }

    func startAnimate() {
        setImage()
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: [],
                       animations: { [unowned self] in
            self.middleImageView.transform = .identity
            self.leftImageView.transform = .identity
            self.rightImageView.transform = .identity
        })
    }

    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            swipeToRight = UIViewPropertyAnimator(duration: 1,
                                                  curve: .easeInOut,
                                                  animations: {
                UIView.animate(withDuration: 0.01,
                               delay: 0,
                               options: [],
                               animations: { [unowned self] in
                    let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    let translation = CGAffineTransform(translationX: self.view.bounds.maxX - 40, y: 0)
                    let transform = scale.concatenating(translation)
                    middleImageView.transform = transform
                    leftImageView.transform = transform
                    rightImageView.transform = transform
                },
                               completion: { [unowned self] _ in
                    self.selectedPhoto -= 1
                    if self.selectedPhoto < 0 {
                        self.selectedPhoto = self.photos.count - 1
                    }
                    self.startAnimate()
                })
            })
            swipeToLeft = UIViewPropertyAnimator(duration: 1,
                                                 curve: .easeInOut,
                                                 animations: {
                UIView.animate(withDuration: 0.01,
                               delay: 0,
                               options: [],
                               animations: { [unowned self] in
                    let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    let translation = CGAffineTransform(translationX: -self.view.bounds.maxX + 40, y: 0)
                    let transform = scale.concatenating(translation)
                    middleImageView.transform = transform
                    leftImageView.transform = transform
                    rightImageView.transform = transform
                },
                               completion: { [unowned self] _ in
                    self.selectedPhoto += 1
                    if self.selectedPhoto > self.photos.count - 1 {
                        self.selectedPhoto = 0
                    }
                    self.startAnimate()
                })
            })
        case .changed:
            let translationX = recognizer.translation(in: self.view).x
            if translationX > 0 {
                swipeToRight.fractionComplete = abs(translationX)/100
            } else {
                swipeToLeft.fractionComplete = abs(translationX)/100
            }
        case .ended:
            swipeToRight.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            swipeToLeft.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            return
        }
    }
}

