# main.py
from fastapi import FastAPI,HTTPException, Header, Depends
import database.session_heroForge as session_heroForge
from routes.routesAuth import router as auth_router
from routes.routesPersonajes import router as personajes_router
from fastapi.staticfiles import StaticFiles
from fastapi.middleware.cors import CORSMiddleware
import os
from services import security 




app = FastAPI(title="HeroForge")


def verificar_token(authorization: str = Header(...)):
    token = authorization.replace("Bearer ", "")
    payload = security.verify_token(token)
    if not payload:
        raise HTTPException(status_code=401, detail="Token inválido")
    return payload

#Esto para qeu no de error luego
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Permite que cualquier origen (dominio) haga peticiones
    allow_credentials=True,
    allow_methods=["*"],  # Permite GET, POST, PUT, DELETE, etc.
    allow_headers=["*"],  # Permite cabeceras como Content-Type
)

os.makedirs("uploads", exist_ok=True)
#Para poder aceptar la subida de archivos (en este caso la uso para imagenes)
app.mount("/uploads", StaticFiles(directory="uploads"), name="uploads")


app.include_router(auth_router)
app.include_router(personajes_router,  dependencies=[Depends(verificar_token)])


@app.on_event("startup")
def startup_event():
    session_heroForge.init_db_users()
    pass