import Foundation


func main() {
    if let path = readLine() {
        print(shortenPath(path: path))
    } else {
        print("Usage: pwd | prompt_pwd")
    }
}



func shortenPath (path: String) -> String {
    let user_home = "/home/\(NSUserName())"
    if path == user_home {
        return "~"
    } else {
        var pathArray = path.componentsSeparatedByString("/")
        if path.hasPrefix(user_home) {
            // Remove leading "" and "home".
            pathArray.removeFirst(2)
            // "user" -> "~"
            pathArray[0] = "~"
        } else {
            // pathArray[0] == ""
        }
        let basename = pathArray.removeLast()
        let firstCharacters  = pathArray.map({
            $0 == "" ? "" : String($0[$0.startIndex])
        })
        let shortPath = firstCharacters.joined(separator: "/") +
                        "/" + basename
        return shortPath
    }
}


main()
