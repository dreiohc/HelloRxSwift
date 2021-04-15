import UIKit
import RxSwift
import PlaygroundSupport

let disposeBag = DisposeBag()


func header(_ title: String) {
  print("\n\n")
  print("---------------------------------------------------------------------------------------------")
  print("                                           \(title)                                          ")
  print("---------------------------------------------------------------------------------------------")
}


// MARK: - Filtering Operators

//: Ignore Elements

header("Ignore Elements")

let strikes = PublishSubject<String>()

strikes
  .ignoreElements()
  .subscribe { print("subscription is called") }
  .disposed(by: disposeBag)

strikes.onNext("A")
strikes.onNext("B")
strikes.onNext("C")

strikes.onCompleted()       // will only call "subscription is called" after calling onCompleted().


//: Element At

header("Element At")

strikes
  .elementAt(2)
  .subscribe(onNext: { _ in print("you are out") })
  .disposed(by: disposeBag)


strikes.onNext("X")
strikes.onNext("X")
strikes.onNext("X")                           // Will only call after nth time of elementAt


//: Filter

header("Filter")
  
Observable.of(1,2,3,4,5,6,7,8)
  .filter { $0 % 2 == 0 }                     // only even numbers will be passed.
  .subscribe(onNext: { print($0)} )
  .disposed(by: disposeBag)


//: Skip Operator

header("Skip")

Observable.of("A", "B", "C", "D", "E", "F")
  .skip(3)                                    // skip first 3 items.
  .subscribe(onNext: { print($0)})
  .disposed(by: disposeBag)


//: Skip While. Will execute until the condition is met.

header("Skip While")

Observable.of(2,2,3,4,4)
  .skipWhile { $0 % 2 == 0 }                // It printed the value once the condition is false.
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)


//: Skip Until. Will pass until the trigger is called.

header("Skip Until")

let skipUntilSubject = PublishSubject<String>()
let trigger = PublishSubject<String>()

skipUntilSubject.skipUntil(trigger)
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

skipUntilSubject.onNext("A")
skipUntilSubject.onNext("B")

trigger.onNext("X")             // Trigger assigned.

skipUntilSubject.onNext("C")    // This will be printed out because the trigger is already provided.


//: Take

header("Take")

Observable.of(1,2,3,4,5,6)
  .take(3)                      // Only first 3 will be printed.
  .subscribe(onNext: { print($0)})
  .disposed(by: disposeBag)


//: Take while. Take values while condition is true.

header("Take while")

Observable.of(2,4,6,7,8,10)
  .takeWhile { $0 % 2 == 0 } // value 7 broke the condition therefore 8 and 10 will not be printed.
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)


//: Take Until. Similar to Skip Until.

header("Take Until")

let takeUntilSubject = PublishSubject<String>()
let takeUntiltrigger = PublishSubject<String>()

takeUntilSubject.takeUntil(takeUntiltrigger)
  .subscribe(onNext: { print($0)})
  .disposed(by: disposeBag)

takeUntilSubject.onNext("1")
takeUntilSubject.onNext("2")

takeUntiltrigger.onNext("X")          // trigger called.

takeUntilSubject.onNext("3")          // not called due to trigger.
