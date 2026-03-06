// components/WhyHighlightCard.tsx
'use client';

import { useState } from 'react';
import { Phone } from 'lucide-react'; // o la librería de iconos que uses

interface WhyHighlightCardProps {
  imageSrc: string;
  imageAlt: string;
  title: string;
  phoneNumber: string;     // ej: "59176738282"
  phoneDisplay: string;    // ej: "+591 76738282"
  whatsappLink?: string;   // opcional, por si quieres personalizar el link
  className?: string;
}

export default function WhyHighlightCard({
  imageSrc,
  imageAlt,
  title,
  phoneNumber,
  phoneDisplay,
  whatsappLink,
  className = '',
}: WhyHighlightCardProps) {
  const [isModalOpen, setIsModalOpen] = useState(false);

  const waLink = whatsappLink || `https://wa.me/${phoneNumber}`;

  return (
    <>
      {/* Card */}
      <div className={`why-highlight-card ${className}`}>
        <img
          src={imageSrc}
          alt={imageAlt}
          className="cursor-pointer object-cover w-full transition-transform hover:scale-[1.02] duration-300"
          onClick={() => setIsModalOpen(true)}
        />
        {/* <div className="highlight-content p-6">
          <h3 className="mb-4 text-2xl font-bold md:text-3xl">{title}</h3>
          <a
            href={waLink}
            target="_blank"
            rel="noopener noreferrer"
            className="highlight-btn inline-flex items-center gap-3 text-lg font-semibold text-white bg-green-600 hover:bg-green-700 px-6 py-3 rounded-lg transition-colors"
          >
            <Phone className="h-6 w-6" />
            Llame ahora {phoneDisplay}
          </a>
        </div> */}
      </div>

      {/* Modal exclusivo para ESTA imagen */}
      {isModalOpen && (
        <div
          className="fixed inset-0 z-50 flex items-center justify-center bg-black/85 backdrop-blur-sm"
          onClick={() => setIsModalOpen(false)}
        >
          <div
            className="relative max-w-5xl w-[95%] max-h-[90vh] px-4"
            onClick={(e) => e.stopPropagation()}
          >
            <button
              className="absolute -top-12 right-2 text-white text-5xl hover:text-gray-300 transition-colors"
              onClick={() => setIsModalOpen(false)}
              aria-label="Cerrar"
            >
              ×
            </button>

            <img
              src={imageSrc}
              alt={`${imageAlt} - vista ampliada`}
              className="max-h-[85vh] max-w-full object-contain rounded-xl shadow-2xl mx-auto"
            />
          </div>
        </div>
      )}
    </>
  );
}