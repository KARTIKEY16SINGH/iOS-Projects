//
//  PropertyTableViewCell.swift
//  GoMmt
//
//  Created by Iron Man on 11/04/21.
//

import UIKit

class PropertyTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView : UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
    }
    
    private func setupViews() {
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FacilityCollectionViewCell", bundle: Bundle(for: PropertyTableViewCell.self)), forCellWithReuseIdentifier: "facilityCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension PropertyTableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: "facilityCell", for: indexPath)
    }
}

extension PropertyTableViewCell : UICollectionViewDelegate {
    
}
