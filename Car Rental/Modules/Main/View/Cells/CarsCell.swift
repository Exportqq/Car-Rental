import UIKit

final class CarsCell: UICollectionViewCell {
    
    let card = CarsCardView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = false
        contentView.clipsToBounds = false
        
        contentView.addSubview(card)
        card.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: contentView.topAnchor),
            card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
