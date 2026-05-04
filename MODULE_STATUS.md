# 📊 Module Status

---

## 🟢 CIERRE FUNCIONAL FRONTEND

### Matches
- Backend: ❌
- Frontend: ✅
- Estado: cerrado funcionalmente (MVP frontend completo)
- Cobertura actual:
  - MatchesScreen con providers reales
  - MatchDetailScreen con `matchDetailProvider(matchId)`
  - Estados loading/error/data
  - Favoritos con `favoritesProvider`
  - Sin placeholders principales en detalle
  - Estadísticas/Eventos con empty states claros
- Pendiente:
  - Diseño premium (fase final)
  - Limpieza técnica global (warnings/lints)

### Teams
- Backend: ❌
- Frontend: ✅
- Estado: cerrado funcionalmente (MVP frontend completo)
- Cobertura actual:
  - TeamsScreen con provider real y navegación al detalle
  - TeamDetailScreen con provider por `teamId`
  - Estados loading/error/empty/data
  - Fallback local desde `assets/data/teams.json`
  - Favoritos con `favoritesProvider` usando formato `team:id`
  - Integración de Kit History vía `KitHistorySection(teamId)`
- Pendiente:
  - Diseño premium (fase final)
  - Limpieza técnica global (warnings/lints)

### Kit History
- Backend: ❌
- Frontend: ✅ (funcional básico)
- Estado: implementado funcionalmente (MVP base)
- Cobertura actual:
  - Submódulo con Clean Architecture (domain/data/presentation)
  - Fuente local desde `assets/data/kits.json`
  - Integración en `TeamDetailScreen` mediante `KitHistorySection(teamId)`
  - Estados loading/error/empty/data
  - Máximo 3 camisetas en detalle + CTA "Ver historia completa"
  - Favoritos de kits con `favoritesProvider` usando formato `kit:id`
- Pendiente:
  - Pantalla completa de historial (si se decide navegar)
  - Diseño premium (fase final)
  - Limpieza técnica global (warnings/lints)

---

## 🟡 PARCIALES

---

### Home
- UI: ⚠️
- Pendiente:
  - Integrar con Matches
  - Usar providers

---

### Explore
- Estado: mock
- Pendiente:
  - Navegación real

---

### Favorites
- UI: ✅
- Persistencia: ✅
- Pendiente:
  - Soporte para kits

---

### Settings
- UI: ✅
- Persistencia: ✅

---

---

## 🔴 PENDIENTES

- Players
- Tournaments
- Standings
- News
- Multimedia

---

## 🧠 NOTAS

- Matches es referencia base
- El backend no está incluido en este repositorio
- No iniciar módulos nuevos sin cerrar los actuales
- Evitar placeholders innecesarios

---

## 🎯 PRIORIDAD

1. Home (real)
2. Explore (hub)
3. Players
4. Tournaments + Standings
5. News
6. Multimedia
7. Favorites global
8. Settings global
9. Diseño premium final