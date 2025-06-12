import smtplib
from email.mime.text import MIMEText
from config import SMTP_SERVER, SMTP_PORT, SMTP_USER, SMTP_PASSWORD, get_logger

# Cria o logger configurado com o nome do módulo atual (__name__)
logger = get_logger(__name__)

class SMTPAdapter:
    def send(self, to_email: str, body: str, subject: str) -> dict:
        # Monta a mensagem do e-mail no formato HTML
        msg = MIMEText(body, "html")
        msg["Subject"] = subject
        msg["From"] = SMTP_USER
        msg["To"] = to_email

        # Loga o início do processo de envio do e-mail
        logger.info(f"Iniciando envio de e-mail para: {to_email}")

        try:
            # Abre conexão com o servidor SMTP na porta configurada
            with smtplib.SMTP(SMTP_SERVER, SMTP_PORT) as server:
                logger.info("Conectando ao servidor SMTP...")

                # Inicia a comunicação segura via TLS (criptografia)
                server.starttls()
                logger.info("STARTTLS ativado.")

                # Realiza o login no servidor SMTP com usuário e senha
                server.login(SMTP_USER, SMTP_PASSWORD)
                logger.info("Login SMTP realizado com sucesso.")

                # Envia o e-mail propriamente dito
                server.sendmail(SMTP_USER, to_email, msg.as_string())
                logger.info("E-mail enviado com sucesso.")

            # Retorna resposta indicando sucesso
            return {"status": True, "message": "E-mail enviado com sucesso", "code": 200}

        except Exception as e:
            # Caso ocorra erro, registra a exceção completa no log
            logger.error("Erro ao enviar e-mail", exc_info=True)

            # Retorna resposta indicando falha e mensagem de erro
            return {"status": False, "message": f"Erro ao enviar e-mail: {str(e)}", "code": 500}
