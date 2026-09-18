# 5024153_MADL

# Flutter App in GitHub Codespaces

A step-by-step guide to setting up and running a Flutter application using **GitHub Codespaces** and **Flutter Web**.

---

## Prerequisites

* A GitHub account
* A GitHub repository
* GitHub Codespaces
* A web browser such as Microsoft Edge or Google Chrome

> **Note:** GitHub Codespaces does not require an Android emulator for this setup because the application runs using Flutter Web.

---

## Step 1: Open GitHub Codespaces

1. Go to [GitHub Codespaces](https://github.com/codespaces).
2. Click **New codespace**.
3. Select a repository:

   * Choose an existing repository, or
   * Create a new blank repository.
4. Select the default machine type.
5. Click **Create codespace**.
6. Wait for the Codespace to finish loading.

---

## Step 2: Install Flutter

Once the Codespace opens in VS Code:

1. Open the terminal using **Ctrl + `** or go to **Terminal → New Terminal**.
2. Run the following commands:

```bash
sudo apt-get update
sudo apt-get install -y curl git unzip

curl -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.5-stable.tar.xz

tar xf flutter_linux_3.19.5-stable.tar.xz

export PATH="$PATH:$(pwd)/flutter/bin"

flutter precache

flutter doctor
```

### Flutter Doctor

Run:

```bash
flutter doctor
```

You may see errors related to Android, iOS, Chrome, or Linux desktop development.

For this setup, these can generally be ignored because we are using **Flutter Web**.

---

## Step 3: Create a Flutter Project

Create a new Flutter project:

```bash
flutter create my_flutter_app
```

Navigate into the project:

```bash
cd my_flutter_app
```

Open the main Dart file:

```text
lib/main.dart
```

Replace the existing code with your Flutter UI code.

---

## Step 4: Enable Flutter Web

Enable web support by running:

```bash
flutter channel stable
flutter upgrade
flutter config --enable-web
```

You can check the available devices with:

```bash
flutter devices
```

---

## Step 5: Run the Flutter App

Run the application using the Codespaces web server:

```bash
flutter run -d web-server --web-port 3000 --web-hostname 0.0.0.0
```

The application will start on **port 3000**.

---

## Step 6: Open the App

1. Open the **Ports** tab in VS Code.
2. Find **port 3000**.
3. Hover over port `3000`.
4. Click the globe icon to open the application in a new browser tab.

Your Flutter application should now be running in your browser.

> **Using Microsoft Edge?** That's completely fine. You do not need to install Google Chrome to open the Flutter web application.

---

## Troubleshooting

### Flutter command not found

If you see:

```text
flutter: command not found
```

Run:

```bash
export PATH="$PATH:$(pwd)/flutter/bin"
```

Then verify the installation:

```bash
flutter --version
```

> You may need to run the `export PATH` command again when opening a new terminal session.

### Port 3000 is not opening

Make sure:

* Flutter is still running in the terminal.
* Port `3000` appears in the **Ports** tab.
* The port is forwarded correctly.

### Flutter Doctor shows errors

Run:

```bash
flutter doctor -v
```

Android and iOS errors can be ignored for this web-based setup.

---

## Step 7: Save Your Work to GitHub

After making changes to your Flutter project, commit and push them to GitHub:

```bash
git add .
git commit -m "Added Flutter UI example"
git push
```

Your project is now saved in your GitHub repository.

---

## Why GitHub Codespaces?

GitHub Codespaces provides a cloud-based development environment where you can develop Flutter applications without installing the complete development environment on your local computer.

Using Flutter Web means:

* No Android emulator required
* No physical Android device required
* Runs directly in a web browser
* Works with GitHub Codespaces
* Easy to save and share through GitHub

---

## Quick Start

If Flutter is already installed and your project is ready, simply run:

```bash
cd my_flutter_app

flutter config --enable-web

flutter run -d web-server --web-port 3000 --web-hostname 0.0.0.0
```

Then open:

**VS Code → Ports → 3000 → Open in Browser**

---

## Useful Commands

| Command                         | Purpose                        |
| ------------------------------- | ------------------------------ |
| `flutter doctor`                | Check Flutter installation     |
| `flutter devices`               | List available devices         |
| `flutter create my_flutter_app` | Create a new Flutter project   |
| `flutter config --enable-web`   | Enable Flutter Web             |
| `flutter run -d web-server`     | Run Flutter using a web server |
| `git add .`                     | Stage changes                  |
| `git commit -m "message"`       | Commit changes                 |
| `git push`                      | Push changes to GitHub         |
