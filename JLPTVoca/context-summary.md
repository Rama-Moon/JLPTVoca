# Project Context Summary (As of 2025-09-08)

#### 1. Project Goal
- iOS 기반의 JLPT 단어 암기 앱 "JLPT Scheduler" 개발.

#### 2. Core Guidelines
- **`ProjectGuideline.md`**: 프로젝트의 목표, 명세, UI/UX 구조를 정의.
- **`GEMINI.md`**: AI-사용자 간의 협업 방식, 기술 스택, 워크플로우, 응답 형식 등 구체적인 규칙을 정의.

#### 3. Key Decisions & Work Done
- **`WordManager.swift` Refactoring**:
    - **목표**: 데이터 접근 로직의 추상화 및 복합 책임 분리를 통한 코드 직관성 향상.
    - **결과**: `fetchData`로 데이터 접근을 일원화하고, `prepareSession`의 로직을 명확한 책임 단위의 헬퍼 메서드들(`fetchReviewableStates`, `fetchNewWords`, `createStates`)로 분리 완료.
- **Tooling Issues Diagnosed**:
    - Notion 페이지 생성(`API_post_page`) 기능에 지속적인 오류가 있음을 확인. 대안으로 로컬 파일에 논의 내용을 기록하기로 결정.

#### 4. Current Status
- `WordManager` 리팩토링에 대한 논의와 기록을 모두 마쳤으며, 다음 작업을 시작하기 위해 컨텍스트를 요약하고 정리하는 단계임.
