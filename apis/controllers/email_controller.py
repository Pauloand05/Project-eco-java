from flask import Blueprint, request, jsonify
from config import REQUIRED_FIELDS_EMAIL
from factories.service_factory import ServiceFactory

# Cria um Blueprint do Flask para rotas relacionadas a e-mails
email_bp = Blueprint("email", __name__)

@email_bp.route("", methods=["POST"])
def send_email():
    # Obtém os dados do corpo da requisição em formato JSON
    info_email = request.json
    fields = info_email.keys()
    
    # Valida se todos os campos obrigatórios estão presentes na requisição
    if not all((field in REQUIRED_FIELDS_EMAIL for field in fields)):
        return jsonify(
            {
                "response": "Forneça todos os campos para validar as informações do email",
                "status": False
            }
        ), 400
    try:
        # Seleciona o modelo de e-mail a ser enviado com base no campo 'modelo'
        match info_email.get("model"):
            case "reset_password":
                # Obtém instância do serviço de e-mail via ServiceFactory
                service_factory = ServiceFactory()
                email_service = service_factory.get_email_service()
                # Monta o dicionário com as informações necessárias
                info_email = {
                    "user": info_email.get("user"),
                    "link": info_email.get("link"),
                    "email": info_email.get("email")
                }
                # Chama o serviço para enviar o e-mail de redefinição de senha
                response = email_service.send_reset_password(info_email)

                # Retorna a resposta do serviço e o código HTTP correspondente
                return jsonify(response), response.get("code")

            case "password_changed":
                # Obtém instância do serviço de e-mail via ServiceFactory
                service_factory = ServiceFactory()
                email_service = service_factory.get_email_service()
                # Monta o dicionário com as informações necessárias
                info_email = {
                    "user": info_email.get("user"),
                    "link": info_email.get("link"),
                    "email": info_email.get("email")
                }
                # Chama o serviço para enviar o e-mail de notificação de senha alterada
                response = email_service.send_password_changed(info_email)
                
                # Retorna a resposta do serviço e o código HTTP correspondente
                return jsonify(response), response.get("code")

            case _:
                # Caso o modelo não seja reconhecido, retorna erro 422
                return jsonify(
                    {
                        "response": "Forneça qual o modelo de envio de email",
                        "status": False
                    }
                ), 422
            
    except Exception as e:
        return jsonify(
            {"resposta": f"Erro interno: {str(e)}", "status": False}
        ), 500