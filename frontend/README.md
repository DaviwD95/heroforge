# HeroForge 🎲

Aplicación multiplataforma para la creación, gestión y publicación de fichas de personajes de Dungeons & Dragons. Disponible en **Flutter Web** y **Android**.

---

## Tecnologías

- **Frontend:** Flutter (Web + Android)
- **Backend:** Python + FastAPI + Uvicorn
- **Base de datos:** MariaDB + SQLAlchemy
- **Herramientas:** HeidiSQL
- **IA:** Groq (llama-3.3-70b-versatile)
- **Autenticación:** JWT (python-jose + passlib/Argon2)

---

## Requisitos previos

- Python 3.10+
- Flutter SDK
- MariaDB en local
- Cuenta de Google con clave de aplicación para el email
- Clave de API de [Groq](https://console.groq.com/)

---

## Instalación del Backend

    cd backend
    python -m venv venv
    venv\Scripts\activate
    pip install -r requirements.txt

---

## Variables de entorno

Crea un archivo `.env` en la carpeta `backend` con el siguiente modelo:

    HEROFORGE_DATABASE_URL=mysql+pymysql://usuario:contraseña@localhost/heroforge

    SECRET_KEY=tu_clave_secreta

    MAIL_USERNAME=tu_correo@gmail.com
    MAIL_PASSWORD=tu_clave_de_aplicacion_google
    MAIL_FROM=tu_correo@gmail.com

    IA_KEY=tu_clave_groq

    #La ip para guardar las fotos, pones tu ip, en todo caso localhost si es pc web 
    BASE_URL=

    # Para web/Chrome:
    RESET_URL=http://localhost:3000

    # Para emulador Android (descomentar y comentar la de arriba):
    # RESET_URL=http://10.0.2.2:3000

> **MAIL_PASSWORD**: ve a los ajustes de tu cuenta de Google → Seguridad → Contraseñas de aplicaciones y genera una clave.  
> **IA_KEY**: genera una clave en [console.groq.com](https://console.groq.com/).

---

## Arrancar el backend

    uvicorn main:app --host 0.0.0.0 --port 8000 --reload

---

## Instalación del Frontend

    cd frontend
    flutter pub get

---

## Lanzar en Chrome (web)

    flutter run -d chrome --web-port 3000

---

## Lanzar en emulador Android

    Para lanzarlo en el emulador (Primero lanzamos el backend), se lanza primero flutter web en modo servidor, luego  el emulador y después que corra la aplicación.
    
    flutter run -d web-server --web-hostname 0.0.0.0 --web-port 3000
    flutter launch Pixel_6a   
    flutter run -d Pixel_6a   


---

## Lanzar en dispositivo físico por USB

Conecta el móvil con la depuración USB activada y ejecuta:

    flutter run

> En este caso cambia en `lib/Config/app_config.dart` la variable `isEmulador` a `false` y pon la IP de tu PC en la red local.

---

## Configuración según plataforma (app_config.dart)

    static const bool isEmulador = true; // false si usas móvil físico por USB

    static String get baseUrl {
      if (kIsWeb) {
        return "http://localhost:8000";
      } else if (defaultTargetPlatform == TargetPlatform.android && isEmulador) {
        return "http://10.0.2.2:8000";
      } else {
        return "http://192.168.X.X:8000"; // IP de tu PC en la red local
      }
    }

---

## Funcionalidades

- Registro e inicio de sesión con JWT
- Recuperación de contraseña por email
- CRUD de fichas de personaje (3 pasos: datos básicos, estadísticas, habilidades)
- Publicación de personajes visibles para otros usuarios
- Lanzamiento de dados (d4, d6, d8, d10, d12, d20, d100)
- Generación de historia con IA (Groq)
- Cambio de foto, nombre y email de perfil

---

## Estructura del proyecto

    heroforge/
    ├── backend/
    │   ├── main.py
    │   ├── models/
    │   ├── services/
    │   ├── database/
    │   ├── uploads/
    │   └── .env
    └── frontend/
        └── lib/
            ├── Config/
            ├── Screens/
            ├── ViewModels/
            └── models/

---

## Enlace GitHub

[https://github.com/DaviwD95/heroforge](https://github.com/DaviwD95/heroforge)