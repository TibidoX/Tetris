# Тетрис для ОС Аврора

Тетрис для ОС Аврора

The source code of the project is provided under
[the license](LICENSE.BSD-3-CLAUSE.md),
that allows it to be used in third-party applications.

## Project Structure

The project has a common structure
of an application based on C++ and QML for Aurora OS.

* **[ru.auroraos.Tetris.pro](ru.auroraos.Tetris.pro)** file
  describes the project structure for the qmake build system.
* **[icons](icons)** directory contains application icons for different screen resolutions.
* **[qml](qml)** directory contains the QML source code and the UI resources.
  * **[cover](qml/cover)** directory contains the application cover implementations.
  * **[icons](qml/icons)** directory contains the custom UI icons.
  * **[pages](qml/pages)** directory contains the application pages.
  * **[Tetris.qml](qml/Tetris.qml)** file
    provides the application window implementation.
* **[rpm](rpm)** directory contains the rpm-package build settings.
  **[ru.auroraos.Tetris.spec](rpm/ru.auroraos.Tetris.spec)** file is used by rpmbuild tool.
  It is generated from **[ru.auroraos.Tetris.yaml](rpm/ru.auroraos.Tetris.yaml)** file.
* **[src](src)** directory contains the C++ source code.
  * **[main.cpp](src/main.cpp)** file is the application entry point.
* **[translations](translations)** directory contains the UI translation files.
* **[ru.auroraos.Tetris.desktop](ru.auroraos.Tetris.desktop)** file
  defines the display and parameters for launching the application.