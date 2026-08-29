# Product Requirements Document (PRD)

**Product Name:** Alquran Reminder _(working title)_
**Tagline:** _"Connect with the Creator before connecting with the world."_
**Platform:** iOS (iPhone; iPad later)
**Document Version:** 1.0
**Date:** 2026-08-30
**Status:** Draft — for internal use & App Store entitlement application

---

## 1. Executive Summary

Alquran Reminder is a digital-wellbeing iOS app that inserts a mindful, spiritual pause before social media use. When a user attempts to open a shielded app (e.g., Instagram, TikTok, X), iOS displays a custom "Shield" screen inviting them to read the Quran for a customizable duration (default: 5 minutes). Upon completion, the app automatically lifts the shield.

The app is **free, ad-free, and privacy-first**, built in the spirit of _Sadaqah Jariyah_ (ongoing charity). It uses Apple's official **Family Controls** and **Managed Settings** frameworks — the same technology behind apps like Opal, One Sec, and Jomo.

---

## 2. Problem Statement

1. **Social media overuse:** Users spend hours daily on social apps, often mindlessly ("doomscrolling").
2. **Broken Quran habit:** Many Muslims want to read the Quran daily but forget or lack a consistent trigger.
3. **Generic blockers:** Existing screen-time apps provide friction but no meaningful, spiritually uplifting alternative activity.

## 3. Solution & Value Proposition

- **Interception:** Shield social apps at the OS level (cannot be silently bypassed inside the app).
- **Replacement:** Convert the "scroll impulse" into a 5-minute Quran session.
- **Tone:** Peaceful and encouraging — never guilt-based or judgmental.
- **Simplicity:** One core loop. No accounts, no ads, no clutter.

**Core loop:**
`Tap Instagram → Shield appears → "Start Reading" → 5-min Quran session → Auto-unlock → Open Instagram`

---

## 4. Target Audience & Personas

### Primary Audience

Muslims aged 16–35 who feel addicted to social media and want to build a daily Quran habit.

### Personas

| Persona       | Profile                                            | Pain Point                                           | Desired Outcome                                       |
| ------------- | -------------------------------------------------- | ---------------------------------------------------- | ----------------------------------------------------- |
| **Aisha, 22** | University student; 4+ hrs/day on TikTok/Instagram | Feels guilty; keeps forgetting to read Quran         | "I want my scroll impulse to become a reading habit." |
| **Yusuf, 30** | Working professional; doomscrolls at night         | Wants calm, minimal tools; hates ads & subscriptions | "A beautiful, respectful app that helps me pause."    |

### Secondary (Future)

- Parents managing children's devices (`.child` authorization) — **out of scope for v1**.
- General mindfulness users (other scriptures/meditation) — **out of scope for v1**.

---

## 5. Goals & Success Metrics

### Product Goals

- **G1:** Help users establish a daily Quran reading habit.
- **G2:** Reduce mindless social media opens.
- **G3:** Pass Apple's Family Controls entitlement review and App Store review.

### KPIs (Targets)

| Metric                                    | Target  |
| ----------------------------------------- | ------- |
| Shield → "Start Reading" tap-through rate | ≥ 60%   |
| Session completion rate                   | ≥ 80%   |
| D7 retention                              | ≥ 40%   |
| D30 retention                             | ≥ 25%   |
| App Store rating                          | ≥ 4.5 ★ |
| Crash-free sessions                       | ≥ 99.5% |

---

## 6. Scope

### In Scope (MVP)

- Family Controls authorization (`.individual`)
- App/category selection via Apple's `FamilyActivityPicker`
- OS-level Shield with custom, calming messaging
- Quran reader (Arabic Uthmani script + 1 English translation)
- Customizable session timer (1–30 min; default 5)
- Automatic unlock on completion
- Offline fallback content cache
- Onboarding, Settings, Privacy Policy

### Out of Scope (v1)

- Audio recitation, tafsir, bookmarks
- Streaks / analytics dashboards
- Web domain shielding
- Parental controls (`.child`)
- User accounts / cloud sync
- Android version
- Ads and subscriptions

---

## 7. User Flows

### 7.1 First Launch (Onboarding)

1. Welcome screen explains value proposition (3 screens max).
2. Request Family Controls authorization (`.individual`).
3. `FamilyActivityPicker` → user selects apps/categories to shield.
4. Choose session duration (default 5 min).
5. Shield applied → confirmation screen with shield preview.

