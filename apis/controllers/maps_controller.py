from flask import Blueprint, request, jsonify
from factories.service_factory import ServiceFactory

# Cria um Blueprint do Flask para rotas relacionadas a mapas
maps_bp = Blueprint("maps", __name__)

@maps_bp.route("/geocode", methods=["POST"])
def geocode():
    # Obtém o endereço do corpo da requisição
    data = request.json
    address = data.get("address")
    if not address:
        return jsonify({"resposta": "Endereço não fornecido", "status": False}), 400
    try:
        # Obtém instância do serviço de mapas via ServiceFactory
        service_factory = ServiceFactory
        maps_service = service_factory.get_maps_service()
        # Chama o serviço para geocodificar o endereço
        response = maps_service.geocode(address)
        return jsonify(response), response.get("code", 200)
    except Exception as e:
        return jsonify({"resposta": f"Erro interno: {str(e)}", "status": False}), 500

@maps_bp.route("/reverse", methods=["POST"])
def reverse_geocode():
    # Obtém latitude e longitude do corpo da requisição
    data = request.json
    lat = data.get("lat")
    lon = data.get("lon")
    if lat is None or lon is None:
        return jsonify({"resposta": "Latitude e longitude são obrigatórios", "status": False}), 400
    try:
        # Obtém instância do serviço de mapas via ServiceFactory
        service_factory = ServiceFactory
        maps_service = service_factory.get_maps_service()
        # Chama o serviço para buscar o endereço correspondente às coordenadas
        response = maps_service.reverse_geocode(lat, lon)
        return jsonify(response), response.get("code", 200)
    except Exception as e:
        return jsonify({"resposta": f"Erro interno: {str(e)}", "status": False}), 500