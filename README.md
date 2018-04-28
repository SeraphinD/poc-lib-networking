# Networking

A very lightweight library for managing Networking layer for iOS apps written in Swift inspired by Moya, Alamofire, ObjectMapper and this article: https://medium.com/flawless-app-stories/writing-network-layer-in-swift-protocol-oriented-approach-4fa40ef1f908 with the help of: https://www.raywenderlich.com/158106/urlsession-tutorial-getting-started

# How to use it 🧐

## Data

### Configuration

If you are familiar with Moya the following part will be easy to understand.

First, you need to declare an enum with all your routes as follow:

```
enum JSONPlaceholderEndPoint {
    case postList
    case post(id: Int)
}
```

Then declare your enum as `EndPointType` and set all required var accordingly, example:

```
extension JSONPlaceholderEndPoint: EndPointType {
    
    var baseURL: URL {
        guard let strUrl = Bundle.main.infoDictionary!["JSONPlaceholderAPIURL"] as? String,
            let url = URL(string: strUrl) else {
                fatalError("Must declare base JSONPlaceholder api url in Info.plist")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .postList: return "posts"
        case .post(let id): return "posts/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postList: return .get
        case .post: return .get
        }
    }
    
    var encoding: ParameterEncoding? {
        return nil
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parameters: HTTPParameters? {
        return nil
    }
    
    var authRequired: Bool {
        return false
    }
}
```

The next step is to declare your router in your service/data manager/whatever you want.

```
final class MyService {
    private let router = Router<JSONPlaceholderEndPoint>()
}
```

### Request datas

### Request object

As long as your object implement the protocol Codable, you can request it using the instance method of `Router` `requestObject`: 

```
private let router = Router<JSONPlaceholderEndPoint>()
    
func getPostList(completion: @escaping (_ posts: [PostResponse]?) -> ()) {
    router.requestObject(.postList) { (postList: [PostResponse]?, _, _) in
        completion(postList)
    }
}

```

I recommand using quicktype to generate your services models: https://app.quicktype.io/

## Images

### Load image from Url

You can set image with `URL?`, it will download the image as data and cached it.

```
myImageView.setImage(with: URL(string: "https://path/to/image.jpg"))
```

### Use placeholder

You can also set a placeholder of type `UIImage` with the same method.

```
myImageView.setImage(with: URL(string: "https://path/to/image.jpg"),
                     placeholder: myUIImagePlaceholder)
```

### Show activity indicator

A activity indicator can be shown during the image loading by setting the loader parameter to one of `ImageActivityIndicatorType`.

```
myImageView.setImage(with: URL(string: "https://path/to/image.jpg"),
                     loader: .activityLight)
```

The parameter `.activityLight` use a white `UIActivityIndicatorView` and `.activityDark` use a gray `UIActivityIndicatorView`.

## Handle errors

You just have to set `authRequired` to true for the routes that need to be authenticated in your `EndPointType`.
```

enum MyEndPoint {
    case login
    case authRequiredRoute
}

extension MyEndPoint: EndPointType {
    var authRequired: Bool {
        switch self {
        case .login: return false
        case .authRequiredRoute: return true
        }
    }
}
```

You can easily handle unauthorized by setting `AppDelegate` as `NetworkingAuthDelegate`. Declare `authRequired` as true for an end point means that each 401 response will handle the following delegate.

```
let router = Router<JSONPlaceholderEndPoint>()
router.delegate = self
```

```
extension CurrentClass: NetworkRouterDelegate {
    func router<JSONPlaceholderEndPoint>(_ router: Router<JSONPlaceholderEndPoint>, didReceiveBadAuth error: HTTPError) {
        // set app delegate root window to login view controller for example
    }
}
```

Extending that protocol or setting it to AppDelegate can also be a way to handle 401 globally.

# Why creating this lib 🤔 

# Next steps 💪