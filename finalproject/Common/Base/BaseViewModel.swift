import RxSwift

/**
 A common ViewModel class
 */
class BaseViewModel {
    
    /// Base output state
    struct BaseOutput {
        let alert : PublishSubject<String>
        let loading : PublishSubject<Bool>
    }
    
    /// DisposeBag for observable
    let disposeBag = DisposeBag()
    
    /// BaseOutput
    let base:BaseOutput
    
    init() {
        base = BaseOutput(alert: PublishSubject<String>(), loading: PublishSubject<Bool>())
    }
    
    /// show/hide loading
    func loading(_ show:Bool) {
        base.loading.onNext(show)
    }
    
    func alert(_ message:String) {
        base.alert.onNext(message)
    }
}
