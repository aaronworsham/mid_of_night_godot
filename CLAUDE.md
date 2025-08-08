# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

"Mid of Night" is a Godot 4.4 detective mystery game featuring an inventory system, dialog system, research mechanics, and mystery-solving gameplay. The project uses a modular system architecture with centralized event management.

## Development Commands

### Testing
- **Run all tests**: `addons/gut/gut_cmdln.gd` or use the Gut GUI
- **Test configuration**: Located in `gut_config.json`
- **Test directory**: `Tests/` with system-specific test files
- **Test naming**: Files prefixed with "Test" and suffixed with ".gd"

### Game Execution  
- **Main scene**: `Scenes/Chapters/MainChapter.tscn` (configured as main scene)
- **Alternative scene**: `Scenes/Chapters/FirstChapter.tscn`

### Input Actions (defined in project.godot)
- **Movement**: WASD + arrow keys for up/down/left/right
- **Interact**: Space bar (`click` action)
- **Dialog advance**: Enter, mouse click, space, X key, or gamepad button
- **Testing UI**: F1 key (`testing_ui` action)

## Architecture

### Core System Pattern
The project follows a consistent MVC-like architecture with three main components for each system:

1. **Controller**: Handles logic and coordinates between model and view
2. **Resource**: Manages data and business logic (extends `BaseDataSystemResource`)
3. **View**: Handles UI presentation and user interaction

### Event-Driven Architecture
- **EventManager**: Centralized autoload singleton managing all cross-system communication
- **Signals**: Systems communicate through EventManager signals rather than direct references
- **Key events**: `event_interactable_actor_clicked`, `event_notebook_clicked`, `event_start_dialog`

### Base Classes
- **BaseResource**: Foundation for all resource classes
- **BaseDataSystemResource**: Specialized for systems handling collections with members/submembers
- **BaseTestDataSystem**: Base class for system tests that need data setup

### Major Systems

#### Dialog System (`Scenes/Systems/Dialog/`)
- **DialogController**: Manages dialog flow and thread execution
- **DialogSystemResource**: Handles dialog data from Strapi JSON collections
- **DialogView**: Presents dialog UI to users
- Supports threaded conversations with actor-specific dialogs

#### Inventory System (`Scenes/Systems/Inventory/`)
- Comprehensive item management with stacking, weight limits, rarity system
- Complete documentation available in `Scenes/Systems/Inventory/README.md`
- **InventorySystem**: Main coordinator class
- **ItemResource**: Individual item data and logic
- **InventoryController**: Inventory state management
- **InventoryView**: UI presentation layer

#### Mystery System (`Scenes/Systems/Mystery/`)
- **MysteryController**: Coordinates mystery-solving gameplay
- **MysterySystemResource**: Manages clues and mystery data
- **ClueCollectionResource**: Handles clue collections

#### Research System (`Scenes/Systems/Research/`)
- **ResearchController**: Manages research mechanics
- **ResearchSystemResource**: Handles research topics and categories

#### Character System (`Scenes/Systems/Character/`)
- **CharacterManager**: Autoload singleton managing character data
- **CharacterResource**: Individual character data
- **SkillResource**: Character skill definitions

#### Interactables System (`Scenes/Systems/Interactables/`)
- **ActorController**: Manages interactive actors in scenes
- **ActorModel**: Actor data and behavior
- **ActorView**: Actor UI presentation
- **ActorLoader**: Handles actor instantiation from data

#### Overtab System (`Scenes/Systems/Overtab/`)
- Recently added tab-based UI system
- **OvertabController**: Tab management logic
- **OvertabModel**: Tab data structure

### Data Management
- **Strapi Integration**: Data loaded from Strapi JSON collections in `Data/StrapiData/Collections/`
- **JSON Structure**: Collections contain arrays of data objects with GUIDs for reference
- **Skills Data**: JSON-based skill definitions in `Data/Skills/skills.json`

### UI Architecture
- **Controllers**: Located in `Scenes/Controllers/` for coordinating UI systems
- **UI Scenes**: Organized in `Scenes/UI/` for interface elements
- **Theme System**: Custom theme at `Themes/test_theme.tres`

### Testing Strategy
- **GUT Framework**: Uses Gut testing framework for unit tests
- **System Tests**: Each major system has corresponding test files in `Tests/Systems/`
- **Test Data**: Separate test data collections in `Tests/StrapiData/Collections/`
- **Base Test Classes**: Common test functionality in `Tests/Base/`

### Asset Organization
- **Assets/**: Organized by type (Audio, Sprites, Backgrounds, etc.)
- **Portraits**: Character portraits for dialog system
- **Localization**: CSV-based localization with translation files

## Key Autoloads
- **EventManager**: Central event dispatcher (`Scenes/Systems/Event/EventManager.gd`)
- **UiUtility**: UI helper functions (`Scripts/Library/UIUtility.gd`)
- **CharacterManager**: Character data management (`Scenes/Systems/Character/CharacterManager.gd`)

## Development Guidelines

### System Development
- Follow the Controller/Resource/View pattern for new systems
- Use EventManager for inter-system communication
- Extend `BaseDataSystemResource` for data-driven systems
- Place tests in `Tests/Systems/` following naming conventions

### Data Systems
- Use GUID-based references between data objects
- Implement member/submember relationships for hierarchical data
- Load data through resource classes, not directly in controllers

### Testing
- Write tests for all new systems extending appropriate base test classes
- Use test data collections separate from production data
- Run tests through Gut GUI during development