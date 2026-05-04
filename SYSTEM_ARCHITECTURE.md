# 📘 System Architecture – FCF Colombia

---

## 🧠 Visión

Sistema modular de información futbolística:

- Flutter App
- Spring Boot API (documentado, no incluido en este repo)
- PostgreSQL (documentado, no incluido en este repo)

---

## 🧑‍💻 Arquitectura Global

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

Estructura (documentada, no incluida):

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
- Matches ❌
- Teams ❌

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