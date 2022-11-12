# Example

Example of how to use the **firestore_sqlite** project.

## Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Firebase tools](https://firebase.google.com/docs/cli)
- [Firebase project](https://firebase.google.com/docs/projects/learn-more)

## Getting Started

To make the example work with the firebase emulators you will need to create a config file at `./example/.firebaserc`.


```json
{
  "projects": {
    "default": "YOUR_PROJECT_ID"
  }
}
```

Install the firebase emulators and start them.

```bash
firebase emulators:start    
```

Watch the functions to build TypeScript.

```bash
cd functions
npm run dev
```

Run the example app.

```bash
flutter run -d chrome
```
