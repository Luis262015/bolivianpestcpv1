import { useEffect, useRef, useState } from 'react';

interface CountUpProps {
  /** Valor final al que llega el contador */
  end: number;
  /** Duración de la animación en ms */
  duration?: number;
  /** Texto antes del número (ej. "$") */
  prefix?: string;
  /** Texto después del número (ej. "+", "%", "K") */
  suffix?: string;
  className?: string;
}

/**
 * Anima un contador de 0 hasta `end` cuando entra al viewport.
 * Usa requestAnimationFrame con easing y respeta `prefers-reduced-motion`.
 */
export default function CountUp({
  end,
  duration = 2000,
  prefix = '',
  suffix = '',
  className,
}: CountUpProps) {
  const ref = useRef<HTMLSpanElement | null>(null);
  const [value, setValue] = useState(0);
  const started = useRef(false);

  useEffect(() => {
    const el = ref.current;
    if (!el) return;

    const prefersReduced = window.matchMedia(
      '(prefers-reduced-motion: reduce)',
    ).matches;

    const observer = new IntersectionObserver(
      ([entry]) => {
        if (!entry.isIntersecting || started.current) return;
        started.current = true;
        observer.disconnect();

        if (prefersReduced) {
          setValue(end);
          return;
        }

        const start = performance.now();
        const tick = (now: number) => {
          const progress = Math.min((now - start) / duration, 1);
          // easeOutCubic: arranca rápido y desacelera al final
          const eased = 1 - Math.pow(1 - progress, 3);
          setValue(Math.round(eased * end));
          if (progress < 1) requestAnimationFrame(tick);
        };
        requestAnimationFrame(tick);
      },
      { threshold: 0.4 },
    );

    observer.observe(el);
    return () => observer.disconnect();
  }, [end, duration]);

  return (
    <span ref={ref} className={className}>
      {prefix}
      {value}
      {suffix}
    </span>
  );
}
