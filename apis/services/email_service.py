from adapters.smtp_adapter import SMTPAdapter 
from utils.email_templates import PasswordChanged, ResetPassword

class EmailService:
    def __init__(self):    
        # Inicializa o adaptador SMTP responsável pelo envio dos e-mails
        self.__adapter = SMTPAdapter()

    def send_reset_password(self, info_email: dict):
        """
        Envia um e-mail de redefinição de senha para o usuário.
        Parâmetros:
            info_email (dict): Deve conter as chaves 'user', 'link' e 'email'.
        Retorna:
            Resultado do envio do e-mail pelo adaptador SMTP.
        """
        reset_password = ResetPassword()
        user = info_email.get("user")
        link = info_email.get("link")
        
        # Monta o dicionário de informações para preencher o template
        info = {
            "user": user,
            "link": link
        }
        # Preenche o template de e-mail com as informações do usuário
        temp = reset_password.fill_template(info)

        # Envia o e-mail usando o adaptador SMTP
        send = self.__adapter.send(
            info_email.get("email"),
            temp,
            "Redefinir Senha"
        )

        return send
    

    def send_password_changed(self, info_email: dict):
        """
        Envia um e-mail notificando o usuário sobre a alteração de senha.
        Parâmetros:
            info_email (dict): Deve conter as chaves 'user', 'link' e 'email'.
        Retorna:
            Resultado do envio do e-mail pelo adaptador SMTP.
        """
        from datetime import datetime

        user = info_email.get("user")
        link = info_email.get("link")
        # Obtém a data e hora atuais para incluir no e-mail
        updated_hour = datetime.now().strftime("%H:%m")
        updated_date = datetime.now().strftime("%Y-%m-%d")

        # Monta o dicionário de informações para preencher o template
        info = {
            "user": user,
            "updated_date": updated_date,
            "updated_hour": updated_hour,
            "link": link
        }

        password_changed = PasswordChanged()
        # Preenche o template de e-mail com as informações do usuário
        temp = password_changed.fill_template(info) 

        # Envia o e-mail usando o adaptador SMTP
        send = self.__adapter.send(
            info_email.get("email"),
            temp,
            "Alteração da Senha"
        )

        return send