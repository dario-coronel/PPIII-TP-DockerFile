# --- CONFIGURACIÓN ---
$WorkingDir      = "C:\clases\pp3\docker\"
$DockerfilePath  = Join-Path $WorkingDir "Dockerfile"
$DockerImageName = "mi-debian"
$DockerTag       = "latest"
$GitRepoURL      = "https://github.com/dario-coronel/PPIII-TP-DockerFile.git"
$CommitMessage   = "Agrego Dockerfile para imagen Debian base"
$GitUserName     = "dario-coronel"
$GitEmail        = "dario.coronel@gmail.com"

# --- 1. Cambiar al directorio de trabajo ---
Set-Location $WorkingDir

# --- 2. Verificar que Docker esté corriendo ---
try {
    $dockerCheck = docker info 2>&1
    if ($dockerCheck -like "*Cannot connect to the Docker daemon*" -or $dockerCheck -like "*error during connect*") {
        Write-Host "`n❌ Docker NO está corriendo. Abre Docker Desktop e inténtalo de nuevo." -ForegroundColor Red
        exit 1
    }
    Write-Host "✅ Docker está corriendo."
} catch {
    Write-Host "`n❌ Docker NO está instalado o no está en PATH." -ForegroundColor Red
    exit 1
}

# --- 3. Crear el Dockerfile si no existe ---
if (!(Test-Path $DockerfilePath)) {
@"
FROM debian:latest

MAINTAINER Dario <dario.coronel@gmail.com>

RUN apt-get update && apt-get -y upgrade && apt-get clean
"@ | Set-Content $DockerfilePath
    Write-Host "`n✅ Dockerfile creado en $DockerfilePath" -ForegroundColor Green
} else {
    Write-Host "`nℹ️  Dockerfile ya existe en $DockerfilePath" -ForegroundColor Yellow
}

# --- 4. Descargar la imagen base de Debian ---
Write-Host "`n⏳ Descargando imagen debian:latest ..."
docker pull debian:latest

# --- 5. Construir la imagen Docker ---
Write-Host "`n⏳ Construyendo imagen Docker: ${DockerImageName}:${DockerTag} ..."
docker build -t "${DockerImageName}:${DockerTag}" -f $DockerfilePath $WorkingDir

# --- 6. Ejecutar el contenedor ---
Write-Host "`n⏳ Ejecutando contenedor..."
docker run -it --rm "${DockerImageName}:${DockerTag}" /bin/bash

# --- 7. Configurar Git si es necesario ---
# Comprobar configuración local, si falta, la establece.
$gitName  = git config user.name 2>$null
$gitEmail = git config user.email 2>$null
if (-not $gitName -or $gitName -eq "") {
    git config user.name $GitUserName
    Write-Host "`n✅ Configurado user.name en Git: $GitUserName"
}
if (-not $gitEmail -or $gitEmail -eq "") {
    git config user.email $GitEmail
    Write-Host "`n✅ Configurado user.email en Git: $GitEmail"
}

# --- 8. Inicializar git y conectar al repo si es necesario ---
if (!(Test-Path ".git")) {
    git init
    git branch -M main
    git remote add origin $GitRepoURL
    Write-Host "`n✅ Repo git inicializado y remoto agregado."
} else {
    Write-Host "`nℹ️  Repo git ya inicializado."
}

# --- 9. Agregar, commitear y pushear Dockerfile ---
git add Dockerfile
git commit -m $CommitMessage
git push -u origin main

Write-Host "`n🎉 ¡Listo! El Dockerfile y los cambios han sido subidos a GitHub." -ForegroundColor Green
