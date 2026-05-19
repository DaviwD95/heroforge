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

    RESET_URL = os.getenv("RESET_URL", "http://localhost:3000")    

    reset_link =  f"{RESET_URL}/reset-password?token={token}"
    
    #reset_link = f"http://localhost:3000/reset-password?token={token}" #funcionaa si en web pc

    #reset_link = f"http://10.0.2.2:3000/reset-password?token={token}" #funciona en el emulador

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