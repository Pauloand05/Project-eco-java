from adapters.openstreetmap_adapter import OpenStreetAdapter

class MapsService:
    def __init__(self):
        # Inicializa o adaptador de mapas (ex: Google Maps, Mapbox, etc.)
        self.__adapter = OpenStreetAdapter()

    def geocode(self, address: str):
        """
        Realiza a geocodificação de um endereço, retornando latitude e longitude.
        Parâmetros:
            address (str): Endereço a ser geocodificado.
        Retorna:
            dict: Contendo 'latitude' e 'longitude'.
        """
        return self.__adapter.geocode(address)

    def reverse_geocode(self, lat: float, lon: float):
        """
        Calcula a rota entre dois endereços.
        Parâmetros:
            lat (str): Endereço de origem.
            lon (float): Endereço de destino.
        Retorna:
            dict: Informações sobre a rota (distância, tempo estimado, etc.).
        """
        return self.__adapter.reverse_geocode(lat, lon)
float 
    