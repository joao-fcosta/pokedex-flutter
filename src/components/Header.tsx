
import React, { useState, useEffect } from "react";

const Header: React.FC = () => {
  const [isVisible, setIsVisible] = useState(true);
  const [lastScrollY, setLastScrollY] = useState(0);

  useEffect(() => {
    const handleScroll = () => {
      const currentScrollY = window.scrollY;
      
      // Determinar se deve esconder o título baseado na direção do scroll
      if (currentScrollY > lastScrollY && currentScrollY > 50) {
        setIsVisible(false);
      } else {
        setIsVisible(true);
      }
      
      setLastScrollY(currentScrollY);
    };

    window.addEventListener("scroll", handleScroll, { passive: true });
    return () => window.removeEventListener("scroll", handleScroll);
  }, [lastScrollY]);

  return (
    <header className="bg-pokemon-red text-white py-4 px-4 shadow-md sticky top-0 z-10">
      <div className="max-w-4xl mx-auto flex flex-col items-center justify-center">
        <h1 className={`text-2xl sm:text-4xl font-bold mb-1 transition-all duration-300 ${
          isVisible ? "opacity-100" : "opacity-0 h-0 mb-0"
        }`}>
          Poké-Scroll
        </h1>
        <p className={`text-xs sm:text-base opacity-90 text-center transition-all duration-300 ${
          isVisible ? "opacity-100" : "opacity-0 h-0"
        }`}>
          Deslize pela timeline dos Pokémon com carregamento infinito
        </p>
      </div>
    </header>
  );
};

export default Header;
