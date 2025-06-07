"use client"

import { useState, useEffect } from "react"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Calendar, User, MapPin, MessageSquare } from "lucide-react"
import { useAuth } from "@/context/auth-context"
import { AdminRoute } from "@/components/admin-route"

type Atendimento = {
  id: string
  denunciaId: string
  titulo: string
  descricao: string
  local: string
  data: string
  status: "pendente" | "em_analise" | "resolvida" | "arquivada"
  usuario: {
    nome: string
    email: string
    anonimo: boolean
  }
  respostas: {
    id: string
    texto: string
    data: string
    funcionario: string
  }[]
}

export default function AtendimentosFuncionario() {
  const { user } = useAuth()
  const [atendimentos, setAtendimentos] = useState<Atendimento[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const [activeTab, setActiveTab] = useState("todos")

  useEffect(() => {
    // Em um cenário real, você buscaria os atendimentos da API
    const fetchAtendimentos = async () => {
      try {
        // Simulação de busca
        await new Promise((resolve) => setTimeout(resolve, 1000))

        // Dados simulados
        const mockAtendimentos: Atendimento[] = [
          {
            id: "1",
            denunciaId: "1",
            titulo: "Descarte irregular de lixo",
            descricao: "Encontrei um grande volume de lixo descartado irregularmente próximo ao córrego.",
            local: "Av. Paulista, 1000 - São Paulo",
            data: "2023-05-15",
            status: "resolvida",
            usuario: {
              nome: "João Silva",
              email: "joao@exemplo.com",
              anonimo: false,
            },
            respostas: [
              {
                id: "1",
                texto: "Denúncia recebida. Estamos encaminhando para o departamento responsável.",
                data: "2023-05-16",
                funcionario: "Maria Oliveira",
              },
              {
                id: "2",
                texto: "Equipe de limpeza enviada ao local. O problema foi resolvido.",
                data: "2023-05-18",
                funcionario: "Carlos Santos",
              },
            ],
          },
          {
            id: "2",
            denunciaId: "2",
            titulo: "Poluição sonora",
            descricao: "Estabelecimento com música alta após as 22h, perturbando moradores.",
            local: "Rua Augusta, 500 - São Paulo",
            data: "2023-06-20",
            status: "em_analise",
            usuario: {
              nome: "Anônimo",
              email: "",
              anonimo: true,
            },
            respostas: [
              {
                id: "3",
                texto: "Denúncia recebida. Estamos verificando a situação.",
                data: "2023-06-21",
                funcionario: "Maria Oliveira",
              },
            ],
          },
          {
            id: "3",
            denunciaId: "3",
            titulo: "Desmatamento em área protegida",
            descricao: "Observei atividade de desmatamento em área que acredito ser de preservação.",
            local: "Parque Estadual da Cantareira - São Paulo",
            data: "2023-07-05",
            status: "pendente",
            usuario: {
              nome: "Ana Pereira",
              email: "ana@exemplo.com",
              anonimo: false,
            },
            respostas: [],
          },
        ]

        setAtendimentos(mockAtendimentos)
      } catch (error) {
        console.error("Erro ao buscar atendimentos:", error)
      } finally {
        setIsLoading(false)
      }
    }

    fetchAtendimentos()
  }, [])

  const getStatusBadge = (status: string) => {
    switch (status) {
      case "pendente":
        return (
          <Badge variant="outline" className="bg-yellow-100 text-yellow-800 hover:bg-yellow-100">
            Pendente
          </Badge>
        )
      case "em_analise":
        return (
          <Badge variant="outline" className="bg-blue-100 text-blue-800 hover:bg-blue-100">
            Em Análise
          </Badge>
        )
      case "resolvida":
        return (
          <Badge variant="outline" className="bg-green-100 text-green-800 hover:bg-green-100">
            Resolvida
          </Badge>
        )
      case "arquivada":
        return (
          <Badge variant="outline" className="bg-gray-100 text-gray-800 hover:bg-gray-100">
            Arquivada
          </Badge>
        )
      default:
        return <Badge variant="outline">Desconhecido</Badge>
    }
  }

  const formatDate = (dateString: string) => {
    const date = new Date(dateString)
    return date.toLocaleDateString("pt-BR")
  }

  const filteredAtendimentos =
    activeTab === "todos" ? atendimentos : atendimentos.filter((atendimento) => atendimento.status === activeTab)

  return (
    <AdminRoute>
      <div className="container mx-auto px-4 py-12">
        <h1 className="text-4xl font-bold mb-8">Atendimentos</h1>

        <Tabs defaultValue="todos" value={activeTab} onValueChange={setActiveTab} className="mb-8">
          <TabsList className="grid grid-cols-4 md:w-[600px]">
            <TabsTrigger value="todos">Todos</TabsTrigger>
            <TabsTrigger value="pendente">Pendentes</TabsTrigger>
            <TabsTrigger value="em_analise">Em Análise</TabsTrigger>
            <TabsTrigger value="resolvida">Resolvidos</TabsTrigger>
          </TabsList>
        </Tabs>

        {isLoading ? (
          <div className="flex justify-center items-center h-64">
            <p className="text-lg">Carregando atendimentos...</p>
          </div>
        ) : filteredAtendimentos.length === 0 ? (
          <Card>
            <CardContent className="flex flex-col items-center justify-center py-12">
              <MessageSquare className="h-12 w-12 text-muted-foreground mb-4" />
              <h2 className="text-xl font-semibold mb-2">Nenhum atendimento encontrado</h2>
              <p className="text-muted-foreground">Não há atendimentos para esta categoria.</p>
            </CardContent>
          </Card>
        ) : (
          <div className="space-y-6">
            {filteredAtendimentos.map((atendimento) => (
              <Card key={atendimento.id}>
                <CardHeader>
                  <div className="flex justify-between items-start">
                    <div>
                      <CardTitle className="text-xl">{atendimento.titulo}</CardTitle>
                      <CardDescription className="flex items-center mt-2 space-x-4">
                        <span className="flex items-center">
                          <Calendar className="h-4 w-4 mr-1" />
                          {formatDate(atendimento.data)}
                        </span>
                        <span className="flex items-center">
                          <User className="h-4 w-4 mr-1" />
                          {atendimento.usuario.anonimo ? "Anônimo" : atendimento.usuario.nome}
                        </span>
                      </CardDescription>
                    </div>
                    {getStatusBadge(atendimento.status)}
                  </div>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    <div>
                      <h4 className="font-semibold mb-2">Descrição:</h4>
                      <p>{atendimento.descricao}</p>
                    </div>

                    <div className="flex items-start text-sm text-muted-foreground">
                      <MapPin className="h-4 w-4 mr-1 mt-0.5 flex-shrink-0" />
                      <span>{atendimento.local}</span>
                    </div>

                    {atendimento.respostas.length > 0 && (
                      <div>
                        <h4 className="font-semibold mb-2">Histórico de Respostas:</h4>
                        <div className="space-y-2">
                          {atendimento.respostas.map((resposta) => (
                            <div key={resposta.id} className="bg-muted p-3 rounded-md">
                              <p className="text-sm">{resposta.texto}</p>
                              <div className="flex justify-between items-center mt-2 text-xs text-muted-foreground">
                                <span>Por: {resposta.funcionario}</span>
                                <span>{formatDate(resposta.data)}</span>
                              </div>
                            </div>
                          ))}
                        </div>
                      </div>
                    )}
                  </div>
                </CardContent>
                <CardFooter className="flex justify-between">
                  <Button variant="outline">Ver Detalhes</Button>
                  <div className="space-x-2">
                    {atendimento.status === "pendente" && <Button>Iniciar Atendimento</Button>}
                    {atendimento.status === "em_analise" && <Button>Responder</Button>}
                  </div>
                </CardFooter>
              </Card>
            ))}
          </div>
        )}
      </div>
    </AdminRoute>
  )
}
