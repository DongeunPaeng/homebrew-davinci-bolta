# davinci-bolta

볼타 API로 세금계산서를 발행하는 Rust CLI입니다. API 키를 가진 사업자 누구나 사용할 수 있으며 여러 법인을 지원합니다. macOS 11 이상에서 Apple Silicon과 Intel 모두 지원합니다. Python이나 Rust는 필요하지 않습니다.

## 설치

```sh
brew install DongeunPaeng/tap/davinci-bolta
davinci-bolta
```

GitHub 로그인은 필요하지 않습니다. 처음 실행하면 API 키를 입력합니다. 입력 중 키는 화면에 표시되지 않습니다. 키로 등록된 발급자의 상호, 사업자등록번호, 대표자명을 조회해 법인 설정을 만듭니다. 발급자가 여러 개면 번호로 선택하세요. API에서 제공하지 않는 발행 법인 담당자 이메일은 최초 등록 때 한 번 입력합니다. 이 이메일은 고객사 이메일과 별개입니다.

등록된 발급자가 없는 키는 법인 상호, 사업자등록번호, 대표자명도 한 번 입력합니다. 이어서 `davinci-bolta setup`으로 발급자와 공동인증서를 등록하세요.

압축 파일을 사용하는 경우, 압축을 풀고 해당 폴더에서 `sh install.sh`를 실행하세요. 실행 명령은 `~/.local/bin/davinci-bolta`에 설치됩니다.

## 여러 API 키와 법인

```sh
davinci-bolta configure
```

키를 추가하고 `1. 다른 API 키 추가`를 선택하면 여러 키를 연속 등록할 수 있습니다. 키마다 등록된 법인을 연결합니다. 같은 사업자등록번호와 종사업장번호를 가진 법인의 테스트 키와 실제 발행 키는 한 법인에 연결합니다. 한 키에 발급자가 여러 개 있으면 같은 키를 다시 등록해 다른 법인도 연결할 수 있습니다.

저장된 법인이 여러 개면 실행할 때 법인 목록을 번호로 선택합니다. 목록의 `0. API 키 추가`로 새 법인을 등록할 수도 있습니다. 선택한 법인의 키와 발급자 상태, 원장을 사용합니다. 기존 고객 정보, CSV와 발행 기록을 보존합니다. 키를 변경해도 이전 키를 보관해 접수 대기 중인 기존 건을 조회합니다.

```sh
davinci-bolta
davinci-bolta --mode test
davinci-bolta --mode live
```

`--mode`를 지정하면 해당 종류의 키만 사용합니다. 생략하면 저장된 기본 모드를 사용하며, 선택한 법인에 그 모드의 키가 없고 반대 모드의 키만 있으면 그 키를 사용합니다. 마지막 확인 화면에 테스트 또는 실제 발행 여부가 표시됩니다. 테스트 키는 실제 국세청 전송을 하지 않습니다.

자동 생성된 법인 ID는 `company-사업자등록번호` 형식입니다. 종사업장번호가 있으면 뒤에 붙습니다. 기존 설정의 법인 ID는 보존합니다. `--corporation ID`로 선택 질문을 생략할 수 있습니다.

## 발행

저장된 고객을 번호로 선택하고 공급가액과 품목을 입력합니다. 품목은 Enter로 이전 값을 재사용합니다. 새 고객은 상호, 사업자등록번호, 대표자명, **고객사 세금계산서 수신 이메일**을 한 번 입력합니다.

작성일은 오늘, 목적은 청구, 세금은 과세 10%가 기본값입니다. 마지막 화면에서 `1. 발행`, `2. 수정`, `3. 취소`를 번호로 선택하세요. Enter는 취소입니다. 수정 메뉴에서 고객사 세금계산서 수신 이메일도 변경할 수 있습니다. 테스트와 실제 발행의 입력 화면은 같습니다.

입력과 결과 CSV는 자동 보관합니다. 파일 경로, 서버 주소, 인증서 만료일과 접수 키는 출력하지 않습니다. 최종 발행 결과와 오류는 표시합니다. 같은 내용의 기존 건이 있으면 기존 상태 확인, 별도 청구로 새 발행, 취소 중 번호로 선택합니다.

```sh
davinci-bolta status
davinci-bolta validate invoices.csv
davinci-bolta --mode test issue invoices.csv --send
davinci-bolta --mode live issue invoices.csv --send --confirm-live
```

`validate`는 API 요청 없이 CSV를 검증합니다. CSV 실제 발행에는 `--send`와 `--confirm-live`가 필요합니다. 실제 발행은 국세청 전송과 볼타 포인트 차감이 발생합니다.

## 데이터와 업데이트

API 키, 법인 설정, 고객 정보, 발급자 상태, 입력 CSV와 발행 원장은 `~/.local/share/bolta-cli`에 보관합니다. 키와 설정 파일은 권한 `600`으로 저장합니다. 고객 목록은 이 Mac에서 공유하고 키와 발급자 상태, 원장은 법인과 모드별로 구분합니다. Homebrew 업그레이드나 삭제 시 데이터는 지우지 않습니다. 배포 패키지에는 실제 API 키나 특정 법인 설정, 고객 정보가 없습니다.

```sh
brew update
brew upgrade davinci-bolta
```

실행 파일은 Developer ID Application 인증서로 서명했습니다. 현재 Apple 공증은 적용하지 않았습니다.


볼타 공식 API: [발급자 목록 조회](https://docs.bolta.io/api-reference/issuer/list-issuers), [발급자 조회](https://docs.bolta.io/api-reference/issuer/retrieve-issuer).
