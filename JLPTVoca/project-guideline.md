# 🎯 JLPT Flashcard App: Mission & Core Product

### 📌 App Overview (App Context)

*   **Project Name (Tentative):** JLPT Scheduler
*   **Platform & Language:** iOS (Swift)
*   **Core Problem to Solve:** To efficiently convert about 3,000 JLPT N2 vocabulary words into long-term memory within 6 months without forgetting them.
*   **Differentiation Strategy:** Focus on an intuitive level system with workload management to keep users motivated, rather than a complex algorithm.

### 👤 Persona

*   **User:** A student preparing for the JLPT for employment purposes.
*   **Learning Goal:** To obtain the **JLPT N2** certification through consistent study over 6+ months.
*   **Main Task:** Memorize a set amount of vocabulary (approx. 3,000 words) daily and retain it in long-term memory.
*   **Biggest Pain Point:** "I forget words as soon as I memorize them." With limited time, a method is needed to systematically manage and review a vast amount of vocabulary.

---

## 🚀 Mission

> To help students preparing for the JLPT for employment to convert thousands of words into perfect long-term memory through a scientific and efficient method, ultimately leading to success in their target exam.

---

## 🧠 Learning Algorithm & Product Specification

> ℹ️ **Note:** The detailed specification for the core learning algorithm is managed in the `WordStability.md` file.

---

## 📱 App UI/UX Breakdown

### 0. Main Navigation (TabView)
- **Purpose:** Provides the main navigation to move easily between the app's core features (Home, Dictionary, Settings).
- **Components:**
    - **First Tab:** `HomeView` (Home Icon)
    - **Second Tab:** `DictionaryView` (Book Icon)
    - **Third Tab:** `SettingView` (Settings Icon)
- **Navigation Flow:**
    - Starting a session from `HomeView` → Navigates to `WordStudyView`.
    - Clicking buttons in `DictionaryView` → Navigates to `EntireWordView` or `FavoriteWordView`.

### 1. OnboardingView
- **Purpose:** To set the user's learning goals upon first launch.
- **Key Features:** Select target exam level (N1-N5), select target exam date (using a DatePicker), set the daily goal for new words.
- **Action:** After entering all information, tapping 'Start' → Navigates to `HomeView`.

### 2. HomeView (Main Dashboard)
- **Purpose:** To summarize overall learning progress and act as the gateway to start a learning session.
- **Displayed Information:** D-Day counter for the exam, a circular progress bar for the selected level's progress, a toggle to view word counts by maturity level.
- **Actions:** `Start Learning` button → Navigates to `WordStudyView`, change JLPT level (Dropdown), navigate to Dictionary/Settings.

### 3. WordStudyView (Learning Session Screen)
- **Purpose:** The core screen for memorizing today's words.
- **Displayed Information:** Progress bar for the current session (e.g., 15/73), a flashcard (Front: Japanese, Back: Meaning/Furigana).
- **Actions:** Tap card (to flip), Swipe card (Left: Incorrect / Right: Correct), Bottom buttons (as an alternative to swiping), Favorite button, Back button (shows an alert to confirm ending the session).

### 4. DictionaryView (Dictionary Menu)
- **Purpose:** Acts as a fork to navigate to either the full word list or the favorite word list.
- **Actions:**
    - `[View All Words]` button → Navigates to `EntireWordView`.
    - `[View Favorite Words]` button → Navigates to `FavoriteWordView`.

### 5. EntireWordView (Full Word List)
- **Purpose:** To search and view details for all words.
- **Key Features:** Search field at the top, a scrollable list of all words.
- **Displayed Information:** Each list cell shows: Japanese, Korean, Furigana, Level, Maturity State, Favorite status.
- **Actions:** Search for words, toggle favorite status.

### 6. FavoriteWordView (Favorite Word List)
- **Purpose:** To view and search only the user's favorited words.
- **Key Features:** Same as `EntireWordView`, but only shows favorited words.
- **Actions:** Search within favorite words, toggle favorite off (which removes it from the list).

### 7. SettingView
- **Purpose:** To change the app's main settings.
- **Actions:** Adjust daily new word goal, reset all learning progress (with a confirmation alert).
