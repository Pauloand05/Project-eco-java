class ServiceFactory:
    # Atributos de classe para armazenar instâncias únicas dos serviços
    _email_service = None
    _maps_service = None

    @staticmethod
    def get_email_service():
        """
        Retorna uma instância única (singleton) de EmailService.
        Se ainda não foi criada, importa e instancia o serviço.
        """
        if ServiceFactory._email_service is None:
            # Importação local para evitar dependências circulares e atrasar o carregamento
            from services.email_service import EmailService
            ServiceFactory._email_service = EmailService()
        # Retorna sempre a mesma instância
        return ServiceFactory._email_service

    @staticmethod
    def get_maps_service():
        """
        Retorna uma instância única (singleton) de MapsService.
        Se ainda não foi criada, importa e instancia o serviço.
        """
        if ServiceFactory._maps_service is None:
            # Importação local para evitar dependências circulares e atrasar o carregamento
            from services.maps_service import MapsService
            ServiceFactory._maps_service = MapsService()
        # Retorna sempre a mesma instância
        return ServiceFactory._maps_service