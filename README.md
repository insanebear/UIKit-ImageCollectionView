# Overview

Unsplash “Search Photos” API를 사용해 최신 사진 100장을 두가지 방식의 뷰로 보여주는 어플리케이션

### Notice

해당 프로젝트를 실행하기 위해서는 `UnsplashInfo.plist`의 “PLEASE ENTER YOUR UNSPLASH API KEY HERE”를 자신의 API Key 를 발급받아 입력해주시기 바랍니다.

### Description

- [Unsplash](https://unsplash.com/)에서 제공하는 API를 사용하여 최신 사진을 보여줍니다.
    - 현재는 “최신 100개의 사진” 조건으로 설정되어있습니다.
- 사진은 그리드 뷰(UICollectionView) 또는 리스트 뷰(UITableView)로 확인할 수 있습니다.
    - 뷰 방식은 하단 탭 바 메뉴(UITabBarController)를 사용해 전환할 수 있습니다.
    - 그리드 또는 리스트 뷰에서 각 항목을 누르면 사진 정보를 볼 수 있는 화면으로 이동합니다. (UINavigationController)

# Technologies

- Languages: Swift
- Libraries / Framework:
    - Code based UIKit:
        - Apple 의 SwiftUI 도입 후, 코드 기반 작성 방식으로 추세가 변함에 따라 전통적인 스토리보드 방식보다는 code based UI를 사용하고자 합니다. 해당 프로젝트도 code based UI 를 사용하고 있습니다.

    - Alamofire:
        - iOS SDK 의 URLSession 보다 추상화되어있고 코드가 간결한 Alamofire 라이브러리를 사용하여 Unsplash 에서 제공하는 REST API 와 네트워킹합니다. 대중적으로 사용되며 계속해서 유지보수가 되는 Alamofire 을 채택하여 사용하고 있습니다.
    
    - SnapKit:
        - Code based UIKit으로 UI framework을 관리하기 때문에 NSConstraintLayout를 직접 사용하면 코드가 필연적으로 길어지며 관리가 어려워지는 경향이 있습니다. 대중적으로 사용되며 계속해서 유지보수가 되는 SnapKit 을 채택하여 사용하고 있습니다.
    
    - DiffableDataSource:
        - iOS 13부터 도입되어 collection view들의 데이터를 알아서 관리해주는 DiffableDataSource 기능을 사용하고 있습니다. 데이터의 달라진 부분만 변경하거나 중복이 생긴 경우 예외가 발생하기 때문에 데이터 관리에 용이합니다. ViewController 에 직접 확장하여 사용해도 되지만, 코드 분리를 위하여 해당 프로젝트는 별도의 DiffableDataSource 클래스를 만들어 사용하고 있습니다.
    
    - UICollectionView 의 Compositional Layout:
        - 전통적인 UICollectionView FlowLayout 대신 다양한 형태의 grid 를 직관적으로 표현할 수 있는 compositional layout 을 사용하고 있습니다.
    
    - Combine:
        - 기능이 많아지고 화면이 복잡해지면 Code based UIKit를 사용하고 있기 때문에 전체 코드의 복잡도가 가파르게 상승합니다. UI 와 비즈니스 로직을 분리해야 유지보수성을 높일 수 있습니다. 해당 프로젝트에서는 Combine 을 사용해 비동기적으로 UI 업데이트 하는 부분을 처리하고 있습니다. MVVM 의 ViewModel 을 채택하여, ViewController 는 VIewModel을 소유하고 ViewModel 에서 화면 업데이트를 모두 담당할 수 있게 구성되어있습니다.
