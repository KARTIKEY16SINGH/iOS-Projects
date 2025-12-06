import UIKit

//MARK: Type change and Name changes

//struct User: Decodable {
//    let id: Int
//    let name: String
//    let contacts: Contacts
//    let roles: [String]
//    let settings: ConfigSettings
//    
//    enum CodingKeys: String, CodingKey {
//        case id = "user_id"
//        case name = "full_name"
//        case contacts
//        case roles
//        case settings
//    }
//}
//
//struct Contacts: Decodable {
//    let email: String
//    let phone: String?
//}
//
//struct ConfigSettings: Decodable {
//    let notificationsEnabled: Bool
//    let theme: Theme
//    
//    enum CodingKeys: String, CodingKey {
//        case notificationsEnabled = "notifications"
//        case theme
//    }
//}
//
//enum Theme: String, Decodable {
//    case dark
//    case light
//}
//
//let jsonString = """
//{
//  "user_id": 12345,
//  "full_name": "Alice Doe",
//  "contacts": {
//    "email": "alice@example.com",
//    "phone": null
//  },
//  "roles": ["admin", "editor"],
//  "settings": {
//    "notifications": true,
//    "theme": "dark"
//  }
//}
//"""
//
//
//let data = jsonString.data(using: .utf8)!
//let user = try JSONDecoder().decode(User.self, from: data)
//print(user)
//print(user.settings.theme)


//MARK: Dynamic keys

//struct User: Decodable {
//    let id: Int
//    let name: String
//    let age: Int?
//}
//
//struct UserInfo: Decodable {
//    let key: String
//    let user: User
//}
//
//struct Users: Decodable {
//    let users: [UserInfo]
//    
//    struct CodingKeys: CodingKey {
//        var intValue: Int?
//        
//        init?(intValue: Int) {
//            self.intValue = intValue
//            self.stringValue = "\(intValue)"
//        }
//        
//        var stringValue: String
//        
//        init?(stringValue: String) {
//            self.stringValue = stringValue
//            self.intValue = nil
//        }
//    }
//    
//    init(from decoder: any Decoder) throws {
//        do {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//            let keys = container.allKeys.sorted { keyOne, keyTwo in
//                keyOne.stringValue < keyTwo.stringValue
//            }
//            var result: [UserInfo] = []
//            for key in keys {
//                let value = try container.decode(User.self, forKey: key)
//                let userInfo = UserInfo(key: key.stringValue, user: value)
//                result.append(userInfo)
//            }
//            users = result
//            return
//        } catch let error {
//            debugPrint(error)
//        }
//        users = []
//    }
//}
//
//struct Response: Decodable {
//    let status: String
//    let data: DataContainer
//}
//
//struct DataContainer: Decodable {
//    let users: Users
//    let count: Int
//}
//
//let dynamicJsonString = """
//{
//  "status": "ok",
//  "data": {
//    "users": {
//      "user_1": {
//        "id": 1,
//        "name": "Alice",
//        "age": 25
//      },
//      "user_2": {
//        "id": 2,
//        "name": "Bob",
//        "age": 30
//      },
//      "user_3": {
//        "id": 3,
//        "name": "Charlie",
//        "age": null
//      }
//    },
//    "count": 3
//  }
//}
//"""
//
//
//let data = dynamicJsonString.data(using: .utf8)!
//let response = try JSONDecoder().decode(Response.self, from: data)
//print(response)   // should be sorted [user1, user2, user3]
//

//MARK: MIXED TYPE

