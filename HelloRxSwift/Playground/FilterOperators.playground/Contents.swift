import UIKit
import RxSwift
import PlaygroundSupport

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

let disposeBag = DisposeBag()

strikes
  .ignoreElements()
  .subscribe { print("subscription is called") }
  .disposed(by: disposeBag)

strikes.onNext("A")
strikes.onNext("B")
strikes.onNext("C")

strikes.onCompleted() // will only call "subscription is called" after calling onCompleted().


//: Element At

header("Element At")

strikes
  .elementAt(2)
  .subscribe(onNext: { _ in print("you are out") })
  .disposed(by: disposeBag)


strikes.onNext("X")
strikes.onNext("X")
strikes.onNext("X") // Will only call after nth time of elementAt


//: Filter

header("Filter")
  

