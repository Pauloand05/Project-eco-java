from os import getenv  # Importa a função getenv para acessar variáveis de ambiente
from pathlib import Path  # Importa Path para manipulação de caminhos de arquivos
import logging

# Variáveis de ambiente sensíveis
SMTP_USER = getenv("SMTP_USER")  # E-mail do servidor ou aplicação
SMTP_PASSWORD = getenv("SMTP_PASSWORD")  # Chave de aplicação (por exemplo, para autenticação)
SMTP_PORT = getenv("SMTP_PORT")  # Porta em que o servidor irá rodar
SMTP_SERVER = getenv("SMTP_SERVER")  # Host do servidor
PASSWORD = getenv("PASSWORD")  # Senha (pode ser de acesso ao e-mail ou outro serviço)

# Caminhos para templates de e-mail
RESET_PASSWORD = Path(__file__).parent / "templates" / "email" / "redefinir_senha.html"  # Template para redefinição de senha
PASSWORD_CHANGED = Path(__file__).parent / "templates" / "email" / "senha_alterada.html"  # Template para confirmação de alteração de senha

# Campos obrigatórios para envio de e-mail
REQUIRED_FIELDS_EMAIL = ["user", "email", "link", "model"]

# URL do serviço de geocodificação (OpenStreetMap)
OSM_URL = "https://nominatim.openstreetmap.org/"

def get_logger(name: str = __name__) -> logging.Logger:
    """
    Cria e retorna um logger configurado para console e arquivo.

    Parâmetros:
        name (str): Nome do logger, geralmente o __name__ do módulo.

    Retorna:
        logging.Logger: Logger configurado.
    """

    # Cria um logger com o nome passado (ou nome do módulo que chamou)
    logger = logging.getLogger(name)

    # Evita adicionar múltiplos handlers se o logger já estiver configurado
    if not logger.hasHandlers():
        # Define o nível mínimo de logs que serão capturados (INFO, DEBUG, etc.)
        logger.setLevel(logging.INFO)

        # Define o formato das mensagens de log (data/hora, nível, mensagem)
        formatter = logging.Formatter(
            '[%(asctime)s] %(levelname)s - %(message)s',  # Formato
            datefmt='%Y-%m-%d %H:%M:%S'                   # Formato da data/hora
        )

        # Handler para mostrar logs no console (terminal)
        console_handler = logging.StreamHandler()
        console_handler.setFormatter(formatter)  # Aplica o formato

        # Handler para salvar logs em arquivo (modo append, codificação UTF-8)
        file_handler = logging.FileHandler('app.log', mode='a', encoding='utf-8')
        file_handler.setFormatter(formatter)     # Aplica o formato

        # Adiciona os handlers ao logger criado
        logger.addHandler(console_handler)
        logger.addHandler(file_handler)

    # Retorna o logger configurado para uso
    return logger

# Validação das variáveis de ambiente essenciais
if SMTP_USER is None and SMTP_PASSWORD is None:
    raise ValueError(
        "Não foi possível acessar as informações confidenciais do servidor. "
        "Verifique se as variáveis de ambiente 'EMAIL' e 'APP_KEY' estão definidas."
    )

# Bloco de teste rápido para execução direta do arquivo
if __name__ == "__main__":
    print(SMTP_SERVER, SMTP_PORT, SMTP_PASSWORD)