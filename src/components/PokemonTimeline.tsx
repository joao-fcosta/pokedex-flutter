
import React, { useState, useEffect, useRef, useCallback } from "react";
import { Pokemon } from "../models/Pokemon";
import { fetchPokemons } from "../services/pokemonService";
import PokemonCard from "./PokemonCard";
import PokeballLoader from "./PokeballLoader";
import { toast } from "@/components/ui/use-toast";
import { useIsMobile } from "../hooks/use-mobile";

const PokemonTimeline: React.FC = () => {
  const [pokemons, setPokemons] = useState<Pokemon[]>([]);
  const [offset, setOffset] = useState(0);
  const [isLoading, setIsLoading] = useState(false);
  const [hasError, setHasError] = useState(false);
  const [hasMore, setHasMore] = useState(true);
  const observerRef = useRef<IntersectionObserver | null>(null);
  const loaderRef = useRef<HTMLDivElement | null>(null);
  const isMobile = useIsMobile();

  const loadPokemons = useCallback(async () => {
    if (isLoading || !hasMore) return;
    
    setIsLoading(true);
    setHasError(false);
    
    try {
      // Reduzir o limite para mobile para melhor performance
      const limit = isMobile ? 10 : 20;
      const newPokemons = await fetchPokemons(offset, limit);
      
      if (newPokemons.length === 0) {
        setHasMore(false);
      } else {
        setPokemons(prev => [...prev, ...newPokemons]);
        setOffset(prev => prev + limit);
      }
    } catch (error) {
      console.error("Failed to fetch Pokemons:", error);
      setHasError(true);
      toast({
        title: "Erro",
        description: "Falha ao carregar Pokémons. Tente novamente.",
        variant: "destructive"
      });
    } finally {
      setIsLoading(false);
    }
  }, [offset, isLoading, hasMore, isMobile]);

  useEffect(() => {
    loadPokemons();
  }, []);

  useEffect(() => {
    if (observerRef.current) {
      observerRef.current.disconnect();
    }

    const observer = new IntersectionObserver(
      entries => {
        if (entries[0].isIntersecting && !isLoading) {
          loadPokemons();
        }
      },
      { threshold: 0.5 }
    );

    observerRef.current = observer;

    if (loaderRef.current) {
      observer.observe(loaderRef.current);
    }

    return () => {
      if (observerRef.current) {
        observerRef.current.disconnect();
      }
    };
  }, [loadPokemons, isLoading]);

  return (
    <div className="relative pokemon-timeline py-6 px-2 sm:px-4">
      <div className="max-w-4xl mx-auto flex flex-col items-center">
        {pokemons.map((pokemon, index) => (
          <PokemonCard
            key={pokemon.id}
            pokemon={pokemon}
            position={index % 2 === 0 ? "left" : "right"}
          />
        ))}
        <div
          ref={loaderRef}
          className="flex justify-center py-6 w-full"
        >
          {isLoading ? (
            <PokeballLoader />
          ) : hasError ? (
            <button
              onClick={() => loadPokemons()}
              className="bg-pokemon-red text-white px-6 py-3 rounded-full font-bold hover:bg-opacity-90 transition-all"
            >
              Tentar Novamente
            </button>
          ) : !hasMore ? (
            <p className="text-center text-gray-500">
              Você pegou todos! Não há mais Pokémon para carregar.
            </p>
          ) : null}
        </div>
      </div>
    </div>
  );
};

export default PokemonTimeline;
