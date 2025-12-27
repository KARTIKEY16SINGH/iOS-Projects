import UIKit

// MARK: The String Sanitizer

struct Profile {
    var firstName: String {
        didSet {
            print("FirstName didset")
            var value = firstName.trimmingCharacters(in: .whitespaces)
            firstName = value.capitalized
        }
    }
    var lastName: String {
        didSet {
            print("lastName didset")
            var value = lastName.trimmingCharacters(in: .whitespaces)
            lastName = value.capitalized
        }
    }
    
    @Sanitized(policy: .capatalized) var newFirstName: String = ""
    @Sanitized(policy: .capatalized) var newLastName: String = ""
}

var profile = Profile(firstName: " tim ", lastName: " apple ", newFirstName: " tim ", newLastName: " apple ")

dump(profile)

@propertyWrapper
struct Sanitized {
    private var value: String
    var policy: Policy
    var wrappedValue: String {
        get {
            value
        }
        set {
            print("Sanitized Wrapped Value set")
            var trimmedValue = newValue.trimmingCharacters(in: .whitespaces)
            switch policy {
            case .upperCase:
                value = trimmedValue.uppercased()
            case .capatalized:
                value = trimmedValue.capitalized
            case .lowerCase:
                value = trimmedValue.lowercased()
            case .none:
                value = trimmedValue
            }
        }
    }
    
    init(wrappedValue: String, policy: Policy) {
        self.policy = policy
        self.value = ""
        self.wrappedValue = wrappedValue
    }
    
    enum Policy {
        case upperCase
        case capatalized
        case lowerCase
        case none
    }
}


// MARK: The Range Guardian

struct Player {
    var health: Int {
        didSet {
            print("Player health did set")
            if health < 0 { health = 0 }
            if health > 100 { health = 100 }
        }
    }
    
    @Clamped(range: 0...50) var mana: Int = 10
    
    @Clamped(range: -1000...1000) var score: Int = 0
    
    init() {
        health = 0
    }
}

var player = Player()
dump(player)

player.health = 150
player.score = 2000
player.mana = 100
dump(player)

player.health = -20
player.score = -2000
player.mana = -5
dump(player)

@propertyWrapper
struct Clamped<Value: Comparable> {
    private var _value: Value
    private var range: ClosedRange<Value>
    var wrappedValue: Value {
        get {
            _value
        }
        set {
            _value = min(max(range.lowerBound, newValue), range.upperBound)
        }
    }
    
    init(wrappedValue: Value, range: ClosedRange<Value>) {
        self.range = range
        self._value = range.lowerBound
        self.wrappedValue = wrappedValue
    }
}


// MARK: The Persistent Storage

struct Settings {
    var isDarkModeEnabled: Bool {
        willSet {
            UserDefaults.standard.set(newValue, forKey: "isDarkModeEnabled")
        }
    }
    
    var appVolume: Double {
        willSet {
            UserDefaults.standard.set(newValue, forKey: "appVolume")
        }
    }
    
    @Storage var sexCount: Int
    
    @Storage(key: "penisSize", defaultValue: 0) var penisSize: Int
    
    init() {
        self.isDarkModeEnabled = UserDefaults.standard.bool(forKey: "isDarkModeEnabled")
        self.appVolume = UserDefaults.standard.double(forKey: "appVolume")
        self._sexCount = .init(key: "sexCount", defaultValue: 0)
    }
}

var setting = Settings()

dump(setting)

setting.isDarkModeEnabled = true
setting.appVolume = 10
setting.sexCount = -10000
setting.penisSize = 10

dump(setting)

@propertyWrapper
struct Storage<T> {
    private let key: String
    private let defaultValue: T
    private var _value: T
    var wrappedValue: T {
        get {
            (UserDefaults.standard.object(forKey: key) as? T) ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
            _value = newValue
        }
    }
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
        self._value = defaultValue
        self.wrappedValue = defaultValue
    }
}

// MARK: The Change Tracker

struct Document {
    var isTextDirty: Bool = false
    var text: String {
        didSet {
            isTextDirty = true
        }
    }
    
    @Tracked var loveLetter: String
}

var doc = Document(text: "", loveLetter: "")
dump(doc)

doc.text = "Googel gemini does not have a penis"
doc.loveLetter = "Chat gpt hates you Gemini"
dump(doc)
dump(doc.loveLetter)
dump(doc.$loveLetter)

