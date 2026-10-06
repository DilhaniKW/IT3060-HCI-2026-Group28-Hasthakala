# Deviations from the Milestone 02 High-Fidelity Prototype

Assignment 3 requires every difference between the implemented app and the hi-fi prototype to be
documented and justified. Format: interface, prototype behaviour, implemented behaviour, reason,
impact on requirements / HCI intent.

| ID | Interface | Prototype (hi-fi) | Implemented | Reason | Impact |
|---|---|---|---|---|---|
| DV1 | I01 | "Choose Language" screen (English / Sinhala / Tamil) | Not implemented yet; English only. `users.preferredLanguage` reserved for later. | Translating every member's screens was not feasible in the implementation window (decision D2). | No FR depends on it. Reduces reach for tourists/non-English users (Milestone 01 language finding) - noted as future work. |
| DV2 | I01 | Sign-in options: Google, biometrics, passkey | Email/password only (so far). | Time and per-machine setup cost (Google sign-in needs each developer's signing fingerprint) within the 3-day window (decision D3). Not a platform limitation. | Core I01 flow and NFR3 unaffected; fewer sign-in choices. |
| DV3 | I13 | "Invitation sent - Tharushi will receive an invitation" | Invitation sent screen also shows a 6-digit code the owner shares with the supporter. | No SMS/notification backend; a typed phone number alone does not prove identity (decision D4). | Keeps FR9 and strengthens NFR3. One extra step for the owner. |
| DV4 | I13 | No screen for the supporter to accept | "Accept support invitation" screen (Profile): supporter enters phone number + code. | Needed to complete D4 securely (derived design mechanism). | Supporter still signs in as herself; access only after acceptance. |
| DV5 | I13 | Family Assistance lists authorised users only | Also lists pending invitations with Cancel. | Owner needs to see/cancel unused codes (error recovery, user control). | Supports FR9; adds the I13 Delete operation. |
| DV6 | I05 | Change Photo / Add Photo with upload, uploading and upload-error states | Initials avatar; "Photo upload will be available soon." | Photo upload needs Cloud Storage, which needs the Blaze billing plan (decision T6, not enabled yet). | FR1 still met (name, craft, about, location). Less visual trust; to add if Storage is enabled. |