//enum ItemType: String, Decodable {
//    case text
//    case image
//    case video
//}
//protocol BaseItem {
//    var type: String {get}
//    var id: String {get}
//}
//
//protocol TextType: BaseItem {
//    var content: String {get}
//}
//
//protocol MediaItemable: BaseItem {
//    var url: String {get}
//}
//
//protocol ImageType: MediaItemable {
//    var width: Double {get}
//    var height: Double {get}
//}
//
//protocol VideoType: MediaItemable {
//    var duration: Double {get}
//}
//
//struct TextItem: TextType, Decodable {
//    let content: String
//    let type: String
//    let id: String
//}
//
//struct ImageItem: ImageType, Decodable {
//    let width: Double
//    
//    let height: Double
//    
//    let url: String
//    
//    let type: String
//    
//    let id: String
//}
//
//struct VideoItem: VideoType, Decodable {
//    let duration: Double
//    
//    let url: String
//    
//    let type: String
//    
//    let id: String
//}
//
//struct Response: Decodable {
//    let status: String
//    let items: [Item]
//}
//
//enum Item: Decodable {
//    case text(TextItem)
//    case image(ImageItem)
//    case video(VideoItem)
//    
//    enum CodingKeys: CodingKey {
//        case type
//    }
//    
//    enum TextCodingKeys: CodingKey {
//    }
//    
//    enum ImageCodingKeys: CodingKey {
//    }
//    
//    enum VideoCodingKeys: CodingKey {
//    }
//    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let itemType = try container.decode(ItemType.self, forKey: .type)
//        
//        switch itemType {
//        case .text:
//            self = .text(try TextItem(from: decoder))
//        case .image:
//            self = .image(try ImageItem(from: decoder))
//        case .video:
//            self = .video(try VideoItem(from: decoder))
//        }
//    }
//}
//
//
//let jsonString = """
//{
//  "status": "success",
//  "items": [
//    {
//      "type": "text",
//      "id": "t1",
//      "content": "Hello world!"
//    },
//    {
//      "type": "image",
//      "id": "i42",
//      "url": "https://cdn.example.com/img/42.png",
//      "width": 800,
//      "height": 600
//    },
//    {
//      "type": "text",
//      "id": "t2",
//      "content": "Another message"
//    },
//    {
//      "type": "video",
//      "id": "v9",
//      "url": "https://cdn.example.com/video/9.mp4",
//      "duration": 120
//    }
//  ]
//}
//"""
//
//let data = jsonString.data(using: .utf8)!
//
//do {
//    let response = try JSONDecoder().decode(Response.self, from: data)
//    print("Status:", response.status)
//    print("Items count:", response.items.count)
//    
//    for item in response.items {
//        switch item {
//        case let text as TextItem:
//            print("Text item:", text.id, "->", text.content)
//        case let image as ImageItem:
//            print("Image item:", image.id, "->", image.url, "(\(image.width)x\(image.height))")
//        case let video as VideoItem:
//            print("Video item:", video.id, "->", video.url, "duration:", video.duration)
//        default:
//            print("Unknown item type:", item)
//        }
//    }
//} catch {
//    print("Decoding failed:", error)
//}
//
//
//struct Product: Decodable {
//    let price: Double?
//    
//    enum CodingKeys: CodingKey {
//        case price
//    }
//    
//    init(from decoder: any Decoder) throws {
//        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else {
//            price = nil
//            return
//        }
//        
//        if let dobuleValue = try? container.decode(Double.self, forKey: CodingKeys.price) {
//            price = dobuleValue
//            return
//        }
//        
//        if let stringNum = try? container.decode(String.self, forKey: CodingKeys.price), let doubleValue = Double.init(<#T##text: StringProtocol##StringProtocol#>) {
//            price = doubleValue
//            return
//        }
//        price = nil
//        return
//    }
//}
//
//let jsonSamples = [
//    "{ \"price\": 199 }",
//    "{ \"price\": \"199\" }",
//    "{ \"price\": \"N/A\" }",
//    "{ \"price\": null }",
//    "{ }"
//]
//
//for (i, json) in jsonSamples.enumerated() {
//    let data = json.data(using: .utf8)!
//    let product = try! JSONDecoder().decode(Product.self, from: data)
//    print("Case \(i+1):", product.price as Any)
//}

//MARK: Polymorphism

