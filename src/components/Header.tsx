
import React from "react";

const Header: React.FC = () => {
  return (
    <header className="bg-pokemon-red text-white py-6 px-4 shadow-md">
      <div className="max-w-4xl mx-auto flex flex-col items-center justify-center">
        <h1 className="text-3xl sm:text-4xl font-bold mb-2">Poké-Scroll</h1>
        <p className="text-sm sm:text-base opacity-90 text-center">
          Scroll through the timeline of Pokémon with infinite loading
        </p>
      </div>
    </header>
  );
};

export default Header;
