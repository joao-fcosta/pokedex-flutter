
import React from "react";
import { Pokemon } from "../models/Pokemon";
import { Card } from "./ui/card";
import { useIsMobile } from "../hooks/use-mobile";

interface PokemonCardProps {
  pokemon: Pokemon;
  position: "left" | "right";
}

const PokemonCard: React.FC<PokemonCardProps> = ({ pokemon, position }) => {
  const isMobile = useIsMobile();
  
  const getTypeColor = (type: string) => {
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
      fairy: "bg-pink-300",
      default: "bg-gray-400",
    };
    
    return typeColors[type] || typeColors.default;
  };

  return (
    <div
      className={`flex mb-8 w-full ${
        isMobile ? "px-2" : `sm:w-[calc(50%-20px)] ${
          position === "left" ? "sm:mr-auto sm:pl-0" : "sm:ml-auto sm:pr-0"
        }`
      }`}
    >
      <Card className="overflow-hidden w-full bg-white hover:shadow-lg transition-all duration-300 transform hover:scale-105">
        <div className="p-4">
          <div className="bg-pokemon-light rounded-full p-4 mb-4 mx-auto w-28 h-28 flex items-center justify-center">
            <img
              src={pokemon.imageUrl}
              alt={pokemon.name}
              className="w-20 h-20 object-contain animate-bounce-slow"
              onError={(e) => {
                (e.target as HTMLImageElement).src = "/placeholder.svg";
              }}
            />
          </div>
          <div className="text-center mb-3">
            <span className="text-xs font-bold text-pokemon-blue block mb-1">
              POKÉMON #{pokemon.id}
            </span>
            <h3 className="text-xl font-bold text-pokemon-dark">
              {pokemon.name.toUpperCase()}
            </h3>
          </div>
          
          {pokemon.types && (
            <div className="flex justify-center gap-2 mb-3">
              {pokemon.types.map((type, index) => (
                <span 
                  key={index}
                  className={`px-3 py-1 rounded-full text-xs text-white capitalize font-semibold ${getTypeColor(type)}`}
                >
                  {type}
                </span>
              ))}
            </div>
          )}
          
          <div className="grid grid-cols-2 gap-2 text-center text-sm">
            {pokemon.height && (
              <div className="bg-gray-100 p-2 rounded-lg">
                <span className="block text-xs text-gray-500">Altura</span>
                <span className="font-medium">{pokemon.height} m</span>
              </div>
            )}
            
            {pokemon.weight && (
              <div className="bg-gray-100 p-2 rounded-lg">
                <span className="block text-xs text-gray-500">Peso</span>
                <span className="font-medium">{pokemon.weight} kg</span>
              </div>
            )}
          </div>
        </div>
        <div
          className={`h-2 w-full ${
            position === "left" ? "bg-pokemon-red" : "bg-pokemon-blue"
          }`}
        ></div>
      </Card>
    </div>
  );
};

export default PokemonCard;