//let samples = [
//"""
//{
//  "id": "p1",
//  "name": "Laptop",
//  "discount": { "type": "percentage", "value": 20 }
//}
//""",
//"""
//{
//  "id": "p2",
//  "name": "Phone",
//  "discount": { "type": "flat", "value": 5000, "currency": "INR" }
//}
//""",
//"""
//{
//  "id": "p3",
//  "name": "Table",
//  "discount": null
//}
//""",
//"""
//{
//  "id": "p4",
//  "name": "Chair"
//}
//"""
//]
//
//struct Product: Decodable {
//    let id: String
//    let name: String
//    let discount: Discount?
//}
//
//enum DiscountType: String, Decodable {
//    case percentage
//    case flat
//}
//
//enum Discount: Decodable {
//    case percentage(PercentageDiscount)
//    case flat(FlatDiscount)
//    
//    enum CodingKeys: CodingKey {
//        case type
//    }
//    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let type = try container.decode(DiscountType.self, forKey: CodingKeys.type)
//        
//        switch type {
//        case .percentage:
//            let discount = try PercentageDiscount(from: decoder)
//            self = .percentage(discount)
//        case .flat:
//            let discount = try FlatDiscount(from: decoder)
//            self = .flat(discount)
//        }
//    }
//}
//
//struct PercentageDiscount: Decodable {
//    let value: Double
//}
//
//struct FlatDiscount: Decodable {
//    let value: Double
//    let currency: String
//}
//
//
//
//for (i, json) in samples.enumerated() {
//    let data = json.data(using: .utf8)!
//    let product = try! JSONDecoder().decode(Product.self, from: data)
//    print("Case \(i+1):", product)
//}


// MARK: Each object can any number of properties, but we want decode them structed way

//let jsonString = """
//{
//  "items": [
//    {
//      "content": "Hello world!"
//    },
//    {
//      "url": "https://example.com/a.png",
//      "width": 800,
//      "height": 600
//    },
//    {
//      "url": "https://example.com/video.mp4",
//      "duration": 120
//    }
//  ]
//}
//"""
//
//
//struct Response: Decodable {
//    let items: [Item]
//}
//
//enum Item: Decodable {
//    case text(TextItem)
//    case image(ImageItem)
//    case video(VideoItem)
//    
//    init(from decoder: any Decoder) throws {
//        if let textItem = try? TextItem(from: decoder) {
//            self = .text(textItem)
//            return
//        }
//        
//        if let imageItem = try? ImageItem(from: decoder) {
//            self = .image(imageItem)
//            return
//        }
//        
//        if let videoItem = try? VideoItem(from: decoder) {
//            self = .video(videoItem)
//            return
//        }
//        
//        throw NSError(domain: "Invalid data", code: -1)
//    }
//}
//
//struct TextItem: Decodable {
//    let content: String
//}
//
//struct ImageItem: Decodable {
//    let url: String
//    let width: Int
//    let height: Int
//}
//
//struct VideoItem: Decodable {
//    let url: String
//    let duration: Int
//}
//
//let data = jsonString.data(using: .utf8)!
//let response = try JSONDecoder().decode(Response.self, from: data)
//
//for item in response.items {
//    switch item {
//    case .text(let t):
//        print("TEXT:", t.content)
//    case .image(let i):
//        print("IMAGE:", i.url, i.width, i.height)
//    case .video(let v):
//        print("VIDEO:", v.url, v.duration)
//    }
//}


//MARK: Decode a JSON array that contains different types

//let jsonString = """
//{
//  "items": [
//    "hello",
//    42,
//    { "id": 1, "name": "Alice" },
//    true,
//    null,
//    99.5,
//    "42",
//    "99.9"
//   ]
//}
//"""
//
//struct Response: Decodable {
//    let items: [AnyValue]
//}
//
//enum AnyValue: Decodable {
//    case string(String)
//    case int(Int)
//    case double(Double)
//    case bool(Bool)
//    case object(Person)
//    case null
//    
//    init(from decoder: any Decoder) throws {
//        if let person = try? Person(from: decoder) {
//            self = .object(person)
//            return
//        }
//        if let interger = try? Int(from: decoder) {
//            self = .int(interger)
//            return
//        }
//        if let double = try? Double(from: decoder) {
//            self = .double(double)
//            return
//        }
//        if let bool = try? Bool(from: decoder) {
//            self = .bool(bool)
//            return
//        }
//        if let string = try? String(from: decoder) {
//            self = .string(string)
//            return
//        }
//        self = .null
//    }
//}
//
//struct Person: Decodable {
//    let id: Int
//    let name: String
//}
//
//let data = jsonString.data(using: .utf8)!
//let response = try JSONDecoder().decode(Response.self, from: data)
//
//for item in response.items {
//    print(item)
//}

