## Hello there!

Let me give you some insight about the project before talking about the requirements and presenting the visual assets:
- First of all, all of the requirements are met and the app is fully functional.
- I tried to be as detailed and honest as possible on commit descriptions. If you wish, you can view the commit history for the development process.
- I also cared about the UX and added small functionalities like debounced searching, alerting before deletion etc. But I didn't add accessibility features since it wasn't required in this task but it would be nice to implement this on a real project of course.
- I could show the any possible errors to the user with simple toast views but I didn't spend any time on that since I believe that is not the main concern in this project and the development phase is the thing that matters.
- I only used one screen view (ContentView) since that's all I needed. I tried to keep everything as simple as possible and I didn't implement any custom animations, a splash screen, custom dynamic themes etc.
- I've used MVVM structure. You can find the data fetching functions in `ContentViewViewModel.swift`.
- I've used a sidemenu Drawer view for the menu screen.
- You can also sort the resources by `Title`, `Task` and `Description`. You can change the sort type in the drawer view.

## Requirement details:
- Request the resources located at `https://api.baubuddy.de/dev/index.php/v1/tasks/select`
  - I can successfully fetch the resources from this endpoint in the background and I publish the results in the main thread.
- Store them in an appropriate data structure that allows using the application offline.
  - I basically had 3 choices for this: *UserDefaults*, *files* or *Core Data*. I choose **Core Data**.
    - User Defaults are not ideal for large sizes of data but it’s practical for saving preferences or other types of ‘small’ data.
    - Files might be useful but it also might be hard to manage structural data like our JSON data.
    - Core Data is the ideal solution for structural data since we already have a model in hand to parse JSON. It would also be easier to add relations if we need to fetch another type of data in the future that’s related to ‘tasks’. It's also easier to save and load the data for offline use.
- Display all items in a list showing `task`, `title`, `description` and `colorCode` (which should be a view colored according to `colorCode`)
  - I created a very simple list view with LazyVStack (to prevent potential UI performance issues if we fetch large sums of data) to show the desired properties. Hex color code is used as a leading icon in the card views.
- The app should offer a search bar that allows searching for any of the class properties (even those, that are not visible to the user directly)
  - I accomplished this by filtering the CoreData fetched result with NSPredicates on all properties of the Task entity. You can successfully search for all of the properties.
- The app should offer a menu item that allows scanning for QR-Codes. Upon successful scan, the search query should be set to the scanned text
  - I used a custom package (by Paul Hudson, more detail is given in the References headline) for scanning the QR codes since I unfortunately don't have an iPhone to test the codes by myself. The package can simulate a response from the scanner, this way I successfully managed to set the search query to the scan result (you can change the simulated result in `DrawerView.swift`). I also added the camera usage request to Target Properties so I believe you should be able test this feature if you have a physical device. 
- In order to refresh the data, the app should offer a pull-2-refresh functionality
  - The native List view supports a `.refreshable()` modifier but since I wanted a card list instead of the native List style, I again used a package that adds the refreshable feature to the native ScrollView (check out the References headline). There is a bug that I'm aware of with this function: refreshing tasks happens on the main thread (therefore blocking the UI) and upon an error from the HTTP requests during the refreshing animation, it can break the UI (`Refresh` toolbar button on the top left works fine even under these conditions). I tried a few things but I don't want to spend too many time on it since I want to return this task as soon as possible, I hope you can be understanding about this. I still wanted to let you know that I'm aware of this bug.

