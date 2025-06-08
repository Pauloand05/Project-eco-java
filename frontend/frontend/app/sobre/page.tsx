import Image from "next/image"

export default function Sobre() {
  return (
    <div className="container mx-auto px-4 py-12">
      <h1 className="text-4xl font-bold mb-8 text-center">Sobre a Eco</h1>

      <section className="mb-12">
        <h2 className="text-2xl font-semibold mb-4">Nossa História</h2>
        <div className="grid md:grid-cols-2 gap-8 items-center">
          <div>
            <p className="text-lg mb-4">
              Fundada em 2020, a Eco nasceu da paixão de um grupo de ambientalistas e desenvolvedores de software que
              acreditavam no poder da tecnologia para promover mudanças positivas.
            </p>
            <p className="text-lg">
              Nossa jornada começou com um simples aplicativo de denúncias ambientais e evoluiu para uma plataforma
              completa que também utiliza jogos educativos para conscientizar sobre questões ambientais.
            </p>
          </div>
          <div className="relative h-64 md:h-80">
            <Image
              src="/placeholder.svg?height=320&width=480"
              alt="História da Eco"
              fill
              className="object-cover rounded-lg"
            />
          </div>
        </div>
      </section>

      <section className="mb-12">
        <h2 className="text-2xl font-semibold mb-4">Nosso Propósito</h2>
        <div className="bg-muted p-6 rounded-lg">
          <p className="text-lg mb-4">
            Acreditamos que cada pessoa tem o poder de fazer a diferença quando se trata de proteger nosso planeta.
            Nossa missão é fornecer as ferramentas necessárias para facilitar essa mudança.
          </p>
          <p className="text-lg mb-4">
            Através de nossa plataforma de denúncias, permitimos que cidadãos reportem problemas ambientais em suas
            comunidades, conectando-os diretamente com as autoridades responsáveis.
          </p>
          <p className="text-lg">
            Com nossos jogos educativos, buscamos conscientizar de forma divertida e envolvente, especialmente as novas
            gerações, sobre a importância da preservação ambiental.
          </p>
        </div>
      </section>

      <section>
        <h2 className="text-2xl font-semibold mb-6">Nossa Equipe</h2>
        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
          {[
            { nome: "Ana Silva", cargo: "CEO & Fundadora", foto: "/placeholder.svg?height=200&width=200" },
            { nome: "Carlos Mendes", cargo: "Diretor de Tecnologia", foto: "/placeholder.svg?height=200&width=200" },
            { nome: "Juliana Costa", cargo: "Especialista Ambiental", foto: "/placeholder.svg?height=200&width=200" },
            { nome: "Roberto Alves", cargo: "Desenvolvedor de Jogos", foto: "/placeholder.svg?height=200&width=200" },
          ].map((membro, index) => (
            <div key={index} className="bg-card p-4 rounded-lg shadow-sm border text-center">
              <div className="relative w-32 h-32 mx-auto mb-4">
                <Image
                  src={membro.foto || "/placeholder.svg"}
                  alt={membro.nome}
                  fill
                  className="object-cover rounded-full"
                />
              </div>
              <h3 className="text-xl font-semibold">{membro.nome}</h3>
              <p className="text-muted-foreground">{membro.cargo}</p>
            </div>
          ))}
        </div>
      </section>
    </div>
  )
}
