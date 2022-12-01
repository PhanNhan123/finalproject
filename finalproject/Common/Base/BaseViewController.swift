
import UIKit
import RxSwift
import RxCocoa

/**
 A common ViewController class
 */
class BaseViewController<VM:BaseViewModel>: UIViewController {
    
    /// Indicator view
    let activityIndicator = UIActivityIndicatorView()
    
    /// Navigator
    let navigator = Navigator()
    
    /// DisposeBag for observable
    let disposeBag = DisposeBag()
    
    /// ViewModel
    var viewModel: VM!
    
    /// Setup UI
    func setupUI(){}
    
    /// Setup view model bindings
    func setupViewModel(){}
    
    /// Load data on the first time
    func setupData(){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
        setupBaseBindings()
        setupData()
    }
    
    /// binding common view state
    private func setupBaseBindings() {
        /// binding alert
        viewModel?.base.alert
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] (message) in
//                    self?.alert(msg: message)
                    print("message")
                }
        )
            .disposed(by: disposeBag)
    }
    
    /// Show or hide loading indicator
    func showIndicator(_ show: Bool) {
        view.isUserInteractionEnabled = !show
        guard show else {
            activityIndicator.removeFromSuperview()
            return
        }
        if activityIndicator.superview == nil {
            view.addSubview(activityIndicator)
        }
        activityIndicator.color = .black
        activityIndicator.frame = view.bounds
        activityIndicator.startAnimating()
    }
    
}

