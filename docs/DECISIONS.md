# Decisions Log — Hasthakala (Group 28)

| ID | Date | Decision | Reason | Affects |
|---|---|---|---|---|
| T1 | 05 Oct | Stack: Flutter + Firebase (Auth, Firestore, Storage) | No custom API layer to build/host; integrated mobile services | All |
| T2 | 05 Oct | Flutter 3.47.6 / Dart 3.13.5 for all members | `.metadata` revision 5fc3468; identical builds | All |
| T3 | 05 Oct | Android application ID `lk.hasthakala.app` | Must be final before Firebase registration | All |
| T4 | 05 Oct | `kotlin.incremental=false` in android/gradle.properties | Kotlin cache fails when project (D:) and pub cache (C:) are on different drives on Windows | All (Windows) |
| T5 | 06 Oct | Firebase project `hasthakala-group28`, Firestore `asia-south1`, Email/Password auth | Closest region; simplest auth for 3-day scope | All |
| T6 | 06 Oct | Cloud Storage deferred (needs Blaze billing) | Pending group decision on billing | I05, I11 images |
| D1 | 06 Oct | Contexts instead of a role field; "Continue as" only with >1 context | Hi-fi shows multi-context accounts; Prompt 2 forbids asking every login | I01, all routing |
| D2 | 06 Oct | English only for now; language screen not implemented yet | Time; may be added if time allows (users.preferredLanguage reserved) | I01 (deviation) |
| D3 | 06 Oct | Email/password only for now; Google/passkey/biometrics not implemented yet | Time and per-machine setup cost; may be added if time allows | I01 (deviation) |
| D4 | 06 Oct | I13 invite: phone-number form as designed + 6-digit invite code | No SMS backend; a typed phone number does not prove identity (NFR3) | I13 (minor deviation) |
| D5 | 06 Oct | Order status: pending, confirmed, preparing, shipped, delivered, cancelled | Matches hi-fi labels | I07, I08, I10, I12 |
| S1 | 06 Oct | Firestore schema locked (docs/FIREBASE_SCHEMA.md); additions only | Four members share the same data | All |
| S2 | 06 Oct | One order per artisan; cart in users/{uid}/cart | Clear ownership for I12 and security rules | I06, I07, I12 |
| S3 | 06 Oct | Ratings computed from reviews, not stored | Cannot be faked or go out of sync (FR4, NFR2) | I04, I05 |
| R1 | 06 Oct | **TEMPORARY** signed-in-only rules for products/orders/conversations/reviews | Unblock development; MUST become v2 owner/grant rules before functional testing | NFR3 — OPEN |
| I13a | 06 Oct | I13 invite acceptance needs BOTH the 6-digit code and the phone number the artisan entered; grant copies the invite exactly (checked by rules) | A guessed code alone is useless; supporter cannot grant themselves extra scopes (NFR3) | I13, rules v1.3 |
| I13b | 06 Oct | "Pending invitations" list with Cancel on Family Assistance (derived, category B) | Owner can see/cancel codes; gives I13 a real Delete operation | I13 |
| I13c | 06 Oct | Revoke keeps the grant with status `revoked` (not deleted) | Audit trail; re-invite reactivates via a new invite | I13 |
| I13d | 06 Oct | supportGrants gains optional field `inviteCode` (additive) | Rules check a grant against its invite | Schema S1 |
| I01a | 06 Oct | Sign-out asks for confirmation (from I01 wireframe "Sign out?") | Error prevention | I01 |
| I05a | 06 Oct | Saving the artisan name also updates `artisanName` on that artisan's products | Products keep a copy of the name; keeps buyer-facing data consistent (NFR4) | I05, I11 data |
| I05b | 06 Oct | A save that gets no server reply in 10 s is shown as "You're offline" | Firestore queues offline writes instead of failing; matches I05_HF_15 | I05 |
| I01b | 06 Oct | Sign up in two steps: Create Account makes the Auth account; users/{uid} is written after "How will you start using HASTHAKALA?" | Matches hi-fi order; if the app closes in between, next launch returns to the purpose screen | I01 |
| I01c | 06 Oct | Intro screen shown on first launch only (`shared_preferences`) | Hi-fi frame 2; not repeated every time | I01 |
| I01d | 06 Oct | Circular logo asset `assets/images/hasthakala_logo.png` (27 KB) | Logo should be circular; emblem without wordmark stays readable when small | I01, branding |
