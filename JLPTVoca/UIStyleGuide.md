# UI 구현 스타일 가이드 (참고 프로젝트 분석)

이 문서는 `UIStyleReference` 프로젝트 분석을 통해 도출된, 우리 프로젝트가 지향할 UI 구현 원칙과 패턴을 정리합니다.

---

## 1. 상수 관리 (Constants Management)

코드의 일관성과 유지보수성을 위해 '매직 넘버'나 '하드코딩된 문자열' 사용을 지양하고, `enum`을 활용한 네임스페이스로 상수를 관리합니다.

- **원칙**: `case`가 없는 `enum`과 `static let`을 사용하여 인스턴스 생성을 막고 명확한 접근을 보장합니다.
- **파일 구조**:
    - `Constants/` 폴더를 생성하여 상수 관련 파일을 모읍니다.
    - `LayoutConstants.swift`: `Padding`, `CornerRadius` 등 UI 레이아웃 숫자 값을 카테고리별 `enum`으로 분리하여 관리합니다. (`Padding.medium`)
    - `StringConstants.swift`: `AlertTitle`, `ButtonTitle` 등 문자열을 `enum`으로 분리하여 관리합니다. (`AlertTitle.changeLevel`)
- **뷰 내부 상수**: 특정 뷰에서만 사용되는 상수는 `fileprivate enum`을 사용하여 해당 뷰 내부에 지역적으로 선언합니다.

## 2. 반응형 레이아웃 (Responsive Layout)

다양한 화면 크기에 대응하기 위해 고정된 크기 대신 유연하고 상대적인 크기를 사용합니다.

- **원칙**: 전역 화면 크기(`UIScreen.main.bounds`)에 직접 의존하지 않습니다. 뷰는 자신이 속한 **부모 컨테이너의 크기**에 따라 반응해야 합니다.
- **주요 기술**:
    - **`GeometryReader`**: 부모 뷰의 크기를 기준으로 자식 뷰의 크기나 위치를 '비율'로 정해야 하는 복잡한 레이아웃에서 사용합니다.
    - **`frame(maxWidth: .infinity)`**: 너비를 유연하게 확장해야 하는 컴포넌트에 사용합니다.
    - **높이 자동 계산**: 높이를 명시적으로 지정하지 않고, `Text`나 `VStack` 등의 콘텐츠에 따라 높이가 자연스럽게 결정되도록 합니다. 팝업(Modal) 뷰에 특히 유용합니다.

## 3. 수정자 및 스타일링 (Modifiers & Styling)

수정자의 순서와 역할을 명확히 이해하고, 재사용 가능한 스타일을 만듭니다.

- **모양과 테두리**: `.cornerRadius()` 대신 `.clipShape(RoundedRectangle(...))`을 사용합니다. 테두리는 `.border()` 대신 `.overlay(RoundedRectangle(...).stroke(...))`를 사용하여, 잘려진 모양을 완벽하게 따라가도록 구현합니다.
- **배경과 여백**: `.background()`를 `.padding()`보다 **먼저** 호출하여 배경을 채운 뒤, **나중에** `.padding()`을 호출하여 '외부 간격'을 만듭니다. 수정자 적용 순서의 중요성을 항상 인지합니다.
- **커스텀 수정자 (`ViewModifier`)**: 여러 수정자의 조합(예: 그림자)을 하나의 커스텀 수정자(예: `.customShadow()`)로 만들어 코드 중복을 줄이고 스타일의 일관성을 유지합니다.

## 4. 컴포넌트 설계 (Component Design)

뷰를 작고 재사용 가능한 단위로 분리하여 관리합니다.

- **단일 책임 원칙**: 하나의 뷰는 하나의 기능만 담당하도록 설계합니다. (예: `WordStudyView`를 `WordDeckView`, `StudyPopupView` 등으로 분리)
- **프로토콜 기반 설계**: `FormFieldType`, `OtherMenuButton`과 같은 프로토콜을 정의하여, 데이터의 세부 타입에 얽매이지 않는 **범용 컴포넌트(Generic Component)**를 설계합니다. 이는 앱의 확장성과 재사용성을 극대화하는 고급 패턴입니다.

## 5. 고급 패턴 (Advanced Patterns)

- **`PreferenceKey`**: 자식 뷰에서 발생한 레이아웃 정보(크기, 위치 등)를 부모 뷰로 전달하여, 스크롤 위치에 따른 애니메이션 등 복잡한 상호작용을 구현할 때 사용합니다.
