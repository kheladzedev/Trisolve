//
//  LevelSelectViewController.swift
//  TriSolve
//
//  Created by Edward on 03.04.2025.
//

import UIKit

class LevelSelectViewController: UIViewController {

    private let customNavBar = CustomNavigationBar(title: "LEVEL SELECT")

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        collectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        customNavBar.translatesAutoresizingMaskIntoConstraints = false
        customNavBar.setBackButtonAction(target: self, action: #selector(backTapped))
        view.addSubview(customNavBar)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LevelCell.self, forCellWithReuseIdentifier: "LevelCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            customNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: 60),

            collectionView.topAnchor.constraint(equalTo: customNavBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension LevelSelectViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return levels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LevelCell", for: indexPath) as! LevelCell
        let isUnlocked = completedLevels.contains(indexPath.item) || indexPath.item == 0
        let level = levels[indexPath.item]
        cell.configure(with: indexPath.item + 1, difficulty: level.difficulty, isLocked: !isUnlocked)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard completedLevels.contains(indexPath.item) || indexPath.item == 0 else { return }
        let selectedLevel = levels[indexPath.item]
        let gameVC = GameViewController()
        gameVC.currentLevelIndex = indexPath.item
        gameVC.currentLevel = selectedLevel
        navigationController?.pushViewController(gameVC, animated: true)
    }
}

class LevelCell: UICollectionViewCell {
    private let label = UILabel()
    private let difficultyLabel = UILabel()
    private let lockImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBlue
        contentView.layer.cornerRadius = 12

        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)

        difficultyLabel.font = UIFont.systemFont(ofSize: 14)
        difficultyLabel.textColor = .white
        difficultyLabel.textAlignment = .center
        difficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(difficultyLabel)

        lockImageView.image = UIImage(systemName: "lock.fill")
        lockImageView.tintColor = .white
        lockImageView.contentMode = .scaleAspectFit
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lockImageView)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),

            difficultyLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            difficultyLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 4),

            lockImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            lockImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lockImageView.widthAnchor.constraint(equalToConstant: 24),
            lockImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with number: Int, difficulty: Int, isLocked: Bool) {
        label.text = "\(number)"
        difficultyLabel.text = String(repeating: "⭐", count: difficulty)
        lockImageView.isHidden = !isLocked
        contentView.alpha = isLocked ? 0.5 : 1.0
    }
}