// MARK: Decoding Dates With Multiple Possible Formats

//let samples = [
//"""
//{ "createdAt": "2023-12-01T10:30:00Z" }
//""",
//"""
//{ "createdAt": "2023-12-01" }
//""",
//"""
//{ "createdAt": 1701425400 }
//""",
//"""
//{ "createdAt": 1701425400000 }
//""",
//"""
//{ "createdAt": "2023-12-01T10:30:00+05:30" }
//""",
//"""
//{ "createdAt": null }
//"""
//]
//
//func converToDate(date: String, format: String) -> Date? {
////    print("date = \(date), fomat -> \(format)")
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = format
//    return dateFormatter.date(from: date)
//}
//
//struct DateFormats {
//    let iSO8601: ISO8601DateFormatter = {
//        let formatter = ISO8601DateFormatter()
//        formatter.formatOptions = [
////            .withFractionalSeconds,
////            .withFullTime,
//            .withInternetDateTime,
//            .withColonSeparatorInTime
//        ]
//        return formatter
//    }()
//    
//    let stringFormat: DateFormatter = {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyy-MM-dd"
//        dateFormatter.locale = Locale(identifier: "en_US_P0SIX")
//        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
//        return dateFormatter
//    }()
//}
//
//struct Event: Decodable {
//    let createdAt: Date?
//    
//    enum CodingKeys: CodingKey {
//        case createdAt
//    }
//    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        if let dateString = try? container.decode(String.self, forKey: CodingKeys.createdAt) {
//            print("String value -> \(dateString)")
//            if let date = DateFormats().iSO8601.date(from: dateString) {
//                createdAt = date
//                return
//            }
//            if let date = DateFormats().stringFormat.date(from: dateString) {
//                createdAt = date
//                return
//            }
//        }
//        
//        if let timerInterval = try? container.decode(TimeInterval.self, forKey: CodingKeys.createdAt) {
//            print("timeInterval -> \(timerInterval)")
//            createdAt = Date(timeIntervalSince1970: timerInterval)
//            return
//        }
//        createdAt = nil
//        return
//    }
//}
//
//do {
//    for (i, json) in samples.enumerated() {
//        let data = json.data(using: .utf8)!
//        let event = try JSONDecoder().decode(Event.self, from: data)
//        print("Case \(i+1):", event.createdAt as Any)
//    }
//} catch {
//    print(error)
//}

// MARK: full recursive OneOf decoding problem

//let samples = [
//"""
//{ "key": "age", "value": 42 }
//""",
//"""
//{ "key": "status", "value": "active" }
//""",
//"""
//{ "key": "verified", "value": true }
//""",
//"""
//{
//  "key": "location",
//  "value": { "lat": 12.9, "lng": 77.5 }
//}
//""",
//"""
//{
//  "key": "tags",
//  "value": ["swift", 5, true]
//}
//""",
//"""
//{ "key": "optional", "value": null }
//"""
//]
//
//
//struct Field: Decodable {
//    let key: String
//    let value: FieldValue
//}
//
//enum FieldValue: Decodable {
//    case int(Int)
//    case double(Double)
//    case string(String)
//    case bool(Bool)
//    case object([String: FieldValue])
//    case array([FieldValue])
//    case null
//    
//    struct CodingKeys: CodingKey {
//        init?(intValue: Int) {
//            stringValue = ""
//        }
//        
//        var stringValue: String
//        
//        init?(stringValue: String) {
//            self.stringValue = stringValue
//        }
//        
//        var intValue: Int? {
//            nil
//        }
//    }
//    
//    init(from decoder: any Decoder) throws {
//        if let intValue = try? Int(from: decoder) {
//            self = .int(intValue)
//            return
//        }
//        
//        if let doubleValue = try? Double(from: decoder) {
//            self = .double(doubleValue)
//            return
//        }
//        
//        if let stringValue = try? String(from: decoder) {
//            self = .string(stringValue)
//            return
//        }
//        
//        if let boolean = try? Bool(from: decoder) {
//            self = .bool(boolean)
//            return
//        }
//        
//        if var array = try? [FieldValue](from: decoder) {
//            self = .array(array)
//            return
//        }
//        
//        if var objectContainer = try? decoder.container(keyedBy: CodingKeys.self) {
//            var dic: [String: FieldValue] = [:]
//            for key in objectContainer.allKeys {
//                let value = try objectContainer.decode(FieldValue.self, forKey: key)
//                dic[key.stringValue] = value
//            }
//            self = .object(dic)
//            return
//        }
//        self = .null
//    }
//}
//
//for json in samples {
//    let data = json.data(using: .utf8)!
//    let field = try JSONDecoder().decode(Field.self, from: data)
//    print(field.key, "->", field.value)
//}

