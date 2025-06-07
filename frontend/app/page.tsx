import { Button } from "@/components/ui/button"
import Link from "next/link"

export default function Home() {
  return (
    <div className="container mx-auto px-4 py-8">
      {/* Seção de destaque */}
      <section className="py-12 md:py-20">
        <div className="max-w-4xl mx-auto text-center">
          <h1 className="text-4xl md:text-6xl font-bold mb-6">Bem-vindo à Eco</h1>
          <p className="text-xl md:text-2xl text-muted-foreground mb-8">
            Promovendo sustentabilidade e responsabilidade social através de jogos e denúncias ambientais.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Button asChild size="lg" className="text-lg">
              <Link href="/denuncia/nova">Faça sua denúncia</Link>
            </Button>
            <Button asChild variant="outline" size="lg" className="text-lg">
              <Link href="/jogos">Conheça nossos jogos</Link>
            </Button>
          </div>
        </div>
      </section>

      {/* Missão da empresa */}
      <section className="py-12 bg-muted rounded-lg my-12">
        <div className="container mx-auto px-4">
          <h2 className="text-3xl font-bold mb-6 text-center">Nossa Missão</h2>
          <div className="max-w-3xl mx-auto">
            <p className="text-lg mb-4">
              A Eco tem como missão promover a conscientização ambiental e facilitar a participação cidadã na proteção
              do meio ambiente.
            </p>
            <p className="text-lg">
              Através de nossa plataforma de denúncias e jogos educativos, buscamos criar um impacto positivo e
              duradouro em nossa sociedade.
            </p>
          </div>
        </div>
      </section>

      {/* Links rápidos */}
      <section className="py-12">
        <div className="container mx-auto px-4">
          <h2 className="text-3xl font-bold mb-8 text-center">Links Rápidos</h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div className="bg-card p-6 rounded-lg shadow-sm border">
              <h3 className="text-xl font-semibold mb-3">Sobre Nós</h3>
              <p className="mb-4 text-muted-foreground">Conheça nossa história, valores e a equipe por trás da Eco.</p>
              <Button asChild variant="link" className="p-0">
                <Link href="/sobre">Saiba mais</Link>
              </Button>
            </div>
            <div className="bg-card p-6 rounded-lg shadow-sm border">
              <h3 className="text-xl font-semibold mb-3">Jogos Educativos</h3>
              <p className="mb-4 text-muted-foreground">
                Explore nossa coleção de jogos educativos sobre meio ambiente.
              </p>
              <Button asChild variant="link" className="p-0">
                <Link href="/jogos">Ver jogos</Link>
              </Button>
            </div>
            <div className="bg-card p-6 rounded-lg shadow-sm border">
              <h3 className="text-xl font-semibold mb-3">Denúncias</h3>
              <p className="mb-4 text-muted-foreground">Faça denúncias de problemas ambientais na sua região.</p>
              <Button asChild variant="link" className="p-0">
                <Link href="/denuncia/nova">Denunciar</Link>
              </Button>
            </div>
          </div>
        </div>
      </section>
    </div>
  )
}
