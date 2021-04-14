import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport


func header(_ title: String) {
  print("\n\n")
  print("---------------------------------------------------------------------------------------------")
  print("                                           \(title)                                          ")
  print("---------------------------------------------------------------------------------------------")
}


// MARK: - Subjects. Observable as well as the observer

let disposeBag = DisposeBag()



//: Publish Subject

header("Publish Subject")

let publishSubject = PublishSubject<String>()

publishSubject.onNext("publishSubject Issue 1") // no action here yet.

publishSubject.subscribe { print($0) }

publishSubject.onNext("publishSubject Issue 2")
publishSubject.onNext("publishSubject Issue 3") // will only proceed once subscribed.

publishSubject.dispose() // after this nothing shall be called. including the onCompleted().


publishSubject.onCompleted()
publishSubject.onNext("publishSubject Issue 4") // This will not be called cause it's after onCompleted().




//: Behavior Subject. You need to pass a value first. Cause the initial/last value shall also be passed.

header("Behavior Subject")

let behaviorSubject = BehaviorSubject(value: "behaviorSubject Initial Value")

behaviorSubject.onNext("behaviorSubject Last Issue")

behaviorSubject.subscribe { print($0) }

behaviorSubject.onNext("behaviorSubject Issue 1")


//: Replay Subject

header("Replay Subject")

let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

replaySubject.onNext("replaySubject Issue 1")
replaySubject.onNext("replaySubject Issue 2")
replaySubject.onNext("replaySubject Issue 3") // This will not be called cause of the bufferSize value 2.

replaySubject.subscribe{ print($0) }

replaySubject.onNext("replaySubject Issue 4")
replaySubject.onNext("replaySubject Issue 5")
replaySubject.onNext("replaySubject Issue 6")

print("Subscription 2")

replaySubject.subscribe{ print($0) } // Only the last 2 (Issue 5 and 6) are replayed.



//: Variables - Deprecated. Will be replaced by Behavior Relay.

header("Variables")

let variable = Variable([String]())

variable.value.append("Variable Item 1")


variable.asObservable()
  .subscribe { print($0) }


variable.value.append("Variable Item 2") // Previous values are still passed everytime variable value has changed.


//: Behavior Relay - Only available in RxCocoa

header("Behavior Relay")

let behaviorRelay = BehaviorRelay(value: ["Item 1"])

// behaviorRelay.value.append("Item 1") // not allowed

behaviorRelay.accept(["Item 2"]) // Only accept works when mutating/appending values.

behaviorRelay.accept(behaviorRelay.value + ["Item 3"]) // Style A of appending

var value = behaviorRelay.value // Style b of appending. Same with A in functionality.
value.append("Item 4")
value.append("Item 5")
behaviorRelay.accept(value)


behaviorRelay.asObservable()
  .subscribe { print($0) }

//behaviorRelay.value = "Hello world"  // not allowed to change. value is always immutable.


