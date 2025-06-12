import requests
from config import OSM_URL, get_logger

# Cria logger configurado com o nome do módulo atual
logger = get_logger(__name__)

class OpenStreetAdapter:
    def reverse_geocode(self, lat: float, lon: float) -> dict:
        # Parâmetros para a requisição de reverse geocode (latitude, longitude, formato, idioma)
        params = {
            "lat": lat,
            "lon": lon,
            "format": "json",
            "addressdetails": 1,
            "accept-language": "pt-BR"
        }
        # Cabeçalhos HTTP, incluindo User-Agent para identificar sua aplicação
        headers = {
            "User-Agent": "meu-app/1.0"
        }
        
        # Log de início da consulta, informando coordenadas
        logger.info(f"Consultando reverse geocode para lat={lat}, lon={lon}")
        
        try:
            # Requisição GET para endpoint de reverse geocode
            response = requests.get(OSM_URL + "reverse", params=params, headers=headers)

            # Caso o status não seja 200 (OK), loga um aviso e retorna mensagem personalizada
            if response.status_code != 200:
                logger.warning(f"Reverse geocode retornou status {response.status_code}")
                return {
                    "resposta": "Informações baseadas na sua latitude e longitude não foram encontradas. Por favor, tente novamente",
                    "status": False,
                    "code": 404
                }
            
            # Pega os dados JSON da resposta
            data = response.json()
            
            # Log de sucesso na operação
            logger.info("Reverse geocode concluído com sucesso.")
            
            # Retorna o endereço encontrado
            return {
                "resposta": data.get("address"),
                "status": True,
                "code": 200
            }
        
        except Exception as e:
            # Loga erro com traceback para facilitar diagnóstico
            logger.error("Erro ao realizar reverse geocode", exc_info=True)
            # Retorna erro para o consumidor da função
            return {
                "resposta": f"Erro ao encontrar o endereço: {str(e)}",
                "status": False,
                "code": 500
            }

    def geocode(self, address: str) -> dict:
        # Parâmetros para a requisição de geocode (endereço, formato, limite de resultados)
        params = {
            "q": address,
            "format": "json",
            "limit": 1
        }
        headers = {
            # User-Agent recomendável para uso responsável da API do OSM
            "User-Agent": "sua-app/1.0 (econaturetec@gmail.com)"
        }
        
        # Log de início da consulta, informando o endereço
        logger.info(f"Consultando geocode para endereço: {address}")
        
        try:
            # Requisição GET para endpoint de geocode
            response = requests.get(OSM_URL + "search", params=params, headers=headers)
            
            # Verifica se a resposta foi OK, senão loga warning e retorna erro
            if response.status_code != 200:
                logger.warning(f"Geocode retornou status {response.status_code}")
                return {
                    "resposta": "Informações baseadas na seu endereço não foram encontradas. Por favor, tente novamente",
                    "status": False,
                    "code": 404
                }
            
            # Extrai o JSON da resposta
            data = response.json()
            
            # Loga sucesso da operação
            logger.info("Geocode concluído com sucesso.")
            
            # Retorna latitude e longitude do primeiro resultado
            return {
                "lat": float(data[0]["lat"]),
                "lon": float(data[0]["lon"]),
                "status": True,
                "code": 200
            }
        
        except Exception as e:
            # Loga erro com traceback para análise
            logger.error("Erro ao realizar geocode", exc_info=True)
            # Retorna mensagem de erro para o chamador
            return {
                "resposta": f"Erro ao encontrar a localização: {str(e)}",
                "status": False,
                "code": 500
            }
