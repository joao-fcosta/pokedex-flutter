
import React from "react";
import { Pokemon } from "../models/Pokemon";
import { Card } from "./ui/card";

interface PokemonCardProps {
  pokemon: Pokemon;
  position: "left" | "right";
}

const PokemonCard: React.FC<PokemonCardProps> = ({ pokemon, position }) => {
  return (
    <div
      className={`flex mb-8 w-full sm:w-[calc(50%-20px)] ${
        position === "left" ? "sm:mr-auto sm:pl-0" : "sm:ml-auto sm:pr-0"
      }`}
    >
      <Card className="overflow-hidden w-full bg-white hover:shadow-lg transition-all duration-300 transform hover:scale-105">
        <div className="p-6">
          <div className="bg-pokemon-light rounded-full p-4 mb-4 mx-auto w-32 h-32 flex items-center justify-center">
            <img
              src={pokemon.imageUrl}
              alt={pokemon.name}
              className="w-24 h-24 object-contain animate-bounce-slow"
              onError={(e) => {
                (e.target as HTMLImageElement).src = "/placeholder.svg";
              }}
            />
          </div>
          <div className="text-center">
            <span className="text-xs font-bold text-pokemon-blue block mb-1">
              POKÉMON #{pokemon.id}
            </span>
            <h3 className="text-xl font-bold text-pokemon-dark">
              {pokemon.name.toUpperCase()}
            </h3>
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
