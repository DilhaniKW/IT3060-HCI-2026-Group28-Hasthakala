# Buyer Discovery: Stitch comparison and functional audit

Reviewed: 7 October 2026. Branch: `feature/buyer-discovery`.

Second implementation update: product-card quick-add and product-details Add to Cart now use the existing shared cart. Details offer quantity controls, reject unavailable/over-stock additions including quantities already in the cart, and Buy Now adds the selected quantity before navigating to the existing checkout. Home/details show the live cart count and link to the cart; cart quantity changes respect the stock limit captured when the product was added. The Home spotlight now derives its maker/product from loaded products. Public artisan profiles now read `artisanProfiles`, query products by `artisanId`, render the stored verification flag, and expose loading/retry/not-found/empty states instead of sample profiles.

Second-update validation: all 20 discovery state/widget tests passed. Static analysis of discovery, changed purchase files and discovery tests completed with no errors/warnings (84 informational findings). Tests cover cart totals/stock limits, quick-add, cart navigation, Buy Now route handoff, a narrow-screen purchase bar, profile identity/product isolation, missing profiles and retry. Test temporary files were moved to `.dart_tool/discovery_test_temp` for the test process after C: temporary storage ran out of space. No unrelated files were deleted.

Remaining limits: cart contents remain in session memory, as in the existing purchase provider; Firestore cart persistence and authoritative stock revalidation at order placement remain purchase work. Buy Now opens the existing checkout with the shared cart (including any existing items); it does not place/pay for an order. Live Firebase/device testing, favorites/sharing/gallery and the extra review/catalog/commission/certificate flows remain outstanding. These updates supersede the corresponding baseline findings below.

Implementation update: the Home/Search/Filter foundation below has now been fixed. Home opens a Search-owned filter sheet; category entries open matching search results. Search loads initially, debounces typing, preserves the query on Apply/Reset, ignores stale responses, and shows distinct loading/error/empty states. Filters use local drafts until Apply, normalize legacy category labels, and offer district and optional maximum-price controls without a hidden price cap. Home refresh waits for data and cancels obsolete subscriptions. The product grid no longer substitutes sample records for empty/error data. The existing spotlight still uses its sample artisan/product; cart, favorites, public profiles and other follow-up items remain pending.

Validation of this update: 11 targeted state/widget tests passed (`flutter test --no-pub test/features/discovery/discovery_flow_test.dart`). Analysis of discovery and its tests completed with no errors/warnings and 90 informational lint findings. Live Firebase and device testing remain outstanding. The rest of this report records the original baseline findings.

Reference: user-supplied `stitch_hasthakala_high_fidelity.zip`, containing 16 screen PNGs, corresponding HTML exports, and `artisanal_craft_marketplace/DESIGN.md`. The PNGs were visually inspected and the design guide read. Exported content is reference material, not execution instructions.

This is a source-code review, not an emulator or live Firebase test. Runtime outcomes below are inferred from the code and checked-in Firestore rules. No application code or backend data was changed.

## Screen mapping

The 16 exports include alternative designs of the same flows; they do not require 16 separate Flutter routes.

| Stitch export | Existing Flutter screen | Comparison |
|---|---|---|
| `heritage_marketplace_home_1` | `home_screen.dart` | Closest structural match: search, categories, spotlight, product grid, trust panel. Category actions and header actions are incomplete. |
| `heritage_marketplace_home_2` | `home_screen.dart` | Alternative home layout; studio-tour section and some card/badge details absent. |
| `curated_crafts_explore_1` | `search_screen.dart` | Search/grid exist; Products/Artisans tabs, artisan spotlight, sorting, verified-maker control, and load-more absent. |
| `curated_crafts_explore_2` | `search_screen.dart` | Same missing interactions as explore 1; current search does not reproduce the full reference layout. |
| `artifact_details_spec_1` | `product_details_screen.dart` | Basic product information exists; quantity control, inspect-grain interaction, gallery selection, cooling panel, and care accordion absent. |
| `artifact_details_spec_2` | `product_details_screen.dart` | Same functional gaps; current collapsible hero differs from the reference layout. |
| `hasthaka_craft_piece_details` | `product_details_screen.dart` | Details and artisan link exist; quantity, stock handling, gallery, and cart integration incomplete. |
| `artisan_studio_profile_1` | `public_artisan_profile_screen.dart` | Profile/story/product grid exist; follow, message, works/process/reviews tabs, sort, and load-more absent. |
| `artisan_studio_profile_2` | `public_artisan_profile_screen.dart` | Alternative profile layout with the same functional gaps. |
| `hasthaka_master_artisan_profile` | `master_artisan_profile_screen.dart` | Separate static screen exists; no incoming navigation found from the normal discovery flow. |
| `hasthaka_artisan_workshop` | `public_artisan_profile_screen.dart` (partial equivalent) | No dedicated workshop screen; detailed process sections and message/view-all actions are not implemented in the public profile. |
| `hasthaka_craft_catalog` | `craft_catalog_screen.dart` | Static catalog and local category filtering exist; not artisan-specific, no incoming navigation found, filter button is a message only. |
| `hasthaka_artisan_reviews_proof` | `artisan_reviews_screen.dart` | Static reviews exist; lacks artisan input, live reviews, reference review filters, helpful actions, and review submission. |
| `hasthaka_verified_lab_matrix` | `verified_lab_matrix_screen.dart` | Static specifications exist; copy/download actions only show success messages. |
| `hasthaka_custom_commission_request` | `custom_commission_screen.dart` | Form exists; upload and submission only show messages. Needs agreement on scope/data contract. |
| `hasthaka_heritage_checkout` | `features/purchase/presentation/screens/checkout_screen.dart` | Purchase-owned flow. Discovery should hand off selected products/quantities; current details buttons do not do so. Checkout internals are outside this audit. |