// MARK: Skip Invalid Elements

//let json = """
//{
//  "users": [
//    { "id": 1, "name": "Alice" },
//    { "id": "oops", "name": "Bad" },
//    { "id": 3, "name": "Charlie" }
//  ]
//}
//"""
//
//struct Response: Decodable {
//    let users: SafeArray<User>
//}
//
//struct User: Decodable {
//    let id: Int
//    let name: String
//}
//
//struct Dummy: Decodable {
//    
//}
//
//struct SafeArray<Element: Decodable>: Decodable {
//    let elements: [Element]
//    
//    init(from decoder: any Decoder) throws {
//        var unKeyedContainer = try decoder.unkeyedContainer()
//        var result: [Element] = []
//        
//        while !unKeyedContainer.isAtEnd {
//            if let value = try? unKeyedContainer.decode(Element.self) {
//                result.append(value)
//            } else {
//                try unKeyedContainer.decode(SkipValue.self)
//            }
//        }
//        
//        elements = result
//    }
//}
//
//let data = json.data(using: .utf8)!
//let response = try JSONDecoder().decode(Response.self, from: data)
//print(response.users.elements)


// MARK: ENCODING STARTED

// MARK: Selective Encoding With Conditions + Dynamic Keys

//struct User: Encodable {
//    let id: Int
//    let name: String
//    let email: String?
//    let metadata: [String: String]
//    let flags: [String: Bool]
//    
//    enum CodingKeys: String, CodingKey, CaseIterable {
//        case id
//        case name
//        case email
//        case metadata = "meta"
//    }
//    
//    struct DynamicKeys: CodingKey {
//        var stringValue: String
//        
//        init?(stringValue: String) {
//            self.stringValue = stringValue
//        }
//        
//        var intValue: Int?
//        
//        init?(intValue: Int) {
//            self.intValue = intValue
//            stringValue = ""
//        }
//    }
//    
//    func encode(to encoder: any Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        
//        for key in CodingKeys.allCases {
//            switch key {
//            case .id:
//                try container.encode(id, forKey: key)
//            case .name:
//                try container.encode(name, forKey: key)
//            case .email where email != nil && email?.isEmpty == false:
//                try container.encode(email, forKey: key)
//            case .metadata:
//                try container.encode(metadata, forKey: key)
//            default:
//                break
//            }
//        }
//        
//        for (key, value) in flags {
//            guard let dynamicKey = DynamicKeys(stringValue: key) else { continue }
//            var container = encoder.container(keyedBy: DynamicKeys.self)
//            try container.encode(value, forKey: dynamicKey)
//        }
//        
//    }
//}
//
//
//
//let user = User(
//    id: 1,
//    name: "Alice",
//    email: "alice@example.com",
//    metadata: ["accountType": "premium", "country": "IN"],
//    flags: ["isAdmin": true, "isActive": false]
//)
//
//let data = try JSONEncoder().encode(user)
//print(String(data: data, encoding: .utf8)!)


