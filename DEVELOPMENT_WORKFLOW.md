# ⚙️ Development Workflow

---

## 🧠 Regla principal

Usar **matches** como módulo patrón.

---

## 🔁 Orden de desarrollo

1. Matches (base)
2. Teams (alinear)
3. Kit History
4. Home
5. Explore
6. Players
7. Tournaments + Standings
8. News
9. Multimedia
10. Favorites global
11. Settings global
12. Diseño premium final

---

## 🧩 Cómo crear un módulo

### Backend

1. Entity
2. Repository
3. Service
4. Controller
5. DTOs

---

### Frontend

1. Entity (domain)
2. Repository interface
3. UseCases
4. Model (DTO)
5. RemoteDataSource
6. LocalDataSource (opcional)
7. Repository impl
8. Providers
9. UI

---

## 📏 Definición de feature completa

✔ Lista  
✔ Detalle  
✔ Provider  
✔ Repository  
✔ DataSource  
✔ Navegación  
✔ UI conectada  

---
---

## 👕 New Feature: Kit History

Basado en patrón matches.

### Backend (opcional futuro)
- Kit Entity
- Kit Repository
- Kit Service
- Kit Controller

### Frontend

1. Kit entity (domain)
2. Repository interface
3. UseCase
4. KitModel (DTO)
5. DataSource
6. Repository impl
7. Provider
8. UI:
   - KitHistoryScreen
   - KitCard
   - KitDetailScreen

### Integración

- TeamDetailScreen → nueva tab "Camisetas"
- Favorites → soporte para kits
---

## ❌ Reglas estrictas

NO:
- usar `dynamic`
- saltarse capas
- conectar UI directo a API
- duplicar models
- hardcodear datos en UI

---

## 🧠 Buenas prácticas

- Reutilizar widgets
- Mantener separación de capas
- Usar providers para estado
- Centralizar lógica en repository

---

## 🔄 Flujo obligatorio


UI → Provider → UseCase → Repository → DataSource


---

## 🚀 Objetivo

Construir módulos replicables sin romper arquitectura.