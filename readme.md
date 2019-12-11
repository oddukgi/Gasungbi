## Gasungbi
이 앱은 Naver 서비스 API (검색) 를 사용하여 네이버 쇼핑 검색 결과를 보여줍니다.</br> 사용자는 좋아하는 물건을 선택하여 북마크 추가나 삭제를 할 수 있습니다.</br> 테이블 행을 클릭하면 자세한 가격정보를 볼 수 있습니다.</br> 사용자는 가격정보를 SNS나 메모장에 저장할 수 있습니다. 
---
This app shows item price from Naver Shopping.</br> Users can add or delete favorite items.
When click table row, it shows detail price information.</br> User can share price information from SNS or Memo app.

## Overview 
1. Search items and check price on tableview 
2. User can select favorite items
3. Just click item, user check detail price
4. Share detail price link using memo and SNS


## CocoaPods
This project have Podfile. You have to enter directory in terminal.
Type this.

```ruby
pod install
```

## Screenshot




## Technical Usage
- Rest API to interact with [Naver Open API](https://developers.naver.com/docs/search/shopping/)
- Downloading data from network resources 
- Researching and leveraging a new framework or library  
   * network library : [Alamofire](https://github.com/Alamofire/Alamofire)
   * Swift library for downloading and caching images from the web : [Kingfisher](https://github.com/onevcat/Kingfisher)
   * simple JSON Object mapping library : [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper)
- Multiple select table view 
- Show website using WKWebView
- Keep favorite item list using Core Data 




            