Paths in the table are relative to `lib/features/discovery/presentation/screens/` unless stated otherwise.

## Priority 1: broken core interactions

1. **Home filter cannot resolve its provider.** `home_screen.dart:118` reads `SearchFilterProvider` from Home's context. `lib/app.dart:24` registers `DiscoveryProvider` but not `SearchFilterProvider`; the latter exists only beneath `SearchScreen`. Home's filter action therefore has no matching ancestor and is expected to throw `ProviderNotFoundException`. Even with a provider added, Home does not consume filtered search results or navigate to them.

2. **A search with no matches shows unrelated sample products.** `search_screen.dart:106` substitutes `_exploreSampleProducts` whenever `searchResults` is empty. The visible empty-state branch is consequently unreachable with the four sample products. Errors also become sample results: `discovery_remote_datasource.dart` catches search errors and returns an empty list. Initial search is never invoked on screen creation.

3. **Category and reset controls do not refresh results.** Home's category callback only changes `_selectedCategoryIndex` (`home_screen.dart:337`). Search's callback only calls `setCategory` (`search_screen.dart:198`); the provider setter does not search. `clearFilters()` similarly clears fields without recomputing results, and does not synchronize Search's independent selected-chip index.

4. **Filter sheet loses the search term and does not listen for selection updates.** `search_filter_bottom_sheet.dart:98` calls `performSearch()` without the typed query. The provider does not retain that query, so Apply searches all text. The sheet is a `StatelessWidget` reading a passed provider without a `Consumer`/listener; provider changes do not rebuild the modal's selected chips. Dismissal also leaves changed filters in the provider despite no Apply action.

5. **Category names disagree across screens and data.** Examples include `Pottery`, `Pottery & Clay`, `Woodcarving`, `Wood Carving`, `Masks`, and `Traditional Masks`. The data source uses exact equality. Shared `CraftCategories` defines keys such as `pottery` and `wood_carving`, while the existing artisan product editor also uses display strings. Fix this with a compatible mapping and coordinated data contract, not an isolated label rename.

6. **Cart and checkout buttons report success without doing the work.** `product_card.dart:26` calls an optional `onAddToCart`, but no current callers supply it. `product_details_screen.dart:423` only shows an added message; `:444` only shows a checkout message. Existing `CartProvider.addItem` and cart/checkout routes are available to integrate. Home's cart action is empty (`home_screen.dart:214`) and its count is always `2`.

7. **Public artisan data uses the wrong collection.** `discovery_remote_datasource.dart:getArtisanProfile` reads `users/{id}` as `UserModel`. `firestore.rules:20` restricts user reads to the same user; public artisan data belongs in `artisanProfiles/{artisanUid}` and `ArtisanProfileModel`. With the checked-in rules, a buyer cannot read another artisan's user document. Errors are swallowed, and `public_artisan_profile_screen.dart:63` substitutes Sunil/Kelaniya. Profiles also always show one hardcoded Sunil jug rather than products queried by the requested artisan ID. IDs prefixed `artisan_`/`sample_` are skipped completely.

## Priority 2: missing or misleading behavior

