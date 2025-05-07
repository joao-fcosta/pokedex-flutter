
import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import { Palette } from "lucide-react";

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
    
    window.addEventListener("scroll", handleScroll, {
      passive: true
    });
    
    return () => window.removeEventListener("scroll", handleScroll);
  }, [lastScrollY]);

  return (
    <header className="bg-pokemon-red text-white py-4 px-4 shadow-md sticky top-0 z-10">
      <div className="max-w-4xl mx-auto flex flex-col items-center justify-center">
        <h1 className={`text-2xl sm:text-4xl font-bold mb-1 transition-all duration-300 ${isVisible ? "opacity-100" : "opacity-0 h-0 mb-0"}`}>
          Poké-Scroll
        </h1>
        <nav className="flex items-center justify-center">
          <Link to="/" className="px-3 py-1 hover:bg-red-600 rounded-md transition-colors">Home</Link>
          <Link to="/design-system" className="px-3 py-1 hover:bg-red-600 rounded-md transition-colors flex items-center">
            <Palette className="h-4 w-4 mr-1" />
            Design System
          </Link>
        </nav>
      </div>
    </header>
  );
};

export default Header;
