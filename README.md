# Hyrule App
Demo app based on [Hyrule Compendium API](https://gadhagod.github.io/Hyrule-Compendium-API/#/) created by @gadhagod

## Features 
- **General list** with `monsters` `equipment` and `materials` from Hyrule 
- **Search** among them
- Tap and open a **detailed view** of each of them 

## Technical features
- Data locally **persisted** | See and search data while **offline**
- No needed or usage of **external dependencies** 
- **Multi-language** support
- **Dark-mode** support
- **Skeleton View** loader
- `SwiftUI` + `Combine`
- [`Unit`](https://github.com/gabrielcolmena/HyruleApp/tree/main/HyruleCompendiumTests) and [`UI`](https://github.com/gabrielcolmena/HyruleApp/tree/main/HyruleCompendiumUITests) tests coverage
- Settings view to remove persisted data
- Custom [`ToastView`](https://github.com/gabrielcolmena/HyruleApp/blob/main/HyruleCompendium/Common/Views/Toast.swift) for error handling

## Architecture
MVVM (using SwiftUI)

## Data Persistence
Core Data
