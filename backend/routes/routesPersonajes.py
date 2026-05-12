

from models.Personaje import Personaje
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
import models.User as User, database.session_heroForge as session_heroForge, services.security as security
import requests
from services.security import get_payload
from dotenv import load_dotenv
import os

load_dotenv()

IA_KEY = os.getenv("IA_KEY") 



router = APIRouter()

#Metodo para obtener la base de datos:
def get_db_personajes():

    db = session_heroForge.SessionLocal()

    try:
        yield db
    finally:
        db.close()



@router.get("/Personajes/get")
def getPersonajes(db : Session = Depends(get_db_personajes), payload = Depends(get_payload)):


    
    #Sacamos el email
    email = payload.get("sub")

    user = db.query(User.User).filter(User.User.email == email).first()

    if not user: 
        raise HTTPException(status_code=404, detail="Error, usuario no encontrado")
    

    personajes = db.query(Personaje).filter(Personaje.id_usuario == user.id).all()

    return personajes


@router.get("/getDatoCurioso")
def getDatoCurioso():

    

   
        #No se por que no sirven estas Api, estan muertas ¿?
        #url = "http://numbersapi.com/random/trivia?json"
        #url = f"http://numbersapi.com/{random.randint(1, 1000)}/trivia"


        #Por si una de las dos falla, a veces me falla una a veces la otra        
    try:
        url = "https://zenquotes.io/api/random"
        response = requests.get(url, timeout=5)
               
        if response.status_code == 200:
            data = response.json()
            
            return {
                "frase": data[0].get("q"),  #[{"q": "frase, "a": "autor"}]
            } 
    except Exception:
        pass     
    
    try:
        url = "https://uselessfacts.jsph.pl/random.json?language=en"
        response = requests.get(url, timeout=5)

        if response.status_code == 200:
            data = response.json()
            return {"frase": data.get("text")}
        
    except Exception:

        raise HTTPException(status_code=500, detail="Ambas APIs fallaron")

   
    raise HTTPException(status_code=500, detail="Error las dos APIS fallaron ")

@router.post("/IA/historia")
def getAyudaHistoria(data : dict ):

    historia = data.get("historia")

   # url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key={IA_KEY}"
    #url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key={IA_KEY}"
    url = "https://api.groq.com/openai/v1/chat/completions"

    response = requests.post(url,
    headers={"Authorization": f"Bearer {IA_KEY}"},
    json={
        #"model": "llama3-8b-8192",
        "model": "llama-3.3-70b-versatile",
        "messages": [{"role": "user", "content": f"Soy un personaje de D&D. Mi historia: {historia}. Continúa con un párrafo más."}]
    }
)

    data = response.json()
    print(data)

    return {"historia": data["choices"][0]["message"]["content"]}


    
@router.post("/Personajes/add")
def addPersonaje(data : dict, db : Session = Depends(get_db_personajes), payload = Depends(get_payload)):

    

    email = payload.get("sub")
    user = db.query(User.User).filter(User.User.email == email).first()

    if not user:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")

    personaje = Personaje(
        id_usuario     = user.id,
        nombre         = data.get("nombre"),
        clase          = data.get("clase"),
        raza           = data.get("raza"),
        trasfondo      = data.get("trasfondo"),
        alineamiento   = data.get("alineamiento"),
        nombre_jugador = data.get("nombre_jugador"),
        nivel          = data.get("nivel", 1),
        experiencia    = data.get("experiencia", 0),
        historia       = data.get("historia"),
        publicado      = data.get("publicado", False),
        fuerza         = data.get("fuerza", 10),
        destreza       = data.get("destreza", 10),
        constitucion   = data.get("constitucion", 10),
        inteligencia   = data.get("inteligencia", 10),
        sabiduria      = data.get("sabiduria", 10),
        carisma        = data.get("carisma", 10),
        clase_armadura   = data.get("clase_armadura", 10),
        puntos_golpe_max = data.get("puntos_golpe_max", 10),
        edad       = data.get("edad"),
        altura     = data.get("altura"),
        peso       = data.get("peso"),
        ojos       = data.get("ojos"),
        pelo       = data.get("pelo"),
        piel       = data.get("piel"),
        imagen_url = data.get("imagen_url"),
        rasgos     = data.get("rasgos"),
        ideales    = data.get("ideales"),
        vinculos   = data.get("vinculos"),
        defectos   = data.get("defectos"),
        habilidades = data.get("habilidades", {}),
    )

    db.add(personaje)
    db.commit()
    db.refresh(personaje)

    return personaje 


