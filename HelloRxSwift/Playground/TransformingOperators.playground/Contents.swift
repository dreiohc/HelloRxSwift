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


// MARK: - Transforming Operators

//: ToArray. Transforms values into array.

header("ToArray")

Observable.of(1,2,3,4,5)
  .toArray()
  .subscribe(onNext: { print($0)} )
  .disposed(by: disposeBag)


//: Map. Transform depending on the condition.

header("Map")

Observable.of(2,4,3)
  .map { $0 * 2}
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)


//: Flat Map. Track all previous values everytime you accept or mutate an observable.

header("FlatMap")

struct Student {
  var score: BehaviorRelay<Int>
  
}

let john1 = Student(score: BehaviorRelay(value: 75))
let mary1 = Student(score: BehaviorRelay(value: 90))

let studentFlatMap = PublishSubject<Student>()

studentFlatMap.asObservable()
  .flatMap { $0.score.asObservable() }
  .subscribe(onNext: { print($0)})
  .disposed(by: disposeBag)

studentFlatMap.onNext(john1)
john1.score.accept(100)

studentFlatMap.onNext(mary1)
john1.score.accept(80)

john1.score.accept(43)


//: Flat Map Latest

header("FlatMapLatest")

let john2 = Student(score: BehaviorRelay(value: 75))
let mary2 = Student(score: BehaviorRelay(value: 90))

let studentFlatMapLatest = PublishSubject<Student>()

studentFlatMapLatest.asObservable()
  .flatMapLatest { $0.score.asObservable() }
  .subscribe(onNext: { print($0)})
  .disposed(by: disposeBag)

studentFlatMapLatest.onNext(john2)
john2.score.accept(100)


studentFlatMapLatest.onNext(mary2) // Latest Observable.
john2.score.accept(45) // This is ignored because only the latest observable is observed by flatMapLatest.