// MARK: Transforming Encoded or Decoded Strings into Structured Models

//let json = """
//{
//  "size": "450x300"
//}
//"""
//
//let value = try JSONDecoder().decode(Response.self, from: json.data(using: .utf8)!)
//print(value.size) // Should print Size(width:450,height:300)
//
//let encoded = try JSONEncoder().encode(value)
//print(String(data: encoded, encoding: .utf8)!)
//// Should contain "size":"450x300"
//
//
//struct Size: Codable {
//    let width: Int
//    let height: Int
//    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        
//        let value = try container.decode(String.self)
//        let size = value.components(separatedBy: "x")
//        width = Int(size[0]) ?? 0
//        height = Int(size[1]) ?? 0
//    }
//    
//    func encode(to encoder: any Encoder) throws {
//        var contaienr = encoder.singleValueContainer()
//        try contaienr.encode("\(width)x\(height)")
//    }
//}
//
//struct Response: Codable {
//    let size: Size
//}
//

// MARK: Encoding & Decoding Number Transforms (Model ↔ JSON Representation)

//let json = """
//{
//  "price": "0.5"
//}
//"""
//
//let decoded = try JSONDecoder().decode(Product.self, from: json.data(using:.utf8)!)
//print(decoded.priceInCents)   // 1299
//
//let encoded = try JSONEncoder().encode(decoded)
//print(String(data: encoded, encoding: .utf8)!) // {"price":"12.99"}
//
//struct Product: Codable {
//    let priceInCents: Int
//    
//    enum Codingkeys: String, CodingKey {
//        case priceInCents = "price"
//    }
//    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: Codingkeys.self)
//        
//        let priceString = try container.decode(String.self, forKey: Codingkeys.priceInCents)
//        
//        let separated = priceString.components(separatedBy: ".")
//       
//        guard separated.count == 2, !separated.contains(""), let price = Double(priceString) else {
//            throw NSError(domain: "Invalid price", code: -1)
//        }
//        let priceInCents = Int(price * 100.0)
//        
//        self.priceInCents = priceInCents
//    }
//    
//    func encode(to encoder: any Encoder) throws {
//        var container = encoder.container(keyedBy: Codingkeys.self)
//        let price = priceInCents / 100
//        let cents = priceInCents % 100
//        try container.encode("\(price).\(cents)", forKey: Codingkeys.priceInCents)
//    }
//}
//print(Double("0.1"))
//print(Double("12.99"))
//print(Double("5.05"))
//
//let a = Double("0.1")!
//let b = Double("12.99")!
//let c = Double("5.05")!
//
//print(String(format: "%.20f", a))
//print(String(format: "%.20f", b))
//print(String(format: "%.20f", c))


//MARK: Nested KeyPath Decoding (Flattening Nested JSON Into a Flat Model)

//let json = """
//{
//  "id": 101,
//  "user": {
//    "profile": { "name": "Alice" },
//    "contacts": { "primary": { "email": "alice@example.com" } }
//  },
//  "metrics": {
//    "views": {
//      "daily": 512,
//      "monthly": 20500
//    }
//  }
//}
//"""
//
//struct UserSummary: Decodable {
//    let id: Int
//    let name: String
//    let email: String
//    let dailyViews: Int
//    let monthlyViews: Int
//    
//    enum CodingKeys: CodingKey {
//        case id
//        case user
//        case name
//        case profile
//        case contacts
//        case primary
//        case email
//        case metrics
//        case views
//        case daily
//        case monthly
//    }
//    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        id = try container.decode(Int.self, forKey: CodingKeys.id)
//        let userContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: CodingKeys.user)
//        let profile = try userContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: CodingKeys.profile)
//        name = try profile.decode(String.self, forKey: CodingKeys.name)
//        
//        let contatcts = try userContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .contacts)
//        
//        let primary = try contatcts.nestedContainer(keyedBy: CodingKeys.self, forKey: .primary)
//        
//        email = try primary.decode(String.self, forKey: .email)
//        
//        let metrics = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .metrics)
//        let views = try metrics.nestedContainer(keyedBy: CodingKeys.self, forKey: .views)
//        
//        dailyViews = try views.decode(Int.self, forKey: .daily)
//        monthlyViews = try views.decode(Int.self, forKey: .monthly)
//        
//        
//    }
//}
//
//let data = json.data(using: .utf8)!
//let summary = try JSONDecoder().decode(UserSummary.self, from: data)
//print(summary)
//
////    enum UserKeys: CodingKey {
////        case profile
////        case contacts
////    }

//MARK: Lossy Decoding inside nested objects

//struct Response: Decodable {
//    let groups: [Groups]
//    enum CodingKeys: CodingKey {
//        case groups
//    }
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let lossyGroups = try container.decode(LossyNestedArray<Groups>.self, forKey: .groups)
//        groups = lossyGroups.values
//    }
//}
//
//struct Groups: Decodable {
//    let name: String
//    let members: [Member]
//    
//    enum CodingKeys: CodingKey {
//        case name
//        case members
//    }
//    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//        
//        let lossyMembers = try container.decode(LossyNestedArray<Member>.self, forKey: .members)
//        
//        members = lossyMembers.values
//    }
//}
//
//struct Member: Decodable {
//    let id: Int
//}
//
//struct LossyNestedArray<Element: Decodable>: Decodable {
//    let values: [Element]
//    
//    init(from decoder: any Decoder) throws {
//        var unkeyedContainer = try decoder.unkeyedContainer()
//        var result: [Element] = []
//        while !unkeyedContainer.isAtEnd {
//            guard let value = try? unkeyedContainer.decode(Element.self) else {
//                try unkeyedContainer.decode(LossyNestedDummy.self)
//                continue
//            }
//            result.append(value)
//        }
//        values = result
//    }
//    
//    private struct LossyNestedDummy: Decodable {}
//}

//let json = """
//{
//  "groups": [
//    {
//      "name": "A",
//      "members": [
//        { "id": 1 },
//        { "id": "bad" },
//        { "id": 2 }
//      ]
//    },
//    {
//      "name": "B",
//      "members": [
//        null,
//        { "id": 3 },
//        {},
//        { "id": 4 }
//      ]
//    }
//  ]
//}
//"""
//
//
//
//
//
//let response = try JSONDecoder().decode(Response.self, from: json.data(using: .utf8)!)
//print(response.groups)


// MARK: Decoding date formats with DecodingConfiguration

//let json = """
//{
//  "title": "Launch Event",
//  "date": "2024-12-01 14:30"
//}
//"""
//
//let data = Data(json.utf8)
//let formatter = DateFormatter()
//formatter.dateFormat = "yyyy-MM-dd HH:mm"
//
//let decoder = JSONDecoder()
//do {
//    let event = try decoder.decode(Event.self, from: data, configuration: Event.DecodingConfiguration(formatter: formatter))
//    print(event.title)  // "Launch Event"
//    print(event.date)   // the Date object for 2024-12-01 14:30
//} catch {
//    print(error)
//}
//
//
//
//struct Event: Decodable, DecodableWithConfiguration {
//    let title: String
//    let date: Date
//    
//    struct DecodingConfiguration {
//        let formatter: DateFormatter
//    }
//    
//    enum CodingKeys: CodingKey {
//        case title
//        case date
//    }
//    
//    init(from decoder: any Decoder, configuration: Self.DecodingConfiguration) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        title = try container.decode(String.self, forKey: .title)
//        
//        let dateString = try container.decode(String.self, forKey: .date)
//        
//        guard let date = configuration.formatter.date(from: dateString) else {
//            throw NSError(domain: "Invalid Date Format -> \(dateString)", code: -1)
//        }
//        
//        self.date = date
//    }
//}


// MARK: Currency / Locale Based Decoding (START) with DecodingWithConfiguration

