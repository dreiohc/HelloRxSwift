import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

let relay = BehaviorRelay(value: ["item 0"])

//relay.accept(relay.value + ["item 1"])
var value = relay.value
value.append("item 1")
value.append("item 2")
relay.accept(value)


relay.asObservable()
  .subscribe { print($0) }



