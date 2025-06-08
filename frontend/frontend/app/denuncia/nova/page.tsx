"use client"

import type React from "react"

import { useState } from "react"
import { useRouter } from "next/navigation"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Textarea } from "@/components/ui/textarea"
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card"
import { Label } from "@/components/ui/label"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { useAuth } from "@/context/auth-context"
import { ProtectedRoute } from "@/components/protected-route"
import { Upload, MapPin } from "lucide-react"

export default function NovaDenuncia() {
  const { user } = useAuth()
  const router = useRouter()

  const [formData, setFormData] = useState({
    titulo: "",
    descricao: "",
    local: "",
    categoria: "",
    anonima: false,
  })

  const [files, setFiles] = useState<File[]>([])
  const [previewUrls, setPreviewUrls] = useState<string[]>([])
  const [isLoading, setIsLoading] = useState(false)
  const [error, setError] = useState("")

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    const { name, value } = e.target
    setFormData((prev) => ({ ...prev, [name]: value }))
  }

  const handleSelectChange = (value: string) => {
    setFormData((prev) => ({ ...prev, categoria: value }))
  }

  const handleCheckboxChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, checked } = e.target
    setFormData((prev) => ({ ...prev, [name]: checked }))
  }

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files) {
      const newFiles = Array.from(e.target.files)
      setFiles((prev) => [...prev, ...newFiles])

      // Criar URLs para preview
      const newPreviewUrls = newFiles.map((file) => URL.createObjectURL(file))
      setPreviewUrls((prev) => [...prev, ...newPreviewUrls])
    }
  }

  const removeFile = (index: number) => {
    // Liberar URL do objeto para evitar vazamento de memória
    URL.revokeObjectURL(previewUrls[index])

    setFiles((prev) => prev.filter((_, i) => i !== index))
    setPreviewUrls((prev) => prev.filter((_, i) => i !== index))
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setIsLoading(true)
    setError("")

    try {
      // Simulação de envio
      await new Promise((resolve) => setTimeout(resolve, 1500))

      // Em um cenário real, você enviaria os dados para a API
      console.log("Dados da denúncia:", formData)
      console.log("Arquivos:", files)

      router.push("/denuncias")
    } catch (err) {
      setError("Erro ao enviar denúncia. Por favor, tente novamente.")
    } finally {
      setIsLoading(false)
    }
  }

  return (
    <ProtectedRoute>
      <div className="container mx-auto px-4 py-12">
        <h1 className="text-4xl font-bold mb-8 text-center">Nova Denúncia</h1>

        <Card className="max-w-3xl mx-auto">
          <CardHeader>
            <CardTitle>Registrar Denúncia</CardTitle>
            <CardDescription>
              Preencha o formulário abaixo com os detalhes da sua denúncia. Quanto mais informações você fornecer,
              melhor poderemos ajudar.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleSubmit} className="space-y-6">
              {error && <div className="p-3 bg-destructive/15 text-destructive text-sm rounded-md">{error}</div>}

              <div className="space-y-2">
                <Label htmlFor="titulo">Título da Denúncia</Label>
                <Input
                  id="titulo"
                  name="titulo"
                  placeholder="Ex: Descarte irregular de lixo"
                  value={formData.titulo}
                  onChange={handleChange}
                  required
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="categoria">Categoria</Label>
                <Select onValueChange={handleSelectChange} required>
                  <SelectTrigger>
                    <SelectValue placeholder="Selecione uma categoria" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="poluicao_agua">Poluição da Água</SelectItem>
                    <SelectItem value="poluicao_ar">Poluição do Ar</SelectItem>
                    <SelectItem value="desmatamento">Desmatamento</SelectItem>
                    <SelectItem value="descarte_irregular">Descarte Irregular de Resíduos</SelectItem>
                    <SelectItem value="poluicao_sonora">Poluição Sonora</SelectItem>
                    <SelectItem value="maus_tratos_animais">Maus-tratos a Animais</SelectItem>
                    <SelectItem value="outros">Outros</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="space-y-2">
                <Label htmlFor="descricao">Descrição Detalhada</Label>
                <Textarea
                  id="descricao"
                  name="descricao"
                  placeholder="Descreva o problema em detalhes. Inclua informações como quando ocorreu, quem está envolvido, etc."
                  rows={5}
                  value={formData.descricao}
                  onChange={handleChange}
                  required
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="local">Local da Ocorrência</Label>
                <div className="flex">
                  <Input
                    id="local"
                    name="local"
                    placeholder="Endereço completo ou referência"
                    value={formData.local}
                    onChange={handleChange}
                    required
                    className="flex-1"
                  />
                  <Button type="button" variant="outline" className="ml-2" title="Usar localização atual">
                    <MapPin className="h-4 w-4" />
                  </Button>
                </div>
              </div>

              <div className="space-y-2">
                <Label htmlFor="fotos">Fotos ou Vídeos (opcional)</Label>
                <div className="grid grid-cols-1 gap-4">
                  <div className="flex items-center justify-center w-full">
                    <label
                      htmlFor="file-upload"
                      className="flex flex-col items-center justify-center w-full h-32 border-2 border-dashed rounded-lg cursor-pointer bg-muted/50 hover:bg-muted"
                    >
                      <div className="flex flex-col items-center justify-center pt-5 pb-6">
                        <Upload className="h-8 w-8 text-muted-foreground mb-2" />
                        <p className="mb-2 text-sm text-muted-foreground">
                          <span className="font-semibold">Clique para enviar</span> ou arraste e solte
                        </p>
                        <p className="text-xs text-muted-foreground">PNG, JPG, JPEG ou MP4 (máx. 10MB)</p>
                      </div>
                      <Input
                        id="file-upload"
                        type="file"
                        accept="image/*,video/*"
                        multiple
                        className="hidden"
                        onChange={handleFileChange}
                      />
                    </label>
                  </div>

                  {previewUrls.length > 0 && (
                    <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-4 mt-4">
                      {previewUrls.map((url, index) => (
                        <div key={index} className="relative group">
                          <img
                            src={url || "/placeholder.svg"}
                            alt={`Preview ${index + 1}`}
                            className="h-24 w-full object-cover rounded-md"
                          />
                          <button
                            type="button"
                            onClick={() => removeFile(index)}
                            className="absolute top-1 right-1 bg-black/70 text-white rounded-full p-1 opacity-0 group-hover:opacity-100 transition-opacity"
                          >
                            <svg
                              xmlns="http://www.w3.org/2000/svg"
                              width="16"
                              height="16"
                              viewBox="0 0 24 24"
                              fill="none"
                              stroke="currentColor"
                              strokeWidth="2"
                              strokeLinecap="round"
                              strokeLinejoin="round"
                            >
                              <line x1="18" y1="6" x2="6" y2="18"></line>
                              <line x1="6" y1="6" x2="18" y2="18"></line>
                            </svg>
                          </button>
                        </div>
                      ))}
                    </div>
                  )}
                </div>
              </div>

              <div className="flex items-center space-x-2">
                <input
                  type="checkbox"
                  id="anonima"
                  name="anonima"
                  checked={formData.anonima}
                  onChange={handleCheckboxChange}
                  className="h-4 w-4 rounded border-gray-300 text-primary focus:ring-primary"
                />
                <Label htmlFor="anonima" className="text-sm font-normal">
                  Fazer denúncia anônima (sua identidade não será revelada)
                </Label>
              </div>
            </form>
          </CardContent>
          <CardFooter className="flex justify-between">
            <Button variant="outline" onClick={() => router.back()}>
              Cancelar
            </Button>
            <Button onClick={handleSubmit} disabled={isLoading}>
              {isLoading ? "Enviando..." : "Enviar Denúncia"}
            </Button>
          </CardFooter>
        </Card>
      </div>
    </ProtectedRoute>
  )
}
