
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
    
    return data.results.map(pokemon => {
      // Extract the ID from the URL
      const urlParts = pokemon.url.split("/");
      const id = parseInt(urlParts[urlParts.length - 2]);
      
      return {
        id,
        name: pokemon.name,
        imageUrl: `${SPRITE_BASE_URL}/${id}.png`
      };
    });
  } catch (error) {
    console.error("Error fetching Pokemon data:", error);
    throw error;
  }
};
