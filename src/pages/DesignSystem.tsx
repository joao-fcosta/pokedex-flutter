
import React from "react";
import Header from "@/components/Header";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Separator } from "@/components/ui/separator";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import PokeballLoader from "@/components/PokeballLoader";
import { Palette } from "lucide-react";

const DesignSystem: React.FC = () => {
  const colorClasses = [
    { name: "Pokemon Red", class: "bg-pokemon-red" },
    { name: "Pokemon Blue", class: "bg-pokemon-blue" },
    { name: "Pokemon Yellow", class: "bg-pokemon-yellow" },
    { name: "Pokemon Dark", class: "bg-pokemon-dark" },
    { name: "Pokemon Light", class: "bg-pokemon-light" }
  ];

  const typeColors: Record<string, string> = {
    normal: "bg-gray-400",
    fire: "bg-red-500",
    water: "bg-blue-500",
    electric: "bg-yellow-400",
    grass: "bg-green-500",
    ice: "bg-blue-200",
    fighting: "bg-red-700",
    poison: "bg-purple-500",
    ground: "bg-yellow-700",
    flying: "bg-indigo-300",
    psychic: "bg-pink-500",
    bug: "bg-green-400",
    rock: "bg-yellow-800",
    ghost: "bg-purple-700",
    dragon: "bg-indigo-700",
    dark: "bg-gray-800",
    steel: "bg-gray-500",
    fairy: "bg-pink-300"
  };

  return (
    <div className="min-h-screen bg-gray-50">
      <Header />
      <main className="container mx-auto py-6 px-4">
        <div className="flex items-center mb-6">
          <Palette className="mr-2 h-6 w-6 text-pokemon-red" />
          <h1 className="text-2xl font-bold">Design System</h1>
        </div>
        
        <Tabs defaultValue="colors">
          <TabsList className="w-full max-w-md mx-auto mb-6">
            <TabsTrigger value="colors" className="flex-1">Cores</TabsTrigger>
            <TabsTrigger value="components" className="flex-1">Componentes</TabsTrigger>
            <TabsTrigger value="typography" className="flex-1">Tipografia</TabsTrigger>
          </TabsList>
          
          <TabsContent value="colors" className="space-y-6">
            <section>
              <h2 className="text-xl font-semibold mb-4">Cores Principais</h2>
              <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-5 gap-4">
                {colorClasses.map((color) => (
                  <div key={color.name} className="flex flex-col items-center">
                    <div className={`w-20 h-20 rounded-full ${color.class}`}></div>
                    <span className="text-sm mt-2">{color.name}</span>
                  </div>
                ))}
              </div>
            </section>
            
            <Separator />
            
            <section>
              <h2 className="text-xl font-semibold mb-4">Cores de Tipos</h2>
              <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-6 gap-4">
                {Object.entries(typeColors).map(([type, colorClass]) => (
                  <div key={type} className="flex flex-col items-center">
                    <div className={`w-16 h-8 rounded-full ${colorClass} flex items-center justify-center text-white text-xs`}>
                      {type}
                    </div>
                    <span className="text-xs mt-1 capitalize">{type}</span>
                  </div>
                ))}
              </div>
            </section>
          </TabsContent>
          
          <TabsContent value="components" className="space-y-6">
            <section>
              <h2 className="text-xl font-semibold mb-4">Cards</h2>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <Card>
                  <CardHeader>
                    <CardTitle>Card Title</CardTitle>
                    <CardDescription>Card description goes here</CardDescription>
                  </CardHeader>
                  <CardContent>
                    <p>Este é um exemplo de conteúdo do card</p>
                  </CardContent>
                  <CardFooter>
                    <Button>Ação</Button>
                  </CardFooter>
                </Card>
                
                <div className="space-y-4">
                  <h3 className="font-medium">Pokeball Loader</h3>
                  <div className="flex justify-center">
                    <PokeballLoader />
                  </div>
                </div>
              </div>
            </section>
            
            <Separator />
            
            <section>
              <h2 className="text-xl font-semibold mb-4">Botões</h2>
              <div className="flex flex-wrap gap-4">
                <Button>Padrão</Button>
                <Button variant="destructive">Destructive</Button>
                <Button variant="outline">Outline</Button>
                <Button variant="secondary">Secondary</Button>
                <Button variant="ghost">Ghost</Button>
                <Button variant="link">Link</Button>
              </div>
            </section>
            
            <Separator />
            
            <section>
              <h2 className="text-xl font-semibold mb-4">Badges</h2>
              <div className="flex flex-wrap gap-2">
                <Badge>Padrão</Badge>
                <Badge variant="secondary">Secondary</Badge>
                <Badge variant="destructive">Destructive</Badge>
                <Badge variant="outline">Outline</Badge>
                
                <div className="w-full mt-4"></div>
                
                {Object.entries(typeColors).slice(0, 6).map(([type, _]) => (
                  <Badge key={type} className={`${typeColors[type]} text-white border-none`}>
                    {type}
                  </Badge>
                ))}
              </div>
            </section>
          </TabsContent>
          
          <TabsContent value="typography" className="space-y-6">
            <section>
              <h2 className="text-xl font-semibold mb-4">Hierarquia de Texto</h2>
              <div className="space-y-4">
                <div>
                  <h1 className="text-4xl font-bold">H1 Heading</h1>
                  <p className="text-muted-foreground text-sm">text-4xl font-bold</p>
                </div>
                <div>
                  <h2 className="text-3xl font-bold">H2 Heading</h2>
                  <p className="text-muted-foreground text-sm">text-3xl font-bold</p>
                </div>
                <div>
                  <h3 className="text-2xl font-bold">H3 Heading</h3>
                  <p className="text-muted-foreground text-sm">text-2xl font-bold</p>
                </div>
                <div>
                  <h4 className="text-xl font-semibold">H4 Heading</h4>
                  <p className="text-muted-foreground text-sm">text-xl font-semibold</p>
                </div>
                <div>
                  <h5 className="text-lg font-semibold">H5 Heading</h5>
                  <p className="text-muted-foreground text-sm">text-lg font-semibold</p>
                </div>
              </div>
            </section>
            
            <Separator />
            
            <section>
              <h2 className="text-xl font-semibold mb-4">Parágrafos</h2>
              <div className="space-y-4">
                <div>
                  <p className="text-base">Texto base padrão para parágrafos.</p>
                  <p className="text-muted-foreground text-sm">text-base</p>
                </div>
                <div>
                  <p className="text-sm">Texto menor para informações secundárias.</p>
                  <p className="text-muted-foreground text-sm">text-sm</p>
                </div>
                <div>
                  <p className="text-xs">Texto muito pequeno para notas e legendas.</p>
                  <p className="text-muted-foreground text-sm">text-xs</p>
                </div>
              </div>
            </section>
          </TabsContent>
        </Tabs>
      </main>
    </div>
  );
};

export default DesignSystem;
