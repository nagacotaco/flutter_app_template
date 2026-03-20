# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

This project uses FVM to manage Flutter versions (3.41.4). All Flutter commands must be prefixed with `fvm`.

```bash
make get          # Install dependencies (fvm flutter pub get)
make analyze      # Lint (fvm flutter analyze)
make format       # Format code (dart format .)
make test         # Run all tests (fvm flutter test)
make br           # Run build_runner (dart run build_runner build --delete-conflicting-outputs)
make clean        # Clean build artifacts
make refresh      # clean + get (full reset)
```

Run a single test file:
```bash
fvm flutter test test/path/to/test_file.dart
```

## Architecture

Feature-based modular structure under `lib/`:

```
lib/
├── main.dart              # Entry: ProviderScope wrapping MaterialApp
├── core/
│   ├── router/            # GoRouter setup + AppRoutes enum
│   ├── theme/             # Design tokens (colors, text styles, sizes)
│   ├── widgets/           # Shared widgets (ScaffoldWithNavBar)
│   ├── utils/
│   ├── api/
│   └── flavor/
└── features/
    ├── home/
    ├── search/
    ├── catalog/           # Design system showcase (live examples)
    └── sample_feature/    # Reference for full clean architecture
```

### State Management

**Riverpod** (`hooks_riverpod`). The `appRouter` GoRouter instance is provided via a Riverpod provider and accessed with `ref.watch(appRouter)`.

### Routing

**GoRouter** with `StatefulShellRoute` (indexed stack) for three bottom-nav tabs: Home, Search, Catalog. Routes are defined as an enum in `core/router/routes.dart`. All page transitions use a 200ms fade.

### Design System

All design tokens live in `lib/core/theme/`:

- `app_colors.dart` — semantic color constants
- `app_text_styles.dart` — full Material 3 type scale (Display → Label)
- `app_sizes.dart` — `AppSpacing`, `AppRadius`, `AppSize`, `AppElevation` constants (4dp grid)

The `CatalogPage` (`lib/features/catalog/`) is a live showcase of all design tokens and UI patterns — check it when implementing new UI to stay consistent.

### Clean Architecture (new features)

Follow the pattern in `sample_feature/`:
- `domain/` — entities and repository interfaces
- `application/` — use cases and Riverpod state notifiers
- `infrastructure/` — repository implementations and data sources
- `presentation/` — screens and widgets
