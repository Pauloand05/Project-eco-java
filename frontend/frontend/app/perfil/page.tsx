"use client"

import type React from "react"

import { useState, useEffect } from "react"
import { useRouter } from "next/navigation"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Label } from "@/components/ui/label"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { useAuth } from "@/context/auth-context"
import { ProtectedRoute } from "@/components/protected-route"

export default function PerfilUsuario() {
  const { user, logout } = useAuth()
  const router = useRouter()

  const [userData, setUserData] = useState({
    nome: "",
    email: "",
    cpf: "",
    telefone: "",  // aqui mantém phone
    nickname: "",
    senha: user?.senha, // adiciona nickname se quiser usar
  })

  const [passwordData, setPasswordData] = useState({
    currentPassword: "",
    newPassword: "",
    confirmPassword: "",
  })

  const [isLoading, setIsLoading] = useState(false)
  const [message, setMessage] = useState({ type: "", text: "" })

  useEffect(() => {
    if (user) {
      setUserData({
        nome: user.nome || "",
        email: user.email || "",
        cpf: user.cpf , // ideal puxar do user real
        telefone: user.telefone , // ideal puxar do user real
        nickname: user.nickname, // se disponível
        senha: user.senha  // opcional, se quiser usar
      })
    }
  }, [user])

  function handleUserDataChange(e: React.ChangeEvent<HTMLInputElement>) {
    const { name, value } = e.target
    setUserData((prev) => ({ ...prev, [name]: value }))
  }

  function handlePasswordChange(e: React.ChangeEvent<HTMLInputElement>) {
    const { name, value } = e.target
    setPasswordData((prev) => ({ ...prev, [name]: value }))
  }

  const handleUpdateProfile = async (e: React.FormEvent) => {
    e.preventDefault()
    setIsLoading(true)
    setMessage({ type: "", text: "" })

    try {
      const response = await fetch(`http://localhost:8080/usuarios/${user?.cpf}`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          nome: userData.nome,
          nickname: userData.nickname,
          email: userData.email,
          telefone: userData.telefone,  // aqui backend espera 'telefone'
        }),
      })

      console.log("Status da resposta:", response.status);
      const data = await response.json();
      console.log("Resposta do backend:", data);

      if (!response.ok) {
        throw new Error("Erro ao atualizar perfil")
      }

      // opcional: const data = await response.json()
      setMessage({ type: "success", text: "Perfil atualizado com sucesso!" })
    } catch (err) {
      setMessage({ type: "error", text: "Erro ao atualizar perfil. Tente novamente." + err })
    } finally {
      setIsLoading(false)
    }
  }

  const handleUpdatePassword = async (e: React.FormEvent) => {
  e.preventDefault();
  setIsLoading(true);
  setMessage({ type: "", text: "" });

  if (passwordData.newPassword !== passwordData.confirmPassword) {
    setMessage({ type: "error", text: "As senhas não coincidem" });
    setIsLoading(false);
    return;
  }

  try {
    const response = await fetch(`http://localhost:8080/usuarios/${user?.cpf}/senha`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        currentPassword: passwordData.currentPassword,
        newPassword: passwordData.newPassword,
      }),
    });

    if (!response.ok) {
      const errorData = await response.json();
      throw new Error(errorData.message || "Erro ao atualizar senha");
    }

    setMessage({ type: "success", text: "Senha atualizada com sucesso!" });
    setPasswordData({
      currentPassword: "",
      newPassword: "",
      confirmPassword: "",
    });
  } catch (err) {
    setMessage({ type: "error", text: `Erro ao atualizar senha: ${err}` });
  } finally {
    setIsLoading(false);
  }
};


  const handleLogout = () => {
    logout()
    router.push("/")
  }

  return (
    <ProtectedRoute>
      <div className="container mx-auto px-4 py-12">
        <h1 className="text-4xl font-bold mb-8 text-center">Meu Perfil</h1>

        <div className="max-w-2xl mx-auto">
          <Tabs defaultValue="info" className="w-full">
            <TabsList className="grid w-full grid-cols-2">
              <TabsTrigger value="info">Informações Pessoais</TabsTrigger>
              <TabsTrigger value="password">Alterar Senha</TabsTrigger>
            </TabsList>

            <TabsContent value="info">
              <Card>
                <CardHeader>
                  <CardTitle>Informações Pessoais</CardTitle>
                  <CardDescription>
                    Atualize suas informações pessoais aqui. Clique em salvar quando terminar.
                  </CardDescription>
                </CardHeader>
                <CardContent>
                  <form onSubmit={handleUpdateProfile} className="space-y-4">
                    {message.text && message.type === "success" && (
                      <div className="p-3 bg-green-100 text-green-800 text-sm rounded-md">{message.text}</div>
                    )}
                    {message.text && message.type === "error" && (
                      <div className="p-3 bg-destructive/15 text-destructive text-sm rounded-md">{message.text}</div>
                    )}

                    <div className="space-y-2">
                      <Label htmlFor="nome">Nome Completo</Label>
                      <Input id="nome" name="nome" value={userData.nome} onChange={handleUserDataChange} />
                    </div>

                    <div className="space-y-2">
                      <Label htmlFor="email">E-mail</Label>
                      <Input
                        id="email"
                        name="email"
                        type="email"
                        value={userData.email}
                        onChange={handleUserDataChange}
                      />
                    </div>

                    <div className="space-y-2">
                      <Label htmlFor="nickname">Nickname</Label>
                      <Input
                        id="nickname"
                        name="nickname"
                        value={userData.nickname}
                        onChange={handleUserDataChange}
                      />
                    </div>

                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                      <div className="space-y-2">
                        <Label htmlFor="cpf">CPF</Label>
                        <Input id="cpf" name="cpf" value={userData.cpf} onChange={handleUserDataChange} disabled />
                      </div>

                      <div className="space-y-2">
                        <Label htmlFor="phone">Telefone</Label>
                        <Input id="telefone" name="telefone" value={userData.telefone} onChange={handleUserDataChange} />
                      </div>
                    </div>

                    <div className="flex justify-between pt-4">
                      <Button type="submit" disabled={isLoading}>
                        {isLoading ? "Salvando..." : "Salvar Alterações"}
                      </Button>
                      <Button type="button" variant="destructive" onClick={handleLogout}>
                        Sair
                      </Button>
                    </div>
                  </form>
                </CardContent>
              </Card>
            </TabsContent>

            <TabsContent value="password">
              <Card>
                <CardHeader>
                  <CardTitle>Alterar Senha</CardTitle>
                  <CardDescription>
                    Altere sua senha aqui. Você precisará da senha atual para confirmar.
                  </CardDescription>
                </CardHeader>
                <CardContent>
                  <form onSubmit={handleUpdatePassword} className="space-y-4">
                    {message.text && message.type === "success" && (
                      <div className="p-3 bg-green-100 text-green-800 text-sm rounded-md">{message.text}</div>
                    )}
                    {message.text && message.type === "error" && (
                      <div className="p-3 bg-destructive/15 text-destructive text-sm rounded-md">{message.text}</div>
                    )}

                    <div className="space-y-2">
                      <Label htmlFor="currentPassword">Senha Atual</Label>
                      <Input
                        id="currentPassword"
                        name="currentPassword"
                        type="password"
                        value={passwordData.currentPassword}
                        onChange={handlePasswordChange}
                        required
                      />
                    </div>

                    <div className="space-y-2">
                      <Label htmlFor="newPassword">Nova Senha</Label>
                      <Input
                        id="newPassword"
                        name="newPassword"
                        type="password"
                        value={passwordData.newPassword}
                        onChange={handlePasswordChange}
                        required
                      />
                    </div>

                    <div className="space-y-2">
                      <Label htmlFor="confirmPassword">Confirmar Nova Senha</Label>
                      <Input
                        id="confirmPassword"
                        name="confirmPassword"
                        type="password"
                        value={passwordData.confirmPassword}
                        onChange={handlePasswordChange}
                        required
                      />
                    </div>

                    <Button type="submit" className="w-full" disabled={isLoading}>
                      {isLoading ? "Atualizando..." : "Atualizar Senha"}
                    </Button>
                  </form>
                </CardContent>
              </Card>
            </TabsContent>
          </Tabs>
        </div>
      </div>
    </ProtectedRoute>
  )
}
