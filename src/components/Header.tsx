
import React from "react";

const Header: React.FC = () => {
  return (
    <header className="bg-pokemon-red text-white py-4 px-4 shadow-md sticky top-0 z-10">
      <div className="max-w-4xl mx-auto flex flex-col items-center justify-center">
        <h1 className="text-2xl sm:text-4xl font-bold mb-1">Poké-Scroll</h1>
        <p className="text-xs sm:text-base opacity-90 text-center">
          Deslize pela timeline dos Pokémon com carregamento infinito
        </p>
      </div>
    </header>
  );
};

export default Header;
