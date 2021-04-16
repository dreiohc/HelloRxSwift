import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

func header(_ title: String) {
  print("\n\n")
  print("---------------------------------------------------------------------------------------------")
  print("                                           \(title)                                          ")
  print("---------------------------------------------------------------------------------------------")
}

// MARK: - Combining Operators

//: Starts with

header("startwith")

let numbers = Observable.of(2,3,4)

let observable = numbers.startWith(1)
observable
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)


//: Concat

header("concat")

let first = Observable.of(1,2,3)
let second = Observable.of(4,5,6)

let observable2 = Observable.concat([first, second])

observable2
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)


//: Merge. Depends on the order/timing the elements will be merge.

header("merge")

let left = PublishSubject<Int>()
let right = PublishSubject<Int>()

let source = Observable.of(left.asObservable(), right.asObservable())

let observable3 = source.merge()
observable3
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

left.onNext(5)
left.onNext(3)
right.onNext(2)
right.onNext(1)
left.onNext(8)  // Merges all values depending on the order.


//: Combine Latest
header("combineLatest")

let left1 = PublishSubject<Int>()
let right1 = PublishSubject<Int>()

let observable4 = Observable.combineLatest(left1, right1) { (lastLeft, lastRight) in
  print(lastLeft, lastRight)
}

let disposable = observable4.subscribe(onNext: { value in
  print(value)
})

left1.onNext(45)
right1.onNext(1)
left1.onNext(30)
right1.onNext(99)
right1.onNext(2) // always get the latest value on each sequence.


//: With Latest From. Mainly for UI. Get's the latest value.

header("withLatestFrom")

let button = PublishSubject<Void>()
let textField = PublishSubject<String>()

let observable5 = button.withLatestFrom(textField)
let disposable1 = observable5
  .subscribe(onNext: { print($0) })

textField.onNext("Sw")
textField.onNext("Swif")
textField.onNext("Swift")
textField.onNext("Swift Rocks!")

button.onNext(())


//: Reduce. Reduce a sequence to a single value.

header("reduce")

let source1 = Observable.of(1,2,3)

source1                               // Style A.
  .reduce(0, accumulator: +)
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)


source1
  .reduce(0, accumulator: { sum, newValue in    // Style B. Longhand version of A.
    return sum + newValue
  })
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)


//: Scan. Close cousin of reduce operator. Gives all the values including the total.

header("scan")

let source2 = Observable.of(1,2,3,5,6)

source2                                 // Style A.
  .scan(0, accumulator: +)
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

source2                                 // Style B.
  .scan(0, accumulator: { total, newValue in
    return total + newValue
  })
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

