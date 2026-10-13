# davinci-bolta

주식회사 다빈치의 세금계산서 CLI입니다. macOS 11 이상에서 Apple Silicon과 Intel 모두 지원합니다. Python이나 Rust는 필요하지 않습니다.

## 설치

Homebrew로 설치한 뒤 처음 실행할 때 별도로 전달받은 API 키를 입력하세요. GitHub 로그인은 필요하지 않습니다.

```sh
brew install DongeunPaeng/tap/davinci-bolta
davinci-bolta
```

처음 실행하면 별도로 전달받은 API 키를 한 번 입력합니다. 입력 중에는 키가 화면에 표시되지 않으며 이 Mac에만 보관합니다. 그다음부터 다시 묻지 않습니다. 키 종류에 맞춰 테스트 또는 실제 발행 모드를 설정하고 등록된 발급자를 연결합니다.

## 사용

```sh
davinci-bolta
davinci-bolta --mode test
davinci-bolta --mode live
```

저장된 고객을 번호로 선택하고 공급가액과 품목을 입력합니다. 새 고객은 한 번 등록합니다. 마지막 화면에서 `1. 발행`, `2. 수정`, `3. 취소`를 번호로 선택하세요. Enter는 취소입니다.

입력과 결과 CSV는 자동 보관하며 파일 경로, 서버 주소, 인증서 만료일과 접수 키는 출력하지 않습니다. 최종 발행 결과와 오류는 표시합니다.

키를 변경할 때는 `davinci-bolta configure`, 발행 결과를 다시 확인할 때는 `davinci-bolta status`를 사용하세요.

API 키, 고객 정보, 발급자 상태와 발행 기록은 `~/.local/share/bolta-cli`에 보관합니다. Homebrew 업그레이드나 삭제 시 해당 데이터는 지우지 않습니다. 이 저장소와 실행 파일에는 실제 API 키나 고객 정보가 없습니다.

## 업데이트

```sh
brew update
brew upgrade davinci-bolta
```

실행 파일은 Developer ID Application 인증서로 서명했습니다. 현재 Apple 공증은 적용하지 않았습니다.

이전 설치에서 새 저장소로 바꾸려면 아래 명령을 사용하세요. 고객 정보, API 키와 발행 기록은 유지됩니다.

```sh
brew uninstall davinci-bolta
brew install DongeunPaeng/tap/davinci-bolta
```