## References:
- Refreshable native ScrollView package (by [elegantchaos](https://github.com/elegantchaos)): https://github.com/elegantchaos/RefreshableScrollView/tree/main
- QR code scanner package (by [Paul Hudson](https://github.com/twostraws)): https://github.com/twostraws/CodeScanner
  - Tutorial: https://www.hackingwithswift.com/books/ios-swiftui/scanning-qr-codes-with-swiftui
- Helpful tutorial for the sidemenu drawer view: https://lanars.com/blog/sidemenu-in-swiftui-part1

## Visual Assets:
<a href="url"><img src="https://github.com/eyubSalihOzdemir/vero-ios-task/assets/55896033/8f2d7641-1738-4efa-8435-7853887abeab" alt="Main Screen - Empty" height="480"></a>
<a href="url"><img src="https://github.com/eyubSalihOzdemir/vero-ios-task/assets/55896033/dc037728-7b3b-4e15-bdc0-d146369b6b20" alt="Loading Indicator" height="480"></a>
<a href="url"><img src="https://github.com/eyubSalihOzdemir/vero-ios-task/assets/55896033/e5fbfc9c-d3bc-408c-a577-37cf316625a2" alt="Main Screen" height="480"></a>
<a href="url"><img src="https://github.com/eyubSalihOzdemir/vero-ios-task/assets/55896033/775a75b8-68f5-4b71-b6eb-821f8a94c23e" alt="Alert View" height="480"></a>
<a href="url"><img src="https://github.com/eyubSalihOzdemir/vero-ios-task/assets/55896033/3e4072ef-ca38-4597-bdb3-ee48b09df626" alt="Sidemenu" height="480"></a>
<a href="url"><img src="https://github.com/eyubSalihOzdemir/vero-ios-task/assets/55896033/49668d0e-2812-4324-b384-d01e57b06125" alt="Sorting Selection" height="480"></a>
<a href="url"><img src="https://github.com/eyubSalihOzdemir/vero-ios-task/assets/55896033/817123b7-3600-492e-8894-96a9d020acfa" alt="QR Code Scanner" height="480"></a>

https://github.com/eyubSalihOzdemir/vero-ios-task/assets/55896033/bd424d4f-066b-4956-a4a0-26208406bd6a

## Thank you for your time and consideration. I can't wait to hear back from you!
### Take care. 👋

#
#
#

Hello dear iOS dev prospect!

This repository is supposed to act as a playground for your submission.
Before getting started, please make sure to use this repository as a template on which you will commit and push your code regularly. Once you are ready, please mail us back the link to your repository. 

Below, you will find the **Task** definition. Happy Hacking :computer: and Good Luck :shamrock:

# Task

Write a iOS application that connects to a remote API, downloads a certain set of resources, shows them in a list and provides some basic searching/filtering feature-set.
In particular, the app should:

- Request the resources located at `https://api.baubuddy.de/dev/index.php/v1/tasks/select` 
- Store them in an appropriate data structure that allows using the application offline
- Display all items in a list showing `task`, `title`, `description` and `colorCode` (which should be a view colored according to `colorCode`)
- The app should offer a search bar that allows searching for any of the class properties (even those, that are not visible to the user directly)
- The app should offer a menu item that allows scanning for QR-Codes
  - Upon successful scan, the search query should be set to the scanned text
- In order to refresh the data, the app should offer a pull-2-refresh functionality
  

### Authorization

It's mandatory for your requests towers the API to be authorized. You can find the required request below:

This is how it looks in `curl`:

```bash
curl --request POST \
  --url https://api.baubuddy.de/index.php/login \
  --header 'Authorization: Basic QVBJX0V4cGxvcmVyOjEyMzQ1NmlzQUxhbWVQYXNz' \
  --header 'Content-Type: application/json' \
  --data '{
        "username":"365",
        "password":"1"
}'
```

The response will contain a json object, having the access token in `json["oauth"]["access_token"]`. For all subsequent calls this has to be added to the request headers as `Authorization: Bearer {access_token}`.

A possible implementation in `Swift` could be the following. You don't have to copy over this one, feel free to indivualize it or use a different network library.

```swift
import Foundation

let headers = [
  "Authorization": "Basic QVBJX0V4cGxvcmVyOjEyMzQ1NmlzQUxhbWVQYXNz",
  "Content-Type": "application/json"
]
let parameters = [
  "username": "365",
  "password": "1"
] as [String : Any]

let postData = JSONSerialization.data(withJSONObject: parameters, options: [])

let request = NSMutableURLRequest(url: NSURL(string: "https://api.baubuddy.de/index.php/login")! as URL,
                                        cachePolicy: .useProtocolCachePolicy,
                                    timeoutInterval: 10.0)
request.httpMethod = "POST"
request.allHTTPHeaderFields = headers
request.httpBody = postData as Data

let session = URLSession.shared
let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
  if (error != nil) {
    print(error)
  } else {
    let httpResponse = response as? HTTPURLResponse
    print(httpResponse)
  }
})

dataTask.resume()
```