@propertyWrapper
struct Tracked<Value> {
    private var isDirty: Bool = false
    var wrappedValue: Value {
        didSet {
            isDirty = true
        }
    }
    var projectedValue: Bool { return isDirty }
    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}

// MARK: The Thread-Safe Property

final class Counter {
    private var _count: Int = 0
    
    var count: Int {
        get {
            safeQueue.sync {
                _count
            }
        }
        set {
            safeQueue.sync {
                _count = newValue
            }
        }
    }
    
    @Atomic var fuckCount: Int = 0
    
    private let safeQueue = DispatchQueue(label: "safe.queue", attributes: .concurrent)
}

@propertyWrapper
struct Atomic<Value> {
    private var queue: DispatchQueue
    private var _value: Value
    var wrappedValue: Value {
        get {
            queue.sync {
                _value
            }
        }
        set {
            print("Inside property wrapper set newValue = \(newValue)")
            queue.sync(flags: .barrier) {
                _value = newValue
            }
        }
    }
    
    init(wrappedValue: Value, queue: DispatchQueue = .init(label: "safe.queue", attributes: .concurrent)) {
        self._value = wrappedValue
        self.queue = queue
        self.wrappedValue = wrappedValue
    }
}

let counter = Counter()
dump(counter)
dump(counter.count)
dump(counter.fuckCount)

counter.count = 10
counter.fuckCount = 10
dump(counter)
dump(counter.count)
dump(counter.fuckCount)


struct Registration {
    @Atomic @Sanitized(wrappedValue: "", policy: .capatalized) var userName: String
    @Atomic @Clamped(range: 18...100) var age: Int = 18
    @Atomic @Tracked var isAgreedToTerms: Bool = false
    @Atomic @Storage(key: "reg_attempts", defaultValue: 0) var sessionCount: Int
}

/*
 
 I am not getting any compile error in following code
 
 @propertyWrapper
 struct Atomic<Value> {
 private var queue: DispatchQueue
 private var _value: Value
 private var myBool = false
 var wrappedValue: Value
 }
 
 
 but I am getting error in following code
 
 @propertyWrapper
 struct Tracked<Value> {
 private var isDirty = false
 var wrappedValue: Value
 }
 
 can you tell why its happening ?
 
 */



// MARK: My own State & Binding propertyWrapper

protocol MyDynamicProperty {
    func update()
}

protocol SomeRandomeProtocol {
    associatedtype SomeRandomType
    var someRandomProperty: SomeRandomType {get nonmutating set}
}


final class StateBox<Value> {
    var stateValue: Value
    
    init(_ stateValue: Value) {
        self.stateValue = stateValue
    }
}

@propertyWrapper
struct MyState<Value>: MyDynamicProperty {
    private var value: StateBox<Value>
    
    var wrappedValue: Value {
        get {
            self.value.stateValue
        }
        nonmutating set {
            self.value.stateValue = newValue
            print("Redrawing UI because MyState changed to: \(newValue)")
        }
    }
    
    var projectedValue: MyBinding<Value> {
        .init {
            self.wrappedValue
        } setter: { newValue in
            self.wrappedValue = newValue
        }

    }
    
    init(wrappedValue: Value) {
        self.value = StateBox(wrappedValue)
    }
    
    func update() {
        
    }
}

@propertyWrapper
struct MyBinding<Value> {
    private let getter: () -> Value
    private let setter: (Value) -> Void
    
    var wrappedValue: Value {
        get { getter() }
        set { setter(newValue) }
    }
    
    init(getter: @escaping () -> Value, setter: @escaping (Value) -> Void) {
        self.getter = getter
        self.setter = setter
    }
}


struct MyView {
    @MyState var count = 0
    
    func simulateUserTyping() {
        var detailView = MyDetailView(sharedCount: $count)
        detailView.userTappedPlusButton()
    }
}

struct MyDetailView {
    @MyBinding var sharedCount: Int
    
    mutating func userTappedPlusButton() {
        sharedCount += 1
    }
}

let view = MyView()

view.simulateUserTyping()
view.simulateUserTyping()

struct FailingStruct: SomeRandomeProtocol {
    typealias SomeRandomType = StateBox<Int>
    
    var someRandomProperty: StateBox<Int> {
        get {
            return .init(0)
        }
        nonmutating set {
            someRandomProperty.stateValue = newValue.stateValue
        }
    } // ERROR: Does not satisfy 'nonmutating set'
}