### 7.2 Daily Loop

1. User taps a shielded app (e.g., Instagram).
2. iOS shows custom Shield: _"Pause & Bismillah — read for 5 minutes before scrolling."_
3. User taps primary button → Alquran Reminder opens.
4. Reader shows Quran text; countdown timer runs.
5. Timer completes → success screen (_"Barakallahu feek."_) → shield removed.
6. User opens Instagram normally (unlocked for the rest of the day by default).

### 7.3 Edge Cases

| Case                                 | Behavior                                                                     |
| ------------------------------------ | ---------------------------------------------------------------------------- |
| User dismisses shield                | Apps stay shielded; user may open Alquran Reminder anytime                   |
| User removes shield via iOS Settings | Allowed (user is in control); gentle reminder on next app launch             |
| App backgrounded during session      | Timer uses start-`Date` math (not `Timer`); local notification on completion |
| No internet                          | Serve cached / bundled fallback passage                                      |
| User never completes a session       | Apps remain shielded; no punishment messaging                                |

---

## 8. Functional Requirements

> **Priorities:** P0 = MVP must-have · P1 = should-have at/just after launch · P2 = post-launch

| ID    | Requirement                                                                         | Priority |
| ----- | ----------------------------------------------------------------------------------- | -------- |
| FR-01 | Onboarding with value explanation + consent                                         | P0       |
| FR-02 | Request `.individual` authorization via `AuthorizationCenter`                       | P0       |
| FR-03 | App/category selection via `FamilyActivityPicker`; persist selection                | P0       |
| FR-04 | Session duration picker (1–30 min; default 5)                                       | P0       |
| FR-05 | Apply Shield to selected application/category tokens via `ManagedSettingsStore`     | P0       |
| FR-06 | Custom `ShieldConfiguration` (calm copy, colors, primary button that opens the app) | P0       |
| FR-07 | Reader screen: Arabic (Uthmani) + translation, RTL layout, smooth scrolling         | P0       |
| FR-08 | Fetch text from Al-Quran Cloud / Quran.com API; cache for offline                   | P0       |
| FR-09 | Countdown timer based on start `Date`; visible progress                             | P0       |
| FR-10 | On completion: success screen + automatic shield removal                            | P0       |
| FR-11 | Local notification when session completes while backgrounded                        | P0       |
| FR-12 | Settings: duration, translation, shield preview, remove shield                      | P0       |
| FR-13 | Privacy Policy screen + data disclosure                                             | P0       |
| FR-14 | Re-lock policy: default "unlock until end of day"; optional "every attempt"         | P1       |
| FR-15 | Resume last reading position                                                        | P1       |
| FR-16 | Web domain shielding                                                                | P2       |
| FR-17 | Streaks & gentle weekly summary                                                     | P2       |
| FR-18 | Audio recitation                                                                    | P2       |
| FR-19 | Optional donations (StoreKit "tip jar")                                             | P2       |

---

## 9. Non-Functional Requirements

| ID    | Requirement                                                                                  |
| ----- | -------------------------------------------------------------------------------------------- |
| NF-01 | **Privacy-first:** all settings & reading data on-device; privacy label "Data Not Collected" |
| NF-02 | **Performance:** reader loads < 1s (cached); shield applies instantly                        |
| NF-03 | **Accessibility:** Dynamic Type, VoiceOver labels, RTL support, sufficient contrast          |
| NF-04 | **Reliability:** ≥ 99.5% crash-free sessions                                                 |
| NF-05 | **Localization-ready:** English + Arabic at launch; Bahasa/Urdu/French later                 |
| NF-06 | **Ethical design:** no dark patterns, no guilt messaging, no artificial urgency              |

---

## 10. Technical Architecture

- **UI:** SwiftUI
- **Minimum OS:** iOS 15 (framework requirement); **recommended target iOS 16+**
- **Frameworks:** `FamilyControls`, `ManagedSettings`, `UserNotifications`; `StoreKit` (post-launch)
- **Content API:** Al-Quran Cloud (`api.alquran.cloud`) — editions: `quran-uthmani` + `en.sahih`
- **Persistence:** `UserDefaults`/App Group for settings; URLCache/local file cache for ayahs
- **Testing:** Physical device required (Simulator does **not** support Family Controls)

### System Flow
