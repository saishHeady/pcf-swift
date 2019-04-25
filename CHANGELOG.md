# Changelog

- `0.1.x` Releases - [0.1.0](#010) | [0.1.1](#011) | [0.1.2](#012)
- `0.2.x` Releases - [0.2.0](#020) | [0.2.1](#021) | [0.2.2](#022) | [0.2.3](#023) | [0.2.4](#024) | [0.2.5](#025) | [0.2.6](#026) | [0.2.7](#027) | [0.2.8](#028) | [0.2.9](#029)
- `0.3.x` Releases - [0.3.0](#030) | [0.3.1](#031) | [0.3.2](#032) | [0.3.3](#033) | [0.3.4](#034) | [0.3.5](#035) | [0.3.6](#036)
- `1.0.x` Releases - [1.0.0](#037)
- `1.1.x` Releases - [1.1.0](#038)

---
### [1.1.0](https://bitbucket.org/prolificinteractive/pcf-swift/commits/tag/1.1.0)
Released on 2017-11-08.

#### Changed
- Migrates JSON Decoding functionality to use Swift 4's `Decodable` protocol
- Removes third party dependency `Gloss`
- Replaces EnvironmentManager Yoshi integration with Yoshi/QAKit module

---
### [1.0.0](https://bitbucket.org/prolificinteractive/pcf-swift/commits/tag/1.0.0)
Released on 2017-10-03.

#### Changed
- Updates to support Xcode 9, Swift 3.2 (without Yoshi module) and full support for Swift 4.0

---
### [0.3.6](https://bitbucket.org/prolificinteractive/pcf-swift/commits/tag/0.3.6)
Released on 2017-09-01.

#### Added
- Added a way to know when the environment gets switched in the `EnvironmentSwitcher` subspec.

#### Changed
- Made product `imageResource` optional.

### [0.3.5](https://bitbucket.org/prolificinteractive/pcf-swift/commits/tag/0.3.5)
Released on 2017-06-13.

#### Changed
- Fixed Yoshi version to force it to `2.0.2`. The newest version at the time – `2.2.2` – is introducing breaking changes for PCF.

### [0.3.4](https://bitbucket.org/prolificinteractive/pcf-swift/commits/tag/0.3.4)
Released on 2017-06-13.

#### Changed
- Updated the dependency requirements for Address Geocoder and Generic Validator. [PR #66](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/66/updated-dependency-versions-requirements/diff) - Thibault Klein

### [0.3.3](https://bitbucket.org/prolificinteractive/pcf-swift/commits/tag/0.3.3)
Released on 2017-06-13.

#### Added
- Added remove function to Persistable protocol. [PR #64](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/64/added-remove-function-to-persistable/diff) - Harlan Kellaway

#### Changed
- Updated the session management flow to give more responsibilities to the session manager. [PR #63](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/63/new-session-management-flow/diff) - Harlan Kellaway
- Updated all data managers and interactions to make them open. [PR #62](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/62/made-all-the-data-manager-paths-public-to/diff) - Thibault Klein

### [0.3.2](https://bitbucket.org/prolificinteractive/pcf-swift/commits/tag/0.3.2)
Released on 2017-06-05.

#### Added
- Refactored PCF product data manager and interactor to use generic types. [PR #61](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/61/refactored-pcf-product-data-manager-and/diff) - Thibault Klein

### [0.3.1](https://bitbucket.org/prolificinteractive/pcf-swift/commits/tag/0.3.1)
Released on 2017-05-24.

#### Added
- Integrated account keychain manager. [PR #57](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/57/account-keychain-management/diff) - Thibault Klein
- Added LocalizedError conformance to PCF error protocol in order to leverage localizedDescription of Swift Error protocol. [PR #56](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/56/added-localizederror-conformance-to-pcf/diff) - Thibault Klein
- Added integration of Bellerophon and Siren as a subspec. [PR #60](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/60/added-integration-of-bellerophon-and-siren/diff) - Thibault Klein

#### Changed
- Updated Product Search Interactor to return the new search result format from specs 1.0.4. [PR #59](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/59/updated-product-search-interactor-to/diff) - Thibault Klein

#### Removed
- Removed user reviews count from Product user reviews. [PR #58](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/58/removed-user-reviews-count-from-product/diff) - Thibault Klein

### [0.3.0](https://bitbucket.org/prolificinteractive/pcf-swift/commits/tag/0.3.0)
Released on 2017-05-09.

#### Added
- Product search interactor integration. [PR #54](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/54/cdp-interactor-with-tests/diff) - Sagar Natekar

#### Changed
- Updated README with new banner and icon. [PR #55](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/55/added-pcf-banner-and-icon/diff) - Thibault Klein

---
### [0.2.9](https://bitbucket.org/prolificinteractive/pcf-swift/commits/tag/0.2.9)
Released on 2017-04-25.

#### Added
- Session error management integration. [PR #48](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/48/session-error-management/diff) - Thibault Klein
- Order data manager integration. [PR #51](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/51/order-data-manager/diff) - Thibault Klein
- Order interactor integration. [PR #52](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/52/implemented-order-interactor/diff) - Thibault Klein

### [0.2.8](https://bitbucket.org/prolificinteractive/pcf-swift/commits/tag/0.2.8)
Released on 2017-04-18.

#### Added
- 1Password integration as a subspec. [PR #46](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/46/1password-integration/diff) - Thibault Klein
- Product search data manager integration. [PR #47](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/47/cdp-data-manager/diff) - Sagar Natekar
- Yoshi integration as a subspec. [PR #50](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/50/yoshi-integration/diff) - Thibault Klein

#### Changed
- Changed environment manager environments property to be mutable. [PR #49](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/49/changed-environment-manager-environments/diff) - Thibault Klein

### [0.2.7](https://bitbucket.org/prolificinteractive/pcf-swift/commits/tag/0.2.7)
Released on 2017-04-11.

#### Added
- Cart data manager integration. [PR #44](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/44/cart-data-manager/diff) - Thibault Klein
- Cart interactor integration. [PR #45](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/45/cart-interactor/diff) - Thibault Klein

### [0.2.6](https://bitbucket.org/prolificinteractive/pcf-swift/commits/tag/0.2.6)
Released on 2017-04-04.

#### Added
- Added a default Touch ID manager. [PR #41](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/41/added-default-pcf-touch-id-manager/diff) - Thibault Klein
- Product data manager integration. [PR #38](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/38/implemented-product-data-manager/diff) - Thibault Klein
- Product interactor integration. [PR #39](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/39) - Thibault Klein

#### Changed
- Fixed a bug with HTTPRequest initializer. [PR #36](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/36/bug-httprequest-initializer-fix/diff) - Daniel Vancura

### [0.2.5](https://bitbucket.org/prolificinteractive/pcf-swift/commits/tag/0.2.5)
Released on 2017-03-22.

#### Added
- Category data manager integration. [PR #29](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/29/feature-category-data-manager/diff) - Daniel Vancura
- Provided a default initializer for PCF address model. [PR #31](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/31/provided-a-default-public-initializer-for/diff) - Thibault Klein
- Session manager integration. [PR #33](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/33/added-a-protocol-for-sessionmanager-with/diff) - Sagar Natekar
- Added order details model. [PR #32](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/32/added-order-detail-protocal-and-model/diff) - Thibault Klein
- Integrated navigation interactor. [PR #34](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/34/feature-navigation-interactor/diff) - Daniel Vancura
- Added default types for networking manager. [PR #35](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/35/added-default-types-for-networking/diff) - Thibault Klein

#### Changed
- Fixed folder structure for PCF subspecs. [PR #28](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/28/folder-structure/diff) - Thibault Klein
- Move Gloss initializers to extensions. [PR #30](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/30/moved-gloss-initializer-into-extensions-to/diff) - Thibault Klein
- Updated README with details on how to manipulate PCF data. [PR #37](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/37/readme-update/diff) - Thibault Klein
- Updated Gloss version requirement. [PR #40](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/40/updated-gloss-requirement-version/diff) - Thibault Klein

### [0.2.4](https://bitbucket.org/prolificinteractive/pcf-swift/commits/tag/0.2.4)
Released on 2017-03-02.

#### Added
- Integrated networking management. [PR #24](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/24/networking-manager/diff) - Thibault Klein
- Integrated Alamofire integration as a PCF subspec. [PR #27](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/27/alamofire-integration/diff) - Thibault Klein

### [0.2.3](https://bitbucket.org/prolificinteractive/pcf-swift/commits/tag/0.2.3)
Released on 2017-02-28.

#### Added
- Integrated Touch ID manager. [PR #25](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/25/touch-id-manager/diff) - Thibault Klein
- Added custom image resource JSON decoding. [PR #26](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/26/added-custom-imageresource-transformation/diff) - Phill Farrugia

### [0.2.2](https://bitbucket.org/prolificinteractive/pcf-swift/commits/tag/0.2.2)
Released on 2017-02-14.

#### Added
- Wish list data manager integration. [PR #22](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/22/wishlist-manager/diff) - Thibault Klein

### [0.2.1](https://bitbucket.org/prolificinteractive/pcf-swift/commits/tag/0.2.1)
Released on 2017-02-14.

#### Changed
- Fixed the product image resource object type. [PR #23](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/23/fixed-the-type-of-image-resources-in/diff) - Thibault Klein

### [0.2.0](https://bitbucket.org/prolificinteractive/pcf-swift/commits/tag/0.2.0)
Released on 2017-01-20.

#### Added
- Added Swift 3 support. [PR #17](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/17/updated-pcf-swift-to-work-with-swift-30/diff) - Thibault Klein
- Added generic validator pod as a PCF subspec. - Thibault Klein
- Added geocoder pod as a PCF subspec. [PR #20](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/20/added-geocoder-as-a-subspec/diff) - Thibault Klein

---
### [0.1.2](https://bitbucket.org/prolificinteractive/pcf-swift/commits/tag/0.1.2)
Released on 2017-20-01.

#### Changed
- Updated README to match Prolific standards and add badges. [PR #19](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/19/updated-readme-to-match-prolific-standards/diff) - Thibault Klein
- Updated PCF Swift to work with Swift 2.3. [PR #16](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/16/updated-pcf-swift-to-work-on-swift-23/diff) - Thibault Klein

### [0.1.1](https://bitbucket.org/prolificinteractive/pcf-specs/commits/tag/1.0.4)
Released on 2016-11-28.

#### Added
- Added identifier to Adjustments and refactored Cart tests. [PR #18](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/18/added-identifier-to-adjustment/diff) - Sagar Natekar.
- Added `PaymentMethod` and `PaymentObject` entities. [PR #21](https://bitbucket.org/prolificinteractive/pcf-swift/pull-requests/21/payment-model/diff) - Daniel Vancura

---

### [0.1.0](https://bitbucket.org/prolificinteractive/pcf-swift/commits/tag/0.1.0)
This is the initial version of the PCF Swift.

---