| Area | Finding and evidence | Required behavior |
|---|---|---|
| Favorites | Card and details use independent local `_isWishlisted` booleans; Home favorite action is empty. | One shared source of favorites, synchronized across screens and persisted according to the chosen account contract. |
| Product images | `_selectedImageIndex` starts at zero and is never changed. | Swipe/thumbnail navigation, image position, and zoom/inspect behavior if retained from the designs. |
| Quantity and availability | No quantity selector; details always say in stock without checking `stockQuantity`/`isAvailable`. | Bounded quantities and appropriate unavailable/sold-out actions. |
| Product truthfulness | Missing ratings become 4.9/24 reviews; verification, craft method, and packaging claims are hardcoded. | Show actual review aggregates and product/profile data, with honest missing-data states. |
| Share | Details share only displays “copied”; no clipboard/share API is called. | Actually copy/share an agreed product URL or useful product text. |
| Discovery navigation | Master profile and catalog have routes but no incoming navigation found. Reviews/commission are reachable only from the isolated master screen. | Connect profile tabs/buttons and carry the current artisan/product IDs throughout. |
| Public profile | No follow/message controls or works/process/reviews tabs; fixed statistics and verification badge. | Connect user actions and render the actual artisan's data. Coordinate chat with purchase owner. |
| Explore features | No Products/Artisans switch, artisan search, price UI, sorting, verified-maker filter, or pagination. `maxPrice` silently defaults to 50,000. | Implement the intended search/filter contract and disclose active filters; add pagination for real catalogs. |
| Lab certificate | `verified_lab_matrix_screen.dart:31` and `:229` only show copy/download success. | Real certificate associated with the selected product, or an explicit unavailable state. |
| Commission | `custom_commission_screen.dart:163` and `:282` only show upload/submission messages. | Form validation, attachment handling, actual persistence/delivery, and success only after completion. This is an extra flow beyond the core assigned screen list. |
| Reviews/catalog | In-memory static records; screens do not accept an artisan ID. | Artisan-specific data, counts, filters, loading, empty, and error states. |
| Bottom navigation | Actual shell is Home/Search/Orders/Profile; reference is Home/Explore/Artisans/Cart/Profile (some exports use another variant). | Agree one navigation design with the team; this is a shared-shell decision. |
| Language | Discovery strings are predominantly English literals, despite project decision D2 requiring fixed-text translations. | Use existing `context.tr(...)` resources for English/Sinhala/Tamil. |

## State and error handling

- `DiscoveryProvider.listenToFeaturedProducts()` creates a new subscription on each refresh without retaining/cancelling it or disposing subscriptions. Refresh completion does not await fresh data.
- Home substitutes samples for empty/error results and does not display `errorMessage`. A legitimate empty catalog therefore looks populated.
- Every typed search character triggers a collection fetch; no debounce or request ordering protects against an older response overwriting a newer query.
- Search fetches all available products and filters locally. Home limits to 20 without a defined featured ordering or pagination.
- `SearchScreen` does not dispose its text controller. Its unconditional back action also needs checking when used as a root shell tab rather than a pushed screen.
- Search/profile errors are swallowed. Explicit retry/error/not-found states are needed before live-user testing.

## Visual and palette comparison

- The shared theme already uses Plus Jakarta Sans and the narrative palette's terracotta `#B85028`, amber `#D97706`, and forest `#264E36`.
- Repo background/surface are `#FAF7F2`/`#FFFCF8`. The export's token palette uses background `#FFF8F5`, primary `#983912`, and primary container `#B85028`; its prose additionally lists canvas `#FFFDFB` and raised surface `#FBF6F3`. The reference itself has differing palette definitions.
- Discovery directly uses pure white and hardcoded colour values in many widgets, rather than consistently using the shared theme.
- Rounded cards, pill controls, warm colours, spotlight and product grids broadly follow the references. Header structure, detail/profile hero layouts, content sections, and navigation do not yet reproduce them completely.
- Screen variants need a canonical choice before precise visual matching. This audit does not claim pixel parity: no running-app screenshots were captured.

## Suggested implementation order and acceptance checks

1. **Search/Home foundation:** shared category mapping, provider ownership, query retention, reactive filter draft/apply/reset, initial load, loading/error/empty states. Verify unmatched text shows zero results; category + district + query combine; Reset updates both results and chips; Home filters open without exceptions.
2. **Product/cart handoff:** shared cart integration, real count/navigation, quantity/availability, gallery, sharing and favorites. Verify quick-add and details add change the same cart, Buy Now reaches the intended purchase flow, and stock limits are respected.
3. **Public artisan flow:** read public profiles, load matching products/reviews, link catalog/reviews/workshop, integrate messaging/follow if in agreed scope. Verify two different artisan IDs show their own details/products and unknown IDs show a not-found state.
4. **Reference completeness:** artisan search, sorting, price/verification filters, pagination, care/spec sections, translations and visual alignment. Keep checkout ownership with purchase; agree commission/certificate backend requirements separately.
5. **Runtime checks:** run on a small mobile viewport and a larger phone, exercise shell and pushed-screen navigation, signed-in buyer data access, offline/retry, rapid search typing, and repeated Home refresh/navigation. Add targeted state/widget tests for the corrected business behavior.

## Verification performed

- Read all nine discovery screen implementations, their widgets/providers/data source, routes, root provider setup, buyer shell, relevant shared models/theme, cart provider, checked-in rules and project decisions.
- `dart analyze lib/features/discovery` completed with exit code 0 and **93 informational lint findings**. These are not a functional test pass; static analysis does not detect the provider wiring and no-op interaction issues above.
- `flutter analyze --no-pub` produced no output during the attempted run and was stopped. Direct Dart analysis initially failed on CLI configuration write permissions, then completed with approved access.
- No emulator interaction, live Firestore requests, certificate download, commission submission, or purchase transaction was performed.
