from fastapi_mail import FastMail, MessageSchema, ConnectionConfig, NameEmail
from pydantic import SecretStr
from fastapi_mail import MessageType



from dotenv import load_dotenv
import os

load_dotenv()


MAIL_USERNAME = os.getenv("MAIL_USERNAME")
MAIL_PASSWORD = os.getenv("MAIL_PASSWORD")
MAIL_FROM = os.getenv("MAIL_FROM") 

if not MAIL_USERNAME or not MAIL_PASSWORD or not MAIL_FROM:
    raise ValueError("Faltan variables de entorno del email en el .env")

#if not MAIL_PASSWORD :
 #   raise ValueError("Faltan variables de entorno del email en el .env")


#Lo mismo, esto luego un archivo env para que se oculte 
conf = ConnectionConfig(
    MAIL_USERNAME= MAIL_USERNAME, # el que envia mensajes, de prueba este mio
    MAIL_PASSWORD= SecretStr(MAIL_PASSWORD), 
    MAIL_FROM= MAIL_FROM,
    MAIL_PORT=587,
    MAIL_SERVER="smtp.gmail.com",
    MAIL_STARTTLS=True,
    MAIL_SSL_TLS=False,
    USE_CREDENTIALS=True,
    VALIDATE_CERTS=False
)


#El enlace con el email para que sirva en movil tiene que ser un dominio o algo 
async def send_reset_email(email: str, token: str):

    #reset_link = f"myapp://reset-password?token={token}"
    #reset_link = f"http://192.168.18.242:3000/reset-password?token={token}" #Raro no funca ahora, supongo que es como lo lanzo
    #reset_link = f"http://localhost:8000/reset-password?token={token}" #este es el de solo web 
    
    reset_link = f"http://localhost:3000/reset-password?token={token}" #funca si 

    message = MessageSchema(
        subject="Recuperar contraseña",
        recipients=[NameEmail(name="Usuario", email=email)],
        body=f"""
        Cambia tu contraseña aquí:

        {reset_link}
        """,
        subtype= MessageType.plain
    )

    fm = FastMail(conf)
    await fm.send_message(message)