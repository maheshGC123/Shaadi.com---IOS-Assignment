# Shaadi.com---IOS-Assignment

## Overview

The Matrimonial App is an iOS application that simulates a matrimonial platform, allowing users to view match cards similar to Shaadi.com. Users can accept or decline matches, and their decisions are stored persistently using Core Data, enabling offline functionality. The app utilizes an MVVM architecture and displays its UI with SwiftUI, ensuring a modern and responsive user experience.

## Features

- **Match Cards**: Displays user profiles in a card format.
- **Decision Making**: Users can accept or decline matches.
- **Persistent Storage**: Decisions are stored in Core Data for offline access.
- **API Integration**: Fetches user data from a remote API using URLSession.
- **MVVM Architecture**: Separates concerns for better maintainability and testability.
- **SwiftUI UI**: Provides a modern, declarative way to build user interfaces.

## Architecture

The app is built using the **Model-View-ViewModel (MVVM)** design pattern:

- **Model**: Contains the data structure, including user profiles and decisions.
- **View**: SwiftUI views that display the user interface and respond to user actions.
- **ViewModel**: Acts as a bridge between the model and view, handling business logic and data manipulation.

## Installation

### Prerequisites

- **Xcode** (latest version recommended)

### Step 1: Clone the Repository

```bash
git clone https://github.com/maheshGC123/Shaadi.com---IOS-Assignment.git

