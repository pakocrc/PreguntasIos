import Foundation
import UIKit

// MARK: - User Defaults
//let userDefaults = UserDefaults.standard
//
struct User {
    let name: String
}

let user1 = User(name: "userOne")
let user2 = User(name: "userTwo")

let users = [user1, user2]
//
//let userListString = users.reduce("") { result, user in
//    return "\(result)\(user.name),"
//}
//
//userDefaults.setValue(userListString, forKey: "users")
//
//let userListFromUserDefaults = userDefaults.value(forKey: "users") as? String ?? "empty"
//
//let userList = userListFromUserDefaults.split(separator: ",").map({ return User(name: $0.description) })
//
//
//userList.forEach({ print("User: \($0.name)") })


//@propertyWrapper struct AppSetting<Value> {
//    let key: String
//    var container: UserDefaults = .standard
//
//    var wrappedValue: Value? {
//        get { container.value(forKey: key) as? Value }
//        set { container.setValue(newValue, forKey: key) }
//    }
//}
//
//@AppSetting(key: "onboarding_was_shown")
//var onboardingWasShown: Bool?

//let lang = Locale.current.languageCode
//print(lang ?? "no-lang")

//let jsonString = "players: Pako, Kilay, count: 2, lang: ES"
//let jsonString: [String: Any] = ["players": "Kilay, Mali",
//                                 "count": 2,
//                                 "lang": "ES"]
//
//let aux = try JSONSerialization.data(withJSONObject: jsonString)
//
//print(aux)

let emptyArray = ["1", ""]
//print(emptyArray.isEmpty || emptyArray.allSatisfy({ $0.isEmpty }) )

print(emptyArray.isEmpty || emptyArray.contains(where: { $0.isEmpty})  )
