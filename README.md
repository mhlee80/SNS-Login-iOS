# SNS-Login

## Google, Facebook, Kakao 로그인 구현

### before start
  - AppDelegate, SceneDelegate 먼저 살펴 볼 것.
  - .plist 수정 작업시 "Open as -> Source Code"를 이용해 주세요
  - 현재 설정되어 있는 GoogleService-Info.plist 및 앱 ID는 유효하지 않습니다.
  - 공식 홈페이지의 가이드 예제를 보면 "Target -> Info -> URL Types" 설정이 있는데, 아래에서 언급하는 Info.plist 관련 부분을 수정하면 관련 항목이 모두 설정 됩니다.

### Google login
  - cocoapods을 이용하여 로그인 킷 설치
  - Firebase console에서 프로젝트 생성
  - 프로젝트에서 iOS 앱 생성
  - GoogleService-Info.plist 다운로드 및 프로젝트에 있는 것과 교체
  - GoogleService-Info.plist에서 RESERVED_CLIENT_ID 추출
  - 추출한 RESERVED_CLIENT_ID로 Info.plist의 [RESERVED_CLIENT_ID] 교체
  - 코드 실행

### Facebook login
  - cocoapods을 이용하여 로그인 킷 설치
  - Facebook developer에서 앱 생성 및 앱 ID 추출
  - Facebook 로그인에서 iOS 플랫폼 생성
  - 추출한 앱 ID로 Info.plist의 [FB_APP_ID] 교체
  - 다른 프로젝트에 적용시 Info.plist의 LSApplicationQueriesSchemes에서 페이스북 관련 항목 추가해야함
  - 코드 실행

### Kakao login
  - SDK 다운로드 및 프로젝트에 추가
  - 카카오 developer에서 앱 생성 및 네이티브 앱 키 추출
  - iOS 플랫폼 생성 (번들 ID 입력)
  - 사용자 관리 -> 활성화 및 로그인 동의항목 설정
  - 추출한 네이티브 앱키로 Info.plist의 [KAKAO_NATIVE_APP_KEY] 부분 모두 교체
  - 다른 프로젝트에 적용시 Info.plist의 LSApplicationQueriesSchemes에서 카카오톡 관련 항목 추가해야함
  - 다른 프로젝트에 적용시 Target -> Build Settings -> Linking -> Other Linker Flags에 "-all_load"
  - 코드 실행

