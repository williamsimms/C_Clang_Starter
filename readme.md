# Clang C23 Starter

A minimal, fast, batteries-included C23 template using **clang + clangd + CMake + Ninja**. Made to be cloned as a template for large C projects.

## Toolchain

- **Compiler:** clang 17+ (C23 support)
- **Language Server:** clangd (for VS Code)
- **Build System:** CMake 3.20+ + Ninja
- **Debugger:** CodeLLDB
- **Formatter:** clang-format

## Project Structure

```
.
├── .clangd              # clangd config - tells VS Code how to parse
├── .clang-format        # formatting rules
├── .vscode/settings.json
├── CMakeLists.txt       # build definition
├── src/
│   └── main.c           # entry point
└── build/               # generated (gitignored)
```

## What's Configured

### `.clangd`

```yaml
CompileFlags:
  Add: [-std=c23, -Wall]
Diagnostics:
  ClangTidy:
    Add: [performance-*, bugprone-*, modernize-*]
```

- Forces `-std=c23` so `constexpr` in C works
- Enables clang-tidy checks for performance and bugprone patterns

### `CMakeLists.txt`

Three tiers of flags from your setup:

**CLANG_WARNINGS:**
`-Wall -Wextra -Wpedantic -Wshadow -Wconversion -Wsign-conversion -Wdouble-promotion -Wformat=2 -Wformat-security -Wundef -Wvla -Wnull-dereference -Wimplicit-fallthrough -Wcast-qual -Wunused -Werror=implicit-function-declaration`

**CLANG_DEBUG (Debug build):**
`-g3 -O0 -fno-omit-frame-pointer -fstack-protector-strong -fsanitize=address,undefined,leak`

**CLANG_RELEASE (Release build):**
`-O3 -DNDEBUG -flto -march=native`

And these are enabled by default:

```cmake
set(CMAKE_C_STANDARD 23)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON) # generates compile_commands.json for clangd
set(CMAKE_C_COMPILER clang)
```

## Quick Start

### VS Code Setup (once)

1. Install extensions: `clangd`, `CMake Tools`, `CodeLLDB`
2. In settings.json:

```json
{
  "C_Cpp.intelliSenseEngine": "disabled",
  "clangd.arguments": ["--background-index", "--clang-tidy", "--completion-style=detailed"],
  "cmake.generator": "Ninja"
}
```

### Build & Run

```bash
# Configure (Debug by default, with ASan/UBSan)
cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Debug

# Build
cmake --build build

# Run
./build/main

# Release build
cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release
cmake --build build
```

In VS Code, CMake Tools does this for you: `Ctrl+Shift+P > CMake: Build`

### Debugging

Press F5. CodeLLDB will use the `-g3` and sanitizer flags. If you use ASan, leaks and buffer overflows will show in the Debug Console.

## How to Reuse This as a Template

Mark this repo as `Template repository` in GitHub Settings.

**To start a new project:**

Option A - GitHub UI (cleanest):

1. Click `Use this template > Create a new repository`
2. Clone your new repo

Option B - CLI, fresh history:

```bash
git clone https://github.com/YOU/c-clang-starter.git my-new-app
cd my-new-app
rm -rf .git
git init
git add .
git commit -m "init from clang starter"
git remote add origin https://github.com/YOU/my-new-app.git
git push -u origin main
```

## Requirements

- clang >= 17
- clangd >= 17
- cmake >= 3.20
- ninja

Check: `clang --version && clangd --version && cmake --version`
