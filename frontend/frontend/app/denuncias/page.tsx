"use client"

import { useState, useEffect } from "react"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Calendar, MapPin, AlertCircle } from "lucide-react"
import Link from "next/link"
import { useAuth } from "@/context/auth-context"
import { ProtectedRoute } from "@/components/protected-route"

type Denuncia = {
  id: string
  titulo: string
  descricao: string
  dataCriacao: string
  status?: "pendente" | "em_analise" | "resolvida" | "arquivada"
  usuario: {
    cpf: string
    nome: string
    nickname: string
    email: string
    telefone: string
  }
  endereco: {
    cep: string
    estado: string
    cidade: string
    bairro: string
    logradouro: string
  }
}

export default function Denuncias() {
  const { user } = useAuth()
  const [denuncias, setDenuncias] = useState<Denuncia[]>([])
  const [isLoading, setIsLoading] = useState(true)

  useEffect(() => {
    const fetchDenuncias = async () => {
      try {
        const response = await fetch("http://localhost:8080/denuncias") // ajuste o endpoint conforme seu backend
        const data = await response.json()
        console.log("Resposta da API:", data) // <-- Adicione isso
        setDenuncias(data)
      } catch (error) {
        console.error("Erro ao buscar denúncias:", error)
      } finally {
        setIsLoading(false)
      }
    }

    fetchDenuncias()
  }, [])

  const getStatusBadge = (status?: string) => {
    switch (status) {
      case "pendente":
        return <Badge className="bg-yellow-100 text-yellow-800">Pendente</Badge>
      case "em_analise":
        return <Badge className="bg-blue-100 text-blue-800">Em Análise</Badge>
      case "resolvida":
        return <Badge className="bg-green-100 text-green-800">Resolvida</Badge>
      case "arquivada":
        return <Badge className="bg-gray-100 text-gray-800">Arquivada</Badge>
      default:
        return <Badge variant="outline">Desconhecido</Badge>
    }
  }

  const formatDate = (dateString: string) => {
    const date = new Date(dateString)
    return date.toLocaleDateString("pt-BR")
  }

  const minhasDenuncias = denuncias.filter(
    (denuncia) => denuncia.usuario?.cpf === user?.cpf
  )

  return (
    <ProtectedRoute>
      <div className="container mx-auto px-4 py-12">
        <div className="flex justify-between items-center mb-8">
          <h1 className="text-4xl font-bold">Minhas Denúncias</h1>
          <Button asChild>
            <Link href="/denuncia/nova">Nova Denúncia</Link>
          </Button>
        </div>

        {isLoading ? (
          <div className="flex justify-center items-center h-64">
            <p className="text-lg">Carregando denúncias...</p>
          </div>
        ) : minhasDenuncias.length === 0 ? (
          <Card>
            <CardContent className="flex flex-col items-center justify-center py-12">
              <AlertCircle className="h-12 w-12 text-muted-foreground mb-4" />
              <h2 className="text-xl font-semibold mb-2">Nenhuma denúncia encontrada</h2>
              <p className="text-muted-foreground mb-6">Você ainda não registrou nenhuma denúncia.</p>
              <Button asChild>
                <Link href="/denuncia/nova">Registrar Primeira Denúncia</Link>
              </Button>
            </CardContent>
          </Card>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {minhasDenuncias.map((denuncia) => (
              <Card key={denuncia.id} className="h-full flex flex-col">
                <CardHeader>
                  <div className="flex justify-between items-start">
                    <CardTitle className="text-xl">{denuncia.titulo}</CardTitle>
                    {getStatusBadge(denuncia.status)}
                  </div>
                  <CardDescription className="flex items-center mt-2">
                    <Calendar className="h-4 w-4 mr-1" />
                    {formatDate(denuncia.dataCriacao)}
                  </CardDescription>
                </CardHeader>
                <CardContent className="flex-grow">
                  <p className="mb-4">{denuncia.descricao}</p>
                  <div className="flex items-start text-sm text-muted-foreground">
                    <MapPin className="h-4 w-4 mr-1 mt-0.5 flex-shrink-0" />
                    <span>{denuncia.endereco?.logradouro}</span>
                  </div>
                </CardContent>
                <CardFooter>
                  <Button variant="outline" className="w-full" asChild>
                    <Link href={`/denuncias/${denuncia.id}`}>Ver Detalhes</Link>
                  </Button>
                </CardFooter>
              </Card>
            ))}
          </div>
        )}
      </div>
    </ProtectedRoute>
  )
}
