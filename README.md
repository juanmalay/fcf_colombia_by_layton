# FCF Colombia

App Flutter no oficial sobre la Selección Colombia de mayores.

## Estado actual

- Flutter multiplataforma con estructura por features.
- Navegación principal con GoRouter y tabs persistentes.
- Matches implementado con capas domain/data/presentation, API remota y fallback local desde `assets/data/matches.json`.
- Teams implementado con capas principales, API remota y fallback local mínimo.
- Home consume datos de Matches para próximo partido y resultados recientes.
- Explore navega a Teams, Players, Tournaments, News y Multimedia.
- Favorites y Settings guardan preferencias locales con `shared_preferences`.
- Players, Tournaments, News y Multimedia siguen como pantallas placeholder.

## Backend

La documentación histórica del proyecto menciona una API Spring Boot y PostgreSQL, pero este repositorio contiene solo la app Flutter. No hay carpeta `backend`, `backend_api`, `src` de backend ni configuración de base de datos en este repo.

En desarrollo, la app intenta consumir endpoints configurados para entorno local. Si la API no está disponible, los módulos Matches y Teams usan datos locales mínimos como fallback.

## Plan de cierre por pantalla

1. Matches
2. Teams
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

## Cómo ejecutar

```bash
flutter pub get
flutter run
```

## Documentación

- `SYSTEM_ARCHITECTURE.md`: visión de arquitectura.
- `DEVELOPMENT_WORKFLOW.md`: reglas de desarrollo.
- `MODULE_STATUS.md`: estado histórico de módulos.
- `.project-status.json`: estado calculado del proyecto según el repo actual.
