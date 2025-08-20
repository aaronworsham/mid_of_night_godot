# Mid of Night - AI Coding Instructions

## Project Overview
A Godot 4.4 detective mystery game with modular system architecture, centralized event management, and Strapi-based data persistence. The game features inventory, dialog, mystery-solving, research mechanics, and character interactions.

## Core Architecture

### MVC System Pattern
Every major system follows this consistent structure:
- **Controller** (`*Controller.gd`): Logic coordination and event handling
- **Resource** (`*SystemResource.gd`): Data management extending `BaseDataSystemResource`  
- **View** (`*View.gd`): UI presentation and user interaction

Example: `MysteryController` + `MysterySystemResource` + `MysteryView`

### Event-Driven Communication
**Critical**: Systems communicate exclusively through `EventManager` autoload singleton - never direct references between systems.

Key signal patterns:
```gdscript
# EventManager signals for cross-system communication
EventManager.event_interactable_actor_clicked.connect(handler)
EventManager.event_mystery_discovered.emit(mystery_guid)
EventManager.event_start_dialog.emit(actor_controller)
```

### Data System Architecture
All data systems extend `BaseDataSystemResource` with member/submember hierarchy:
- **Members**: Primary entities (mysteries, dialogs, research categories)
- **Submembers**: Child entities (clues, threads, research topics)
- **Discovery system**: Track discovered vs undiscovered content via GUID arrays

Critical methods: `set_member_as_discovered()`, `get_submembers_from_member_guid()`

## Development Workflows

### Testing with GUT Framework
```bash
# Run tests via command line
godot -s res://addons/gut/gut_cmdln.gd -d
```
- Tests in `Tests/Systems/` mirror system structure
- Extend `BaseTestDataSystem` for data-driven tests  
- Use test data from `Tests/StrapiData/Collections/`
- Test naming: `*Test.gd` files with `Test*` method prefixes

### Data Updates from Strapi
```bash
# Update game data from Strapi export
./update_data.sh
```
Processes Strapi JSON collections into `Data/StrapiData/Collections/*.collection.strapi.json`

### Main Scene Launch
- Main scene: `Scenes/Chapters/MainChapter.tscn` 
- Alternative: `Scenes/Chapters/FirstChapter.tscn`
- Testing UI toggle: F1 key (`testing_ui` action)

## Key Autoloads & Dependencies
```gdscript
# Essential autoloads (configured in project.godot)
EventManager      # Central event dispatcher
UiUtility        # UI helper functions  
CharacterManager # Character data management
```

## Critical File Patterns

### System Resource Loading
```gdscript
func on_load():
    member_json = load("res://Data/StrapiData/Collections/mysteries.collection.strapi.json")
    member_string = "mystery" 
    submember_json = load("res://Data/StrapiData/Collections/clues.collection.strapi.json")
    submember_string = "clue"
    super() # Calls BaseDataSystemResource.on_load()

func on_test_load():
    # Same pattern but loads from Tests/StrapiData/Collections/
```

### Actor/Interactable Pattern  
Actors managed via `ActorController`/`ActorModel`/`ActorView` with EventManager integration:
```gdscript
EventManager.event_interactable_actor_clicked.connect(_on_actor_clicked)
EventManager.event_actor_loaded.emit(actor_model)
```

## Project-Specific Conventions

### GUID-Based References
All data entities use string GUIDs for relationships, not integer IDs. Strapi JSON structure:
```json
{
  "data": [{"id": 2, "guid": "testmystery1guid", "name": "Test Mystery 1"}],
  "meta": {"pagination": {...}}
}
```

### Input Actions
- Movement: WASD + arrows (`up`/`down`/`left`/`right`)
- Interact: Space (`click` action)
- Dialog advance: Enter/click/space/X (`dialogic_default_action`)

### Directory Structure
- `Scenes/Systems/`: System implementations with subfolders per system
- `Tests/Systems/`: Mirror system structure for tests
- `Data/StrapiData/Collections/`: Production JSON data
- `Tests/StrapiData/Collections/`: Test JSON data  
- `Assets/`: Organized by type (Sprites, Audio, Backgrounds, etc.)

## Development Anti-Patterns
- ❌ Direct system-to-system references (use EventManager)
- ❌ Loading production data in tests (use test collections)
- ❌ Skipping `super()` calls in resource loading methods
- ❌ Integer ID references instead of GUID strings
- ❌ Creating controllers without corresponding Resource/View classes

## Integration Points
- **Dialogic**: Dialog system integration with custom signal handling
- **GUT Testing**: Automated test execution via command line
- **Strapi CMS**: External data management with JSON collection exports
- **Custom UI Theme**: `Themes/test_theme.tres` for consistent styling
