from string import Template
class ResetPassword:
    # Importa o caminho do template de redefinição de senha do arquivo de configuração
    from config import RESET_PASSWORD

    def __load_template(self):
        """
        Lê o arquivo de template de e-mail de redefinição de senha.
        Retorna o conteúdo do arquivo como uma string.
        """
        with open(self.RESET_PASSWORD, "r", encoding="utf-8") as fl:
            return fl.read()
        
    def fill_template(self, info: dict):
        """
        Preenche o template de e-mail com as informações fornecidas no dicionário 'info'.
        Utiliza o método safe_substitute para evitar erros caso alguma chave esteja faltando.
        Retorna o e-mail pronto para envio.
        """
        temp = self.__load_template()
        template = Template(temp)   
        return template.safe_substitute(info)
    

class PasswordChanged:
    # Importa o caminho do template de confirmação de alteração de senha do arquivo de configuração
    from config import PASSWORD_CHANGED

    def __load_template(self):
        """
        Lê o arquivo de template de e-mail de confirmação de alteração de senha.
        Retorna o conteúdo do arquivo como uma string.
        """
        with open(self.PASSWORD_CHANGED, "r", encoding="utf-8") as fl:
            return fl.read()
        
    def fill_template(self, info: dict):
        """
        Preenche o template de e-mail com as informações fornecidas no dicionário 'info'.
        Utiliza o método safe_substitute para evitar erros caso alguma chave esteja faltando.
        Retorna o e-mail pronto para envio.
        """
        temp = self.__load_template()
        template = Template(temp)   
        return template.safe_substitute(info)

