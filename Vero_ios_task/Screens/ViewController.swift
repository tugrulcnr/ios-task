//
//  ViewController.swift
//  Vero_ios_task
//
//  Created by ertugrul on 4.03.2024.
//
import UIKit

class ViewController: UIViewController {

    let viewModel = TaskViewModel()

        let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.backgroundColor = .systemBackground
            return collectionView
        }()

        let searchBar: UISearchBar = {
            let searchBar = UISearchBar()
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            searchBar.placeholder = "Search"
            return searchBar
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            setupSearchBar()
            setupCollectionView()
            viewModel.loadTasks { result in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }

        private func setupSearchBar() {
            searchBar.delegate = self
            view.addSubview(searchBar)

            NSLayoutConstraint.activate([
                searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }

        private func setupCollectionView() {
            collectionView.register(TaskCollectionViewCell.self, forCellWithReuseIdentifier: TaskCollectionViewCell.reuseIdentifier)
            collectionView.dataSource = self
            collectionView.delegate = self

            view.addSubview(collectionView)

            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.minimumInteritemSpacing = 10
                layout.minimumLineSpacing = 10
                layout.itemSize = CGSize(width: view.bounds.width - 20, height: 100)
            }
        }
    }





