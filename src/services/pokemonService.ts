
import { PokemonListResponse, Pokemon } from "../models/Pokemon";

const BASE_URL = "https://pokeapi.co/api/v2";
const SPRITE_BASE_URL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon";

export const fetchPokemons = async (offset: number = 0, limit: number = 20): Promise<Pokemon[]> => {
  try {
    const response = await fetch(`${BASE_URL}/pokemon?offset=${offset}&limit=${limit}`);
    
    if (!response.ok) {
      throw new Error(`Failed to fetch Pokemons: ${response.status}`);
    }
    
    const data: PokemonListResponse = await response.json();
    
    // Para evitar muitas requisições, vamos buscar informações básicas adicionais
    const pokemonPromises = data.results.map(async (pokemon) => {
      // Extract the ID from the URL
      const urlParts = pokemon.url.split("/");
      const id = parseInt(urlParts[urlParts.length - 2]);
      
      // Vamos buscar informações adicionais para cada pokémon
      try {
        const detailsResponse = await fetch(`${BASE_URL}/pokemon/${id}`);
        if (detailsResponse.ok) {
          const details = await detailsResponse.json();
          return {
            id,
            name: pokemon.name,
            imageUrl: `${SPRITE_BASE_URL}/${id}.png`,
            types: details.types.map((type: any) => type.type.name),
            height: details.height / 10, // Converter para metros
            weight: details.weight / 10, // Converter para kg
          };
        }
      } catch (error) {
        console.error(`Error fetching details for Pokemon #${id}:`, error);
      }
      
      // Fallback para dados básicos se não conseguimos obter os detalhes
      return {
        id,
        name: pokemon.name,
        imageUrl: `${SPRITE_BASE_URL}/${id}.png`,
      };
    });
    
    return Promise.all(pokemonPromises);
  } catch (error) {
    console.error("Error fetching Pokemon data:", error);
    throw error;
  }
};
