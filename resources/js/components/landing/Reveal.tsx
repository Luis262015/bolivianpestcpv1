import { useEffect, useRef, useState, type ElementType, type ReactNode } from 'react';

type RevealVariant = 'up' | 'left' | 'right' | 'zoom';

interface RevealProps {
  children: ReactNode;
  className?: string;
  /** Dirección de la animación de entrada */
  variant?: RevealVariant;
  /** Retraso en ms para crear efecto de cascada (stagger) */
  delay?: number;
  /** Etiqueta HTML a renderizar (div, section, span, etc.) */
  as?: ElementType;
  /** Si false, vuelve a animar cada vez que entra al viewport */
  once?: boolean;
}

const variantClass: Record<RevealVariant, string> = {
  up: '',
  left: 'reveal-left',
  right: 'reveal-right',
  zoom: 'reveal-zoom',
};

/**
 * Envuelve cualquier contenido para animarlo cuando entra al viewport.
 * Usa IntersectionObserver y respeta `prefers-reduced-motion` (vía CSS en app.css).
 */
export default function Reveal({
  children,
  className = '',
  variant = 'up',
  delay = 0,
  as: Tag = 'div',
  once = true,
}: RevealProps) {
  const ref = useRef<HTMLElement | null>(null);
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    const el = ref.current;
    if (!el) return;

    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          setVisible(true);
          if (once) observer.disconnect();
        } else if (!once) {
          setVisible(false);
        }
      },
      { threshold: 0.15, rootMargin: '0px 0px -10% 0px' },
    );

    observer.observe(el);
    return () => observer.disconnect();
  }, [once]);

  return (
    <Tag
      ref={ref}
      className={`reveal ${variantClass[variant]} ${visible ? 'is-visible' : ''} ${className}`}
      style={delay ? { transitionDelay: `${delay}ms` } : undefined}
    >
      {children}
    </Tag>
  );
}
