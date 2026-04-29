# ⚙️ Development Workflow

---

## 🧠 Regla principal

Usar **matches** como módulo patrón.

---

## 🔁 Orden de desarrollo

matches (base)
teams (alinear)
home
explore
players
tournaments

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