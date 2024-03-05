//
//  ViewController+Ext.swift
//  Vero_ios_task
//
//  Created by ertugrul on 5.03.2024.
//

import UIKit

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfTasks
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCollectionViewCell.reuseIdentifier, for: indexPath) as! TaskCollectionViewCell
            let task = viewModel.task(at: indexPath.row)
            cell.configure(with: task)
            return cell
    }
}

extension ViewController: UICollectionViewDelegate {
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterTasks(with: searchText)
        collectionView.reloadData()
    }
}

