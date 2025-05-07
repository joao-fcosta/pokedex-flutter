
import React from "react";

const PokeballLoader: React.FC = () => {
  return (
    <div className="pokeball-loader w-16 h-16 relative">
      <div className="w-16 h-16 bg-white rounded-full border-4 border-pokemon-dark relative overflow-hidden">
        <div className="bg-pokemon-red w-full h-8 absolute top-0"></div>
        <div className="absolute inset-0 flex items-center justify-center">
          <div className="w-6 h-6 bg-white rounded-full border-4 border-pokemon-dark z-10"></div>
        </div>
        <div className="absolute w-full h-2 bg-pokemon-dark top-1/2 -translate-y-1/2"></div>
      </div>
    </div>
  );
};

export default PokeballLoader;
