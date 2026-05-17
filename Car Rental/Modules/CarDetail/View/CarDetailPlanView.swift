import UIKit

class CarDetailPlanView: UIView {
    
    var onPlanSelected: ((String?) -> Void)?
    
    private(set) var selectedPlan: String? = "hourly"
                
    private var selectedCard: PlansCardView?
    
    private let hourlyCard = PlansCardView()
    
    private let dailyCard = PlansCardView()
    
    private let planTitle: UILabel = {
        let label = UILabel()
        label.text = "Plan"
        label.font = UIFont(name: "Roboto-Bold", size: 18)
        label.textColor = .textBlack
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.alwaysBounceHorizontal = true
        return scroll
    }()
    
    private lazy var plansStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [hourlyCard, dailyCard])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupGestures()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(planTitle)
        addSubview(scrollView)
        scrollView.addSubview(plansStack)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 32)
    }
    
    private func setupConstrains() {
        [planTitle, plansStack, scrollView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [hourlyCard, dailyCard].forEach {
            $0.heightAnchor.constraint(equalToConstant: 80).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 180).isActive = true
        }
        
        NSLayoutConstraint.activate([
            planTitle.topAnchor.constraint(equalTo: self.topAnchor),
            planTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: planTitle.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 80),

            plansStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            plansStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            plansStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            plansStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),

            plansStack.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        ])
    }
    
    func configure(priceHourly: Int, priceDaily: Int) {
        hourlyCard.configure(icon: UIImage(named: "hourly"), price: "$\(priceHourly)", title: "Hourly Rent", text: "Best for business appointments")
        
        dailyCard.configure(icon: UIImage(named: "daily"), price: "$\(priceDaily)", title: "Daily Rent", text: "Best for travel")
    }
    
    @objc private func planTapped(_ sender: UITapGestureRecognizer) {
            
        guard let tappedCard = sender.view as? PlansCardView else {
            return
        }
        
//        // Если нажали на уже выбранную карточку
//        if selectedCard == tappedCard {
//            
//            tappedCard.setSelected(false)
//            selectedCard = nil
//            
//            onPlanSelected?(nil)
//            
//            return
//        }
        
        guard selectedCard !== tappedCard else {
           return
       }
        
        // Снимаем выделение со старой
        selectedCard?.setSelected(false)
        
        // Выделяем новую
        tappedCard.setSelected(true)
        selectedCard = tappedCard
        
        // Определяем выбранный план
        let plan: String
        
        switch tappedCard.tag {
        case 0:
            plan = "hourly"
            
        case 1:
            plan = "daily"
            
        default:
            return
        }
        
        selectedPlan = plan
        onPlanSelected?(plan)
    }
    
    private func setupGestures() {
        
        hourlyCard.tag = 0
        dailyCard.tag = 1
        
        [hourlyCard, dailyCard].forEach {
            
            $0.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(
                target: self,
                action: #selector(planTapped(_:))
            )
            
            $0.addGestureRecognizer(tap)
        }
        
        // изначально выбранная карточка
        hourlyCard.setSelected(true)
        selectedCard = hourlyCard
        
        onPlanSelected?("hourly")
    }
}

