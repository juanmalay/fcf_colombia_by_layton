# FCF Colombia

App Flutter no oficial sobre la Seleccion Colombia de mayores.

## Estado actual

- Flutter multiplataforma con estructura por features.
- Navegacion principal con GoRouter y tabs persistentes.
- Matches implementado con capas domain/data/presentation, API remota y fallback local desde `assets/data/matches.json`.
- Teams implementado con capas principales, API remota y fallback local minimo.
- Home consume datos de Matches para proximo partido y resultados recientes.
- Explore navega a Teams, Players, Tournaments, News y Multimedia.
- Favorites y Settings guardan preferencias locales con `shared_preferences`.
- Players, Tournaments, News y Multimedia siguen como pantallas placeholder.

## Backend

La documentacion historica del proyecto menciona una API Spring Boot y PostgreSQL, pero este repositorio contiene solo la app Flutter. No hay carpeta `backend`, `backend_api`, `src` de backend ni configuracion de base de datos en este repo.

En desarrollo, la app intenta consumir endpoints configurados para entorno local. Si la API no esta disponible, los modulos Matches y Teams usan datos locales minimos como fallback.

## Como ejecutar

```bash
flutter pub get
flutter run
```

## Documentacion

- `SYSTEM_ARCHITECTURE.md`: vision de arquitectura.
- `DEVELOPMENT_WORKFLOW.md`: reglas de desarrollo.
- `MODULE_STATUS.md`: estado historico de modulos.
- `.project-status.json`: estado calculado del proyecto segun el repo actual.
