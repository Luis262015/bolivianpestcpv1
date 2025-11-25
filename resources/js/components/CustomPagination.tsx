// resources/js/Components/CustomPagination.tsx

import {
  Pagination,
  PaginationContent,
  PaginationEllipsis,
  PaginationItem,
  PaginationLink, // Adaptador de Inertia/Shadcn
  PaginationNext,
  PaginationPrevious, // Adaptador de Inertia/Shadcn
} from '@/components/ui/pagination';
import { PaginationLink as LinkType } from '@/types';

// Tipamos las props del componente
interface CustomPaginationProps {
  links: LinkType[];
}

export default function CustomPagination({
  links = [],
}: CustomPaginationProps) {
  // Filtra los enlaces para obtener solo los que tienen URL (activos o no)
  const availableLinks = links.filter((link) => link.url !== null);

  // Encuentra los enlaces Anterior y Siguiente
  const prevLink = availableLinks.find(
    (link) =>
      link.label.includes('Previous') || link.label.includes('Anterior'),
  );
  const nextLink = availableLinks.find(
    (link) => link.label.includes('Next') || link.label.includes('Siguiente'),
  );

  // Filtra los enlaces de página para el cuerpo de la paginación
  const pageLinks = availableLinks.filter(
    (link) =>
      !link.label.includes('Previous') &&
      !link.label.includes('Next') &&
      !link.label.includes('...'),
  );

  // NOTA: Esta implementación simplificada no maneja las elipsis (Puntos suspensivos)
  // De forma inteligente como lo hace Laravel. Los links ya vienen de Laravel.

  return (
    <Pagination>
      <PaginationContent>
        {/* ============================================================== */}
        {/* Enlace Anterior (Previous) */}
        {/* ============================================================== */}
        {prevLink && (
          <PaginationItem>
            <PaginationPrevious
              href={prevLink.url || '#'}
              isActive={!prevLink.url}
            />
          </PaginationItem>
        )}

        {/* ============================================================== */}
        {/* Links de las páginas (1, 2, 3...) */}
        {/* ============================================================== */}
        {pageLinks.map((link, index) => (
          <PaginationItem key={index}>
            {/* Si la etiqueta es elipsis, usamos el componente Ellipsis de Shadcn */}
            {link.label === '...' ? (
              <PaginationEllipsis />
            ) : (
              <PaginationLink href={link.url || '#'} isActive={link.active}>
                {link.label}
              </PaginationLink>
            )}
          </PaginationItem>
        ))}

        {/* ============================================================== */}
        {/* Enlace Siguiente (Next) */}
        {/* ============================================================== */}
        {nextLink && (
          <PaginationItem>
            <PaginationNext
              href={nextLink.url || '#'}
              isActive={!nextLink.url}
            />
          </PaginationItem>
        )}
      </PaginationContent>
    </Pagination>
  );
}
