# main.py
from fastapi import FastAPI
import database.session_users as session_users
from routes.routesAuth import router as auth_router

from fastapi.middleware.cors import CORSMiddleware



app = FastAPI(title="HeroForge")

#Esto para qeu no de error luego
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Permite que cualquier origen (dominio) haga peticiones
    allow_credentials=True,
    allow_methods=["*"],  # Permite GET, POST, PUT, DELETE, etc.
    allow_headers=["*"],  # Permite cabeceras como Content-Type
)

app.include_router(auth_router)


@app.on_event("startup")
def startup_event():
    session_users.init_db_users()
    pass