import UIKit

let json = """
{
    "id": 1,
    "team": "Avengers",
    "participants": [
        {
            "name": "IRON MAN",
            "friend": "James Rhodes"
        },
        {
            "firstName": "HULK",
            "friend": "Natasha"
        },
        {
            "secondName": "America",
            "friend": "Bucky"
        }
    ]
}
"""

let dynamicJSONData = json.data(using: .utf8)

struct DynamicKeyAndValue: Decodable {
    var key: String
    var value: String
}

struct Hero: Decodable {
    var name: DynamicKeyAndValue
    var friend: String
    
    private enum KnonwKeys: String {
        case friend
    }
    
    private struct DynamicKey: CodingKey {
        var stringValue: String
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        
        init?(intValue: Int) {
            self.intValue = intValue
            self.stringValue = ""
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicKey.self)
        friend = ""
        name = DynamicKeyAndValue(key: "", value: "")
        for key in container.allKeys {
            switch KnonwKeys(rawValue: key.stringValue) {
            case .none:
                let value = try container.decode(String.self, forKey: key)
                name = DynamicKeyAndValue(key: key.stringValue, value: value)
            case .some(_):
                friend = try container.decode(String.self, forKey: key)
            }
        }
    }
}


struct Avengers: Decodable {
    var id: Int
    var team: String
    var participants: [Hero]
}


let decodedData = try JSONDecoder().decode(Avengers.self, from: dynamicJSONData!)
dump(decodedData)
