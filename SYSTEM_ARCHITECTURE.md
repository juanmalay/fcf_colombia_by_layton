# 📘 System Architecture – FCF Colombia

---

## 🧠 Visión

Sistema modular de información futbolística:

- Flutter App
- Spring Boot API
- PostgreSQL

---

## 🧱 Arquitectura Global


Flutter → REST API → PostgreSQL


---

## 📱 Frontend

Estructura:


feature/
├── data
├── domain
└── presentation


Capas:
- UI → Providers → UseCase → Repository → DataSource

---

## ⚙️ Backend

Estructura:


modules/
├── matches
└── teams


Capas:


controller → service → repository → entity


---

## 🔄 Flujo de datos


UI
↓
Provider
↓
Repository
↓
API
↓
Service
↓
Database


---

## 🌱 Seed Data

Se cargan automáticamente:
- 6 equipos
- 10 partidos

---

## 📊 Estado

### Backend
- Matches ✅
- Teams ✅

### Frontend
- Matches ✅
- Teams ⚠️
- Home ⚠️
- Explore ⚠️
- Otros ⏳

---

## 🧠 Decisiones clave

- Clean Architecture (Flutter)
- DTO pattern (Backend)
- Modularidad por features
- Backend desacoplado

---

## 🧭 Roadmap


matches → teams → home → explore → players → tournaments → news

---

---

## 👕 Kit History (New Feature)

Sub-módulo dentro de Teams.

Permite visualizar la historia de camisetas por equipo.

### Flujo

UI (Team Detail → Kits Tab)
↓
Provider
↓
UseCase
↓
Repository
↓
DataSource

### Nueva entidad

Kit:
- id
- teamId
- season
- type (home, away, third, goalkeeper)
- imageUrl
- brand
- sponsor
- description
- isFavorite

---

## ⭐ Favorites (Update)

El módulo ahora soporta:

- Teams
- Matches
- 🔥 Kits

---

## 🚫 Reglas

- No mezclar capas
- No usar dynamic
- No UI con lógica
- No exponer entities en backend

---

## 🎯 Principio

> Primero estabilidad, luego expansión.