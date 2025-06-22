# PPIII-TP-DockerFile

Este proyecto contiene la configuración y automatización para construir una imagen personalizada de Debian usando Docker, y automatizar el flujo completo con un script en PowerShell.

## ¿Qué incluye este proyecto?

- **Dockerfile**: Define la imagen personalizada basada en Debian.
- **setup-docker.ps1**: Script PowerShell para automatizar la construcción, ejecución y subida del Dockerfile a GitHub.
- **README.md**: Esta guía rápida de uso.

---

## Estructura del proyecto

```
Dockerfile
setup-docker.ps1
README.md
```

---

## ¿Cómo usar este proyecto?

### 1. Construir y ejecutar la imagen Docker (con el script)

> **Requisitos:**  
> - Tener instalado [Docker Desktop](https://www.docker.com/products/docker-desktop/)  
> - Tener [Git](https://git-scm.com/)  
> - PowerShell 5.1+ (Windows) o PowerShell Core

1. **Ejecuta el script PowerShell para automatizar todo:**

    ```powershell
    .\setup-docker.ps1
    ```

   El script hará lo siguiente:
   - Verifica que Docker esté corriendo.
   - Crea el Dockerfile si no existe.
   - Descarga la imagen base de Debian.
   - Construye la imagen Docker.
   - Ejecuta el contenedor en modo interactivo.
   - Realiza el commit y push del Dockerfile al repositorio de GitHub.

---

### 2. Uso manual del Dockerfile (opcional)

Si prefieres ejecutar los comandos por separado:

```powershell
# Construir la imagen
docker build -t mi-debian:latest .

# Ejecutar el contenedor
docker run -it --rm mi-debian:latest /bin/bash
```

---

## Personalización

- Puedes modificar el Dockerfile para instalar paquetes o herramientas adicionales según tu necesidad.
- El script se puede ajustar para agregar otros archivos al repo o cambiar los comandos ejecutados en el contenedor.

---

## Autor

Dario Coronel  
dario.coronel@gmail.com

---

## Enlaces útiles

- [Documentación oficial de Docker](https://docs.docker.com/)
- [Documentación oficial de PowerShell](https://docs.microsoft.com/powershell/)
