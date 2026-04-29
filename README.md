# ⚽ FCF Colombia

Plataforma completa de fútbol colombiano y sudamericano.

Incluye:
- 📱 App Flutter (Frontend)
- ⚙️ API Spring Boot (Backend)
- 🗄️ PostgreSQL

---

## 🚀 Cómo ejecutar

### Backend

```bash
cd backend_api
mvn clean package -DskipTests
java -jar target/fcf-colombia-backend-1.0.0.jar

Servidor:

http://localhost:8080/api/v1


Flutter

cd fcf_colombia_by_layton
flutter pub get
flutter run

🧱 Estructura

workspace/
├── fcf_colombia_by_layton/   # Flutter
└── backend_api/              # Spring Boot

📊 Estado actual

✅ Matches (frontend + backend)
⚠️ Teams (requiere alineación frontend)
⚠️ Home / Explore (en refactor)
⏳ Players / Tournaments / News (pendientes)

## ✨ Features

- Matches, teams, players, tournaments
- Favorites system
- 🔥 Kit history by team (football jerseys timeline)
- 🔥 Personal collection of favorite kits

📘 Documentación

SYSTEM_ARCHITECTURE.md → arquitectura completa
DEVELOPMENT_WORKFLOW.md → reglas de desarrollo
MODULE_STATUS.md → estado de módulos