
import React from "react";
import Header from "@/components/Header";
import PokemonTimeline from "@/components/PokemonTimeline";

const Index: React.FC = () => {
  return (
    <div className="min-h-screen bg-gray-50">
      <Header />
      <main className="container mx-auto py-6">
        <PokemonTimeline />
      </main>
      <footer className="bg-pokemon-blue py-4 text-white text-center text-sm">
        <div className="container mx-auto">
          <p>Poké-Scroll Showcase &copy; {new Date().getFullYear()}</p>
          <p className="text-xs mt-1 opacity-70">
            Pokémon and Pokémon character names are trademarks of Nintendo
          </p>
        </div>
      </footer>
    </div>
  );
};

export default Index;
