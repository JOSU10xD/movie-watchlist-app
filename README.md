# 🎬 Movie Watchlist App - Built with Flutter

## 🚀 Overview

**Movie Watchlist** is a cross-platform Flutter app that allows users to **search for movies** using the **OMDb API** and add them to a personal **watchlist**. It offers a simple, clean UI and offline persistence using local storage.

> 📌 *This project was built as a learning project and is inspired by modern Flutter architecture and API integration techniques.*

---

## 🧱 Tech Stack

* **Flutter** – Frontend UI and cross-platform development.
* **Dart** – Application logic and state management.
* **Provider** – Lightweight state management.
* **OMDb API** – Movie data fetching (via HTTP).
* **Shared Preferences** – Local storage of the watchlist.

---

## 🔥 Features

### ✅ Implemented

✔️ **Search for Movies** – Search any title using OMDb API.
✔️ **Detailed Movie View** – Tap any result to view extended movie details.
✔️ **Add to Watchlist** – Save any movie to your personal list.
✔️ **Reorderable List** – Drag and reorder items in your watchlist.
✔️ **Swipe to Delete** – Swipe left/right to remove movies from the list.
✔️ **Persistent Watchlist** – Saved locally using `SharedPreferences`.
✔️ **Responsive UI** – Works across Android, Windows, and other platforms.

### 🛠️ Planned

🔹 **Search Suggestions**
🔹 **Custom Movie Categories**
🔹 **Favorites / Ratings**
🔹 **Offline Movie Detail Caching**

---

## 📦 Installation

1. **Clone the Repository**

```bash
git clone https://github.com/YourUsername/movie-watchlist-flutter.git
cd movie-watchlist-flutter
```

2. **Install Dependencies**

```bash
flutter pub get
```

3. **Run the App**

```bash
flutter run
```

> 📌 Ensure you have a working Flutter environment. You can test using `flutter doctor`.

---

## 🗂️ Folder Structure

```
movie-watchlist-flutter/
│
├── lib/
│   ├── models/             # Movie model definitions
│   ├── providers/          # Watchlist state management
│   ├── screens/            # UI screens: search, watchlist, detail
│   ├── services/           # API service for OMDb interaction
│   └── main.dart           # App entry point
│
├── pubspec.yaml            # Dependencies and assets
└── README.md               # Project documentation
```

---

## 🔑 API Key Setup

This app uses the free [OMDb API](https://www.omdbapi.com/) to fetch movie data.

1. Sign up at [https://www.omdbapi.com/apikey.aspx](https://www.omdbapi.com/apikey.aspx)
2. Replace the placeholder in `api_service.dart`:

```dart
final String _apiKey = 'YOUR_API_KEY';
```

---

## 🤝 Contributing

Want to improve or add features? Feel free!

1. Fork this repo
2. Create a new branch (`feature/my-feature`)
3. Commit your changes
4. Open a pull request

---

## 📜 License

This project is open-source and available under the **MIT License**. See `LICENSE` for more details.