@router.post("/Personajes/edit")
def editPersonaje(data : dict, db : Session = Depends(get_db_personajes), payload = Depends(get_payload)):

    

    email = payload.get("sub")
    user = db.query(User.User).filter(User.User.email == email).first()

    if not user:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")
    
    personaje = db.query(Personaje).filter(Personaje.id == data.get("id"), Personaje.id_usuario == user.id).first()

    if not personaje:
        raise HTTPException(status_code=404, detail="Personaje no encontrado")

    personaje.nombre = data.get("nombre", personaje.nombre)
    personaje.clase  = data.get("clase", personaje.clase)
    personaje.raza  = data.get("raza", personaje.raza)
    personaje.trasfondo   = data.get("trasfondo", personaje.trasfondo)
    personaje.alineamiento  = data.get("alineamiento", personaje.alineamiento)
    personaje.nombre_jugador = data.get("nombre_jugador", personaje.nombre_jugador)

    personaje.nivel  = data.get("nivel", personaje.nivel)
    personaje.experiencia = data.get("experiencia", personaje.experiencia)
    personaje.historia = data.get("historia", personaje.historia)
  #  personaje.publicado = data.get("publicado", personaje.publicado)
    personaje.fuerza = data.get("fuerza", personaje.fuerza)
    personaje.destreza = data.get("destreza", personaje.destreza)

    personaje.constitucion = data.get("constitucion", personaje.constitucion)
    personaje.inteligencia = data.get("inteligencia", personaje.inteligencia)
    personaje.sabiduria = data.get("sabiduria", personaje.sabiduria)
    personaje.carisma = data.get("carisma", personaje.carisma)
    personaje.clase_armadura = data.get("clase_armadura", personaje.clase_armadura)
    personaje.puntos_golpe_max = data.get("puntos_golpe_max", personaje.puntos_golpe_max)

    personaje.edad = data.get("edad", personaje.edad)
    personaje.altura = data.get("altura", personaje.altura)
    personaje.peso = data.get("peso", personaje.peso)
    personaje.ojos = data.get("ojos", personaje.ojos)
    personaje.pelo = data.get("pelo", personaje.pelo)
    personaje.piel = data.get("piel", personaje.piel)

    personaje.imagen_url = data.get("imagen_url", personaje.imagen_url)
    personaje.rasgos = data.get("rasgos", personaje.rasgos)
    personaje.ideales = data.get("ideales", personaje.ideales)
    personaje.vinculos = data.get("vinculos", personaje.vinculos)
    personaje.defectos = data.get("defectos", personaje.defectos)
    personaje.habilidades = data.get("habilidades", personaje.habilidades)

    
    db.commit()
    db.refresh(personaje)

    return {
        "message": "Personaje añadido correctamente"
    }




@router.post("/Personajes/remove")
def removePersonaje(data : dict, db : Session = Depends(get_db_personajes), payload = Depends(get_payload)):

    

    email = payload.get("sub")
    user = db.query(User.User).filter(User.User.email == email).first()

    if not user:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")
    

    personaje = db.query(Personaje).filter(Personaje.id == data.get("id"), Personaje.id_usuario == user.id).first()

    if not personaje:
        raise HTTPException(
            status_code=404,
            detail="Personaje no encontrado"
        )    

    
    db.delete(personaje)
    db.commit()

    return {
        "message": "Personaje eliminado correctamente"
    }

  



@router.get("/Personajes/Publicados/get")
def getPersonajesPublicados(db : Session = Depends(get_db_personajes), payload = Depends(get_payload)):  

    
    email = payload.get("sub")
    user = db.query(User.User).filter(User.User.email == email).first()

    if not user:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")    

    personajes = db.query(Personaje).filter(Personaje.publicado == True).all()
    
    return personajes


@router.post("/Personajes/Publicados/add")
def addPersonajesPublicados(data : dict, db : Session = Depends(get_db_personajes), payload = Depends(get_payload)):


    
    email = payload.get("sub")
    user = db.query(User.User).filter(User.User.email == email).first()

    if not user:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")  
    
    personaje = db.query(Personaje).filter(Personaje.id == data.get("id"), Personaje.id_usuario == user.id).first()

    if not personaje:
        raise HTTPException(status_code=404, detail="Personaje no encontrado")
   

    if personaje.publicado: # type: ignore
         raise HTTPException(status_code=400, detail="El personaje ya está publicado")
    
    personaje.publicado = True # type: ignore
    db.commit()

    return {"ok": True}


    

    




