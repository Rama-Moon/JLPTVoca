# Project Context Summary (As of 2025-09-09 - Pre-Logging)

#### 1. Project Goal
- iOS 기반의 JLPT 단어 암기 앱 "JLPT Scheduler" 개발.

#### 2. Core Guidelines
- `ProjectGuideline.md`와 `GEMINI.md`에 명시된 프로젝트 명세와 협업 규칙을 따릅니다.

#### 3. Key Decisions & Work Done (up to pre-logging)
- **`WordManager.swift` Refactoring**:
    - **목표**: 데이터 접근 로직의 추상화 및 복합 책임 분리를 통한 코드 직관성 향상.
    - **결과**: 데이터 접근을 제네릭 `fetchData`로 일원화하고, `prepareSession`의 로직을 명확한 책임 단위의 헬퍼 메서드들(`fetchReviewableStates`, `fetchNewWords`, `createStates`)로 분리하여 가독성과 유지보수성을 개선했습니다.
- **`ContentView.swift` Review**:
    - **목표**: View Modifier 사용의 의미적 정확성 검토.
    - **결과**: 동기적인 `setContext` 호출에는 비동기용 `.task`보다 동기용 `.onAppear`가 더 적합하다고 판단하여 코드를 수정했습니다.

#### 4. Current Status
- `WordManager` 리팩토링과 `ContentView` 리뷰를 완료했으며, 다음 단계로 Logger 구현을 시작할 준비가 된 상태입니다.