//let json = #" { "value": "1,20,000.50" } "#
//let data = Data(json.utf8)
//
//let decoder = JSONDecoder()
//
//let price = try decoder.decode(
//    Price.self, from: data,
//    configuration: Price.DecodingConfiguration(
//        locale: Locale(identifier: "hi_IN")
//    )
//)
//
//print(price.value)   // 120000.50 as Decimal
//
//struct Price: DecodableWithConfiguration {
//    let value: Decimal
//    
//    struct DecodingConfiguration {
//        let locale: Locale
//    }
//    
//    enum CodingKeys: CodingKey {
//        case value
//    }
//    
//    init(from decoder: any Decoder, configuration: DecodingConfiguration) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        let price = try container.decode(String.self, forKey: .value)
//        
//        guard let value = Decimal(string: price, locale: configuration.locale) else {
//            throw NSError(domain: "Unbale to decode price -> \(price)", code: -1)
//        }
//        
//        self.value = value
//    }
//}

// MARK: API Version–Based Decoding (START) DecodableWithConfiguration

//struct User: DecodableWithConfiguration {
//    let id: Int
//    let name: String
//
//    struct DecodingConfiguration {
//        let version: Version
//    }
//
//    enum Version {
//        case v1
//        case v2
//    }
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case identifier
//        case profile
//        case fullName = "full_name"
//        case user
//    }
//    
//    init(from decoder: any Decoder, configuration: DecodingConfiguration) throws {
//        switch configuration.version {
//        case .v1:
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//            id = try container.decode(Int.self, forKey: .id)
//            name = try container.decode(String.self, forKey: .name)
//        case .v2:
//            let userContainer = try decoder.container(keyedBy: CodingKeys.self)
//            let container = try userContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .user)
//            id = try container.decode(Int.self, forKey: .identifier)
//            let profileContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .profile)
//            name = try profileContainer.decode(String.self, forKey: .fullName)
//            
//        }
//    }
//}
//
//let json1 = """
//{
//  "id": 1,
//  "name": "Alice"
//}
//"""
//
//let json2 = """
//{
//  "user": {
//    "identifier": 1,
//    "profile": {
//      "full_name": "Alice"
//    }
//  }
//}
//"""
//
//let user1 = try JSONDecoder().decode(
//    User.self, from: Data(json2.utf8),
//    configuration: .init(version: .v2)
//)
//
//print(user1.id)   // 1
//print(user1.name) // "Alice"


// MARK: Feature Flag / Environment-Based Decoding (START)

//struct User: DecodableWithConfiguration {
//    let id: Int
//    let name: String
//    let betaField: String?   // Only filled when feature is enabled
//
//    struct DecodingConfiguration {
//        let isBetaEnabled: Bool
//    }
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case betaField = "beta_field"
//    }
//    
//    init(from decoder: any Decoder, configuration: DecodingConfiguration) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(Int.self, forKey: .id)
//        name = try container.decode(String.self, forKey: .name)
//        betaField = configuration.isBetaEnabled ? try container.decode(String.self, forKey: .betaField) : nil
//    }
//}
//

// MARK: Dependency-Injected Decoding (START)

protocol UsernameValidator {
    func isValid(_ username: String) -> Bool
}

//struct User: DecodableWithConfiguration {
//    let username: String
//
//    struct DecodingConfiguration {
//        let validator: UsernameValidator
//    }
//    
//    enum CodingKeys: CodingKey {
//        case username
//    }
//    
//    init(from decoder: any Decoder, configuration: DecodingConfiguration) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let name = try container.decode(String.self, forKey: .username)
//        
//        guard configuration.validator.isValid(name) else {
//            throw NSError(domain: "Invalid userName", code: -1)
//        }
//        
//        username = name
//    }
//}
//

// MARK: Test Mode Override / Fail-Soft Decoding (START)

struct Article: DecodableWithConfiguration {
    let id: Int
    let title: String

    struct DecodingConfiguration {
        let isTestMode: Bool
    }
    
    enum CodingKeys: CodingKey {
        case id
        case title
    }
    
    init(from decoder: any Decoder, configuration: DecodingConfiguration) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        
        if configuration.isTestMode {
            title = (try? container.decode(String.self, forKey: .title)) ?? "Unknown"
        } else {
            title = try container.decode(String.self, forKey: .title)
        }
    }
}

