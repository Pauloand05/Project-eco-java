from controllers.email_controller import email_bp
from controllers.maps_controller import maps_bp
from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)

@app.after_request
def after_requests(response):
    response.headers.add("Access-Control-Allow-Origin", "http://192.168.2.5:8080/api/v1")
    response.headers.add("Access-Control-Allow-Headers", "Content-Type,Authorization")
    response.headers.add("Access-Control-Allow-Methods", "GET,POST")
    return response

CORS(app)

app.register_blueprint(email_bp, url_prefix="/api/v1/email")
app.register_blueprint(maps_bp, url_prefix="/api/v1/maps")

@app.errorhandler(405)
def method_not_allowed(error):
    """
    Lida com erros 404 retornando uma resposta JSON indicando que a rota não foi encontrada.

    Parâmetros:
        error: Objeto de erro associado ao erro 404.

    Retorna:
        Uma tupla contendo a resposta JSON com a mensagem de erro e o código de status HTTP 404.
    """
    return jsonify({
        "error": "Método não permitido",
        "status": False
    }), 405

@app.errorhandler(404)
def route_not_found(error):
    """
    Lida com erros 404 retornando uma resposta JSON indicando que a rota não foi encontrada.

    Parâmetros:
        error: Objeto de erro associado ao erro 404.

    Retorna:
        Uma tupla contendo a resposta JSON com a mensagem de erro e o código de status HTTP 404.
    """
    return jsonify({
        "error": "Rota não encontrada",
        "status": False
    }), 404

if __name__ == "__main__":
    app.run("0.0.0.0", debug=True, port=5000)
    