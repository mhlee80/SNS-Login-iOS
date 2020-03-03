# SNS-Login

## Google, Facebook, Kakao 로그인 구현
- Google login
  - Firebase console에서 앱 생성
  - GooleService-Info.plist 다운로드 및 프로젝트에 추가
  - Targets -> Info -> URL Types 추가
    - 위의 GoogleService-Info.plist의 RESERVED_CLIENT_ID의 값을 추출
    - URL Types의 URL Schemes에 넣어준다.
  - 코드 실행

- Facebook login
  - Facebook developer에서 앱 생성
  - Info.plist 업데이트
  - Targets -> Info -> URL Types 추가
  - 코드 실행

- Kakao login
  - 카카오 developer에서 앱 생성
  - Info.plist 업데이트
  - Targets -> Info -> URL Types 추가
  - 코드 실행


현재 설정되어 있는 앱ID는 유효하지 않습니다.
