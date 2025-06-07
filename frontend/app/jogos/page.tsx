import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Star } from "lucide-react"
import Image from "next/image"

export default function ListaJogos() {
  // Dados simulados de jogos
  const jogos = [
    {
      id: 1,
      nome: "Eco Herói",
      genero: "Aventura",
      descricao: "Torne-se um herói ambiental e salve ecossistemas em perigo nesta aventura educativa.",
      avaliacao: 4.8,
      imagem: "/placeholder.svg?height=300&width=400",
    },
    {
      id: 2,
      nome: "Reciclagem Master",
      genero: "Puzzle",
      descricao: "Aprenda sobre reciclagem enquanto resolve quebra-cabeças desafiadores e divertidos.",
      avaliacao: 4.5,
      imagem: "/placeholder.svg?height=300&width=400",
    },
    {
      id: 3,
      nome: "Floresta Encantada",
      genero: "Simulação",
      descricao: "Construa e gerencie sua própria floresta sustentável neste jogo de simulação.",
      avaliacao: 4.7,
      imagem: "/placeholder.svg?height=300&width=400",
    },
    {
      id: 4,
      nome: "Oceano Limpo",
      genero: "Educativo",
      descricao: "Mergulhe nos oceanos e ajude a limpar a poluição marinha nesta aventura educativa.",
      avaliacao: 4.6,
      imagem: "/placeholder.svg?height=300&width=400",
    },
    {
      id: 5,
      nome: "Energia Verde",
      genero: "Estratégia",
      descricao: "Construa uma cidade movida a energias renováveis neste jogo de estratégia e gestão.",
      avaliacao: 4.9,
      imagem: "/placeholder.svg?height=300&width=400",
    },
    {
      id: 6,
      nome: "Defensores da Natureza",
      genero: "RPG",
      descricao: "Junte-se a uma equipe de defensores da natureza e enfrente ameaças ambientais.",
      avaliacao: 4.4,
      imagem: "/placeholder.svg?height=300&width=400",
    },
  ]

  return (
    <div className="container mx-auto px-4 py-12">
      <h1 className="text-4xl font-bold mb-8 text-center">Nossos Jogos</h1>
      <p className="text-lg text-center mb-12 max-w-3xl mx-auto">
        Explore nossa coleção de jogos educativos sobre meio ambiente e sustentabilidade. Divirta-se enquanto aprende
        sobre como proteger nosso planeta.
      </p>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {jogos.map((jogo) => (
          <Card key={jogo.id} className="overflow-hidden">
            <div className="relative h-48">
              <Image src={jogo.imagem || "/placeholder.svg"} alt={jogo.nome} fill className="object-cover" />
            </div>
            <CardHeader>
              <div className="flex justify-between items-start">
                <div>
                  <CardTitle>{jogo.nome}</CardTitle>
                  <CardDescription>
                    <Badge variant="outline" className="mt-1">
                      {jogo.genero}
                    </Badge>
                  </CardDescription>
                </div>
                <div className="flex items-center">
                  <Star className="h-4 w-4 fill-yellow-400 text-yellow-400 mr-1" />
                  <span className="text-sm font-medium">{jogo.avaliacao}</span>
                </div>
              </div>
            </CardHeader>
            <CardContent>
              <p>{jogo.descricao}</p>
            </CardContent>
            <CardFooter>
              <div className="text-sm text-muted-foreground">Disponível para download</div>
            </CardFooter>
          </Card>
        ))}
      </div>
    </div>
  )
}
