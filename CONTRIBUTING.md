# Contribuir / Contributing

## Español

### Ejecutar pruebas
```bash
make test
```

### Linting
```bash
make lint
```

### Estructura de módulos
Cada módulo debe exponer dos funciones:

- `module_info` — imprime nombre, versión y descripción del módulo.
- `module_run` — lógica principal del módulo.

Códigos de salida:
- `0` — éxito
- `2` — uso incorrecto / argumentos inválidos
- Otro — error inesperado

### Documentación del repositorio
- `README.md` — inglés (vista por defecto en GitHub)
- `README.es.md` — español

Mantén ambos archivos alineados (misma estructura y contenido equivalente). No traduzcas nombres técnicos (`systemd`, `pacman`, flags, ids de módulos).

### Lista de verificación para Pull Requests
- [ ] `shellcheck` no reporta errores ni advertencias
- [ ] Las pruebas `bats` pasan (`make test`)
- [ ] Se agregó una entrada en `CHANGELOG.md`

---

## English

### Running tests
```bash
make test
```

### Linting
```bash
make lint
```

### Module structure
Every module must expose two functions:

- `module_info` — prints the module name, version, and description.
- `module_run` — main logic of the module.

Exit codes:
- `0` — success
- `2` — incorrect usage / invalid arguments
- Other — unexpected error

### Repository documentation
- `README.md` — English (default on GitHub)
- `README.es.md` — Spanish

Keep both files in sync (same structure and equivalent content). Do not translate technical names (`systemd`, `pacman`, flags, module ids).

### Pull Request checklist
- [ ] `shellcheck` reports no errors or warnings
- [ ] `bats` tests pass (`make test`)
- [ ] An entry has been added to `CHANGELOG.md`
