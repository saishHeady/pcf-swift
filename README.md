# PCF Swift

[![PCF Swift version](https://img.shields.io/badge/pod-1.1.0-green.svg?style=flat-square)](https://bitbucket.org/prolificinteractive/pcf-swift/overview)
[![PCF specs](https://img.shields.io/badge/specs-1.0.3-blue.svg?style=flat-square)](https://bitbucket.org/prolificinteractive/pcf-specs/overview)
[![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat-square)](https://bitbucket.org/prolificinteractive/pcf-swift/overview)
[![Build](https://www.bitrise.io/app/58cfb1a1e0a3e0bf.svg?token=OZbXb65x8uX_YWhKojVlvQ&branch=master)](https://www.bitrise.io/app/58cfb1a1e0a3e0bf#/builds)

![](Assets/background.jpg)

## Description
PCFSwift is the Prolific Interactive iOS SDK that contains all the protocols that your app can conform to in order to follow the PCF specifications. This SDK will help you with all the information you need in order to start using an API following the PCF specifications. The SDK is fully written in Swift.

Please refer to this internal [document](https://docs.google.com/document/d/1sl6u5Z34Gsjs9lC6y7gIXBfwyJ246ZzqiBYeTFgbFY0/edit#) explaining PCF in more details.

The PCF Swift code documentation is available [here](https://prolificinteractive.bitbucket.io/pcf-swift/).

## Requirements
* Xcode 9
* iOS 9+

## How to use

There are 2 main ways to use PCFSwift in your project:

1. **Only use the PCF protocols.** PCFSwift contains all the protocols that define the PCF main specifications. You can write your own models and make them conform to the protocols that you need. It’s up to you to choose the way you want to write the models (`class` vs `struct`…), and how you deserialize them (custom code, Swift Decodable, [Gloss](https://github.com/hkellaway/Gloss)...).

 
2. **Use PCF default models.** PCFSwift contains default models that you can directly use if your PCF implementation when you don’t need a custom feature. The default models conform to Swift's `Decodable` protocol to deserialize JSON data into a model. The default models are all structs and are immutable. If a model doesn’t fit your needs, follow the procedure defined in **1**.

No matter how you use PCF (default models or just protocols), when manipulating PCF data, try to use protocol types instead of concrete types as much as possible.

**Preferred**

```swift
// Product is a protocol
func getProduct<T: Product>(product: T) {}
```

**Not Preferred**

```swift
// PCFProduct is a struct
func getProduct(product: PCFProduct) {}
```

*Rationale* 

By relying on protocols instead of concrete types, you make sure your code is not coupled to a specific implementation of PCF. It will be easier to adopt updated PCF compliant types by using protocols in your code.

For more details about how to use PCF, here are some tips that you can apply to your project.

### 1) I don’t need customization

PCF Swift provides default structs that you can directly use.

### 2) I need customization

Before personalizing a model in your own class/struct, make sure to copy and paste the code from the default PCF struct into your own model. This will get you started with the basics.

#### I’m not using protocols for my models

You can conform to the PCF Swift protocols and implement your custom code in your own model object.

```swift
protocol Product {
    var id: String { get }
    var name: String { get }
}

struct MyProduct: Product {
    let id: String
    let name: String
    let designer: String
}
```

#### I’m using protocols for my models

You can make your model’s protocol conform to the PCF protocol, and have your model conform to your custom protocol.

```swift
protocol ProductProtocol {
    var id: String { get }
    var name: String { get }
}

protocol MyProductProtocol: ProductProtocol {
    var designer: String { get }
}

struct MyProduct: MyProductProtocol {
    let id: String
    let name: String
    let designer: String
}
```

#### I’m not using a PCF property

If you are not using a PCF property, you can make it unavailable and force developers to use your custom property instead.

```swift
protocol Product {
    var id: String { get }
    var name: String { get }
}

protocol MyProductProtocol: Product {
    var resourceId: Int { get } // redefinition of id
    var designer: String { get }
}

struct MyProduct: MyProductProtocol {
    @available(*, unavailable, renamed: "resourceId")
    let id: String = ""
    let resourceId: Int
    let name: String
    let designer: String
}

let product = MyProduct(resourceId: 1, name: "Name", designer: "Designer")
product.id // error: 'id' has been renamed to 'resourceId'
```

#### I need to customize a variable with another type

PCF Swift protocols are generics so you can pass the type that you need as long as it conforms to a PCF protocol. By setting the typealias to the type you want to use, you will have access to your custom models instead of the default PCF models.

```swift
protocol SKU {
    var id: String { get }
    var name: String { get }
}

protocol Product {
    associatedtype SKUType: SKU

    var id: String { get }
    var name: String { get }
    var skus: [SKUType] { get }
}

struct MySKU: SKU {
    let id:String
    let name: String
    let quantity: Int
}

struct MyProduct: Product {
    typealias SKUType = MySKU

    let id: String
    let name: String
    let skus: [SKUType]
}
```

#### Error handling

When implementing your own implementations of the PCF protocols, you are free to implement custom errors
by implementing types conforming to `PCFSwift.Error` as needed. Certain common errors are also pre-defined 
as part of `PCFError`:

|Error   |Code   |Usage   |
|---|---|---|
| invalidJSON | -1 | Errors of this kind are most likely due to either an error on the server side where unreadable data is being sent or on the client side when a different response structure is expected than the one being sent |

When implementing custom errors, it might be necessary to still handle both these PCFError cases and the errors
you implemented yourself. In order to do so, you can check errors in a switch statement as follows:

```swift
switch error {
case let val as PCFError where val == .invalidJSON:
    // handle an invalid response appropriately
case let val as CustomError:
    // handle your custom PCFSwift.Error type
...
}
```


### FAQ

PCF Swift FAQ document available [here](https://docs.google.com/document/d/1IxSyJiRpt9RNTo8iSPEEX5M2bKPW-Sd8R-sCEfRqFI0/edit#).

## Networking

PCF Swift includes networking features out of the box. You can rely on PCF for the following:

* HTTP environment definition.
* HTTP environment manager.
* HTTP client — `PCF/Alamofire` subspec will provide a default Alamofire HTTP client and Alamofire dependency.
* Data managers for every PCF API domain.
* Interactors to interact with the data managers and handle business logic.

Here is an example of how to initialize all the networking objects:

```swift
// Environment objects
let environment = PCFHTTPEnvironment(name: "QA", baseURL: URL(string: "http://qa.prolific.io/")!)
let environmentManager = PCFHTTPEnvironmentManager(currentEnvironment: environment, environments: [environment])

// HTTP client
let httpClient = AlamofireHTTPClient()

// Session manager
let sessionManager = PCFSessionManager(environmentManager: environmentManager,
                                       httpClient: httpClient,
                                       persistenceClient: nil)

// Data manager and interactor for Navigation
let dataManager = PCFNavigationDataManager(environmentManager: environmentManager,
                                           sessionManager: sessionManager,
                                           httpClient: httpClient)
let interactor = PCFNavigationInteractor(dataManager: dataManager)
```

## Business Logic
PCF includes business logic layers that will speed up the integration process and unify the way we use PCF. For every domain (Cart, Product, Category...) the framework provides a **data manager** and **interactor**.

### Data Manager
PCF data managers are responsible for calling the PCF networking layers and make API calls. They perform a specific request, and transform the returned JSON into PCF models, or propagate a potential error.

For example, the Product data manager will make a PCF Product HTTP request to get the Product JSON data, and transform this data into a `PCFProduct` model object.

Typically, you don't need to call the data manager directly if you are using the PCF interactions.

```swift
let dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager, 
														 sessionManager: sessionManager, 
														 httpClient: validResponseClient)

dataManager.product(forProductId: productId) { [weak self] (product, error) in
	// ...
}
```

#### Customization
You can customize the data manager by providing your own types conforming to the PCF protocols in the class definition. Data managers use generic types to allow model customization easily.

```swift
let dataManager = ProductDataManager<MyProduct, MySku>(environmentManager: envManager, 
													   sessionManager: sessionManager, 
													   httpClient: validResponseClient)
```

### Interactor
PCF interactors are responsible for business logic and data management. They provide commerce features that you can leverage in your application. 

For example, the Product interactor will provide functionalities to retrieve product data using the Product data manager, get specific Product information like SKUs, available colors and sizes, a SKU for a specific color and size, etc.

The generic types that you pass to the interactor have to match the types that you pass to the data manager, if you customize them.

```swift
let dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager, 
														 sessionManager: sessionManager, 
														 httpClient: validResponseClient)

let interactor = ProductInteractor(dataManager: dataManager)
```

#### Customization
Similar to the data managers, you can customize interactors by passing your custom type in the generic types class definition.

## iOS Specificities

#### Dev Notes
PCFSwift is compatible with Swift 4.0 and cocoapods 1.1+

#### Cocoapods
This project relies on [cocoapods](cocapods.org) to manage its dependencies.

#### Jazzy
* This project uses jazzy to extract documentation from Swift code.
* [GitHub Repo](https://github.com/realm/jazzy)

#### Install/Build Notes
To use PCF Swift in your project, add the following lines to your Podfile:

```
source 'https://github.com/CocoaPods/Specs.git'
source 'git@bitbucket.org:prolificinteractive/pibrary-ios.git'

pod 'PCFSwift'
```

You can then use `PCFSwift` by importing it into your files:

```swift
import PCFSwift
```

## Additional modules

#### [1Password](https://github.com/agilebits/onepassword-app-extension)

> 1Password is a password manager. Users can access their 1Password credentials automatically, generate strong passwords using the 1Password password generator, and quickly fill logins, credit cards and identities online.

```
pod 'PCFSwift/1Password'
```

The 1Password integration relies on the PCF credentials logic integrated into the Core SDK. To use 1Password integration directly, use the following code:

```swift
// Get the 1Password button
do {
	let button = try passwordManager.button()
	button.addTarget(self, action: #selector(buttonTapped), for: UIControlEvents.touchUpInside)
	view.addSubview(button)
} catch {
	// Handle error
}

func buttonTapped() {
    passwordManager.findLogin(forURLString: <Your domain URL>,
                              viewController: self,
                              sender: nil) { (user, error) in
                                if let user = user {
                                    print(user.email)
                                    print(user.password)
                                }
    }
}
```

#### [AddressGeocoder](https://github.com/prolificinteractive/AddressGeocoder)

> AddressGeocoder is a helper tool to get the state and locality for a given zip code.

```
pod 'PCFSwift/AddressGeocoder'
```

#### [GenericValidator](https://github.com/prolificinteractive/GenericValidator)

> GenericValidator provides helper functions and protocols to help you validate any kind of data that conforms to the Evaluatable and Validatable protocols.

```
pod 'PCFSwift/GenericValidator'
```

#### [Kill Switch](https://github.com/prolificinteractive/Bellerophon)

> Sometimes in a development phase, it happens for different reasons that the app available in the store has to be killed. It could be because it contains a major issue (crash, security breach...) or for a business decision (killing the app before a Sale starts, so users are not buying before the others for example).

PCF kill switch integration relies on [Bellerophon](https://github.com/prolificinteractive/Bellerophon) for the kill switch management, and [Siren](https://github.com/ArtSabintsev/Siren) for the force update management.

```
pod 'PCFSwift/KillSwitch'
```

#### [Touch ID](https://developer.apple.com/reference/localauthentication)

> Touch ID helper classes to check Touch ID availability, activate or deactivate it, and authenticate the user's fingerprint.

```
pod 'PCFSwift/TouchID'
```

#### [Alamofire](https://github.com/Alamofire/Alamofire)

> Alamofire is an HTTP networking library written in Swift.

The Alamofire integration provides a default implementation of the HTTP client using Alamofire request function with JSON serialization.

```
pod 'PCFSwift/Alamofire'
```

#### [Environment Manager (Yoshi)](https://github.com/prolificinteractive/Yoshi)

> Yoshi is a convenient wrapper around the UI code that is often needed for displaying debug menus. Out of the box, Yoshi provides easy-to-implement date, list and custom menus.

```
pod 'PCFSwift/EnvironmentManager'
```

How to use it:

```swift
let environmentSwitcherBuilder = PCFEnvironmentSwitcherBuilder(environmentManager: environmentManager,
																title: "API Environments",
																subtitle: "Pick wisely... 👀")
let environmentsTableViewMenu = environmentSwitcherBuilder.createEnvironmentSwitchOptions()

Yoshi.setupDebugMenu(environmentsTableViewMenu)
```

## Contributing

To report a bug or enhancement request, feel free to file an issue under the respective heading.

If you wish to contribute to the project, please submit a pull request to this repository.

## Changelog
Changelog available [here](./CHANGELOG.md).

## Authors

* Phill Farrugia (Lead)
* Thibault Klein
* Daniel Vancura
* Harlan Kellaway
* Dominic Ancrum
* Satinder Singh

## Maintainers

![](https://s3.amazonaws.com/prolificsitestaging/logos/Prolific_Logo_Full_Color.png)

PCFSwift is maintained and funded by Prolific Interactive. The names and logos are trademarks of Prolific Interactive.