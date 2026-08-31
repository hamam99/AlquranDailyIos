# AGENTS.md

> This file instructs AI coding agents working on this repository.
> Read it fully before writing, modifying, or reviewing any code.

---

## 1. Project Overview

**Alquran Reminder** (working title) is a privacy-first, ad-free iOS digital-wellbeing app. It uses Apple's **Family Controls** + **Managed Settings** frameworks to shield (block) user-selected social media apps, and lifts the shield only after the user completes a Quran reading session (default 5 minutes).

- **Core loop:** Tap social app → Shield appears → Open Alquran Reminder → Read for N minutes → Auto-unlock.
- **Mission:** Built as _Sadaqah Jariyah_ (ongoing charity). Free, no ads, no accounts.

---

## 2. Tech Stack

| Layer                   | Choice                                                          |
| ----------------------- | --------------------------------------------------------------- |
| Language                | Swift 5.9+                                                      |
| UI                      | SwiftUI (no UIKit unless required by a framework)               |
| Min deployment          | iOS 15.0 (framework floor) — **target iOS 16+**                 |
| Key frameworks          | `FamilyControls`, `ManagedSettings`, `UserNotifications`        |
| Later (do not stub yet) | `StoreKit` (donations), `DeviceActivity`                        |
| Content API             | Al-Quran Cloud (`api.alquran.cloud`)                            |
| Persistence             | `UserDefaults`/App Group (settings); file/URLCache (ayah cache) |
| Testing                 | XCTest + Swift Testing; **physical device required**            |

---

## 3. Project Structure

Follow this layout. Create files under the matching feature/module folder.

---

## 4. Coding Conventions

- Use **SwiftUI** declarative views; keep views small and composable.
- Use `@Observable` (Observation framework) or `ObservableObject` for view models; prefer value types.
- Naming: `UpperCamelCase` for types, `lowerCamelCase` for vars/funcs. Feature folders use the feature name.
- One public type per file where practical; file name = primary type name.
- Prefer `async/await` over completion handlers; no Combine for new code.
- All user-facing strings **must** go through `LocalizedStringKey` / String Catalogs. **No hardcoded UI strings.**
- Comment the _why_, not the _what_.

---

## 5. Architecture Guidelines

- **MVVM-lite.** Views stay dumb; view models hold logic; `Core/` modules own side effects.
- Wrap every system framework behind a protocol so it can be mocked in tests:
  - `AuthorizationProviding` (wraps `AuthorizationCenter`)
  - `ShieldManaging` (wraps `ManagedSettingsStore`)
  - `QuranContentProviding` (wraps the API + cache)
  - `SessionClock` (wraps Date-based timing)
- **Never** call `ManagedSettingsStore` or `AuthorizationCenter` directly from a View. Always go through a `Core/` service.
- Dependency-inject services into view models (initializer injection). Avoid singletons except a thin `AppEnvironment`.

---

## 6. Critical Rules (MUST / NEVER)

### MUST

- ✅ Use **Date-based timing** (`Date` start + `Date.now` diff) for the session clock, never `Timer.scheduledTimer` alone. (FR-09, backgrounding-safe.)
- ✅ Cache Quran content for **offline fallback** (FR-08). Ship bundled fallback passages.
- ✅ Fire a **local notification** when the session completes while backgrounded (FR-11).
- ✅ Apply/remove shields **only** through the `ShieldManaging` protocol.
- ✅ Test Family Controls behavior on a **physical device**.

### NEVER

- ❌ **No analytics, telemetry, tracking, or crash-reporting SDKs.** Privacy-first (NF-01).
- ❌ **No ads, no ad SDKs.** Ever.
- ❌ **No network calls** other than the Quran content API.
- ❌ **No dark patterns, artificial urgency, or guilt/shame copy.** (NF-06)
- ❌ **Never paywall the Quran text or the unlock action.** (Monetization rule)
- ❌ **Never hardcode Quran text** into Swift files — always fetch/cache.
- ❌ Do not add user accounts, servers, or cloud sync.

---

## 7. Domain Rules — Islamic Content

These are **hard constraints** out of respect for the source material:

- Use the **Uthmani script** edition (`quran-uthmani`) for Arabic.
- Render Arabic **RTL** with a licensed Uthmani font; do not distort or decorate ayah glyphs.
- Default English translation: `en.sahih`. Verify license/attribution before bundling any translation.
- Copy tone: **warm, encouraging, respectful.** Never judgmental.
  - ✅ _"Pause & Bismillah — a moment of light before the scroll."_
  - ❌ _"Social media is a sin."_
- Do not truncate or reflow ayahs mid-ayah across screens; keep ayah boundaries intact.

---

## 8. Family Controls / Managed Settings Rules

- Authorization type is **`.individual`** (self-management). Do not implement `.child` in v1.
- Persist the user's selected **application/category tokens** and reapply on launch.
- When configuring the Shield, set a **custom `ShieldConfiguration`** with calm copy and a primary button that opens the app (FR-06).
- **Unlock behavior:** on session completion, clear `shield.applications` / `shield.applicationCategories`. Default re-lock policy = "until end of day" (FR-14).
- If the user removes the shield via iOS Settings, **do not** re-shield silently or fight it — show a gentle reminder only.
- Guard all ManagedSettings calls for iOS availability (`if #available(iOS 15.0, *)`).

---

## 9. API Usage — Al-Quran Cloud
k
- Base URL: `https://api.alquran.cloud/v1`
- Arabic: `GET /surah/{n}/quran-uthmani`
- Translation: `GET /surah/{n}/en.sahih`
- Use `URLSession` with `async/await`. Decode into typed `Codable` models.
- Implement **caching** (URLCache or file) so the reader works offline.
- Handle errors gracefully with a fallback bundled passage; never crash on network failure.

---

## 10. Privacy & Compliance

- All settings and reading data stay **on-device**. No transmission anywhere.
- App Privacy label target: **"Data Not Collected."**
- Include a Privacy Policy screen (FR-13).
- No third-party SDKs that collect data.

---

## 11. Testing Requirements

- Unit-test `Core/` logic: `SessionClock` (Date math), cache logic, token persistence, unlock flow (via mocks).
- Mock `AuthorizationProviding` and `ShieldManaging` in tests; never hit real APIs in tests.
- **Manual device checklist** for any change touching shields/authorization (Simulator unsupported):
  - [ ] Authorization prompt appears once
  - [ ] Shield shows over selected app with custom copy
  - [ ] Primary button opens Tilawah Focus
  - [ ] Timer completes while backgrounded → notification fires
  - [ ] Shield cleared after completion

---

## 12. Build & Run

- Open `TilawahFocus.xcodeproj` (or `.xcworkspace`) in latest Xcode.
- Select a **physical iPhone** target (iOS 16+).
- Signing requires the **Family Controls** capability/entitlement (requested via Apple Developer portal).
- If the entitlement is not yet approved, shield features will fail at runtime — guard and show an explanatory fallback.

---

## 13. Common Pitfalls (for agents)

1. **`Timer` dies in background** → always compute elapsed time from a stored start `Date`.
2. **Simulator can't run Family Controls** → don't write tests that depend on the real shield; mock it.
3. **Shield property names** → verify exact `ManagedSettingsStore.shield` API against current SDK docs before assuming property names.
4. **RTL/Arabic rendering** → test with the real Uthmani font; system font may not render diacritics correctly.
5. **Localization** → never concatenate user-facing strings; use formatted localizations.
6. **Token persistence** → tokens are opaque; persist via `Codable` in an App Group, don't serialize internals.

---

## 14. Definition of Done

A change is complete when:

- [ ] Code compiles with zero new warnings.
- [ ] No new network calls, SDKs, or data collection introduced.
- [ ] All new UI strings are localized.
- [ ] Relevant unit tests added/updated and passing.
- [ ] No guilt/shame copy introduced.
- [ ] Family Controls impact tested on a physical device (if applicable).
