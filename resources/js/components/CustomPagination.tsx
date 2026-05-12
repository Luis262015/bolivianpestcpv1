import {
  Pagination,
  PaginationContent,
  PaginationEllipsis,
  PaginationItem,
  PaginationLink,
  PaginationNext,
  PaginationPrevious,
} from '@/components/ui/pagination';
import { PaginationLink as LinkType } from '@/types';

interface CustomPaginationProps {
  links: LinkType[];
}

export default function CustomPagination({ links = [] }: CustomPaginationProps) {
  if (links.length < 3) return null;

  // Laravel siempre pone prev en [0] y next en [length-1], independientemente del idioma
  const prevLink = links[0];
  const nextLink = links[links.length - 1];
  const pageLinks = links.slice(1, -1);

  return (
    <Pagination>
      <PaginationContent>
        <PaginationItem>
          <PaginationPrevious
            href={prevLink.url ?? '#'}
            aria-disabled={!prevLink.url}
            className={!prevLink.url ? 'pointer-events-none opacity-50' : ''}
          />
        </PaginationItem>

        {pageLinks.map((link, index) => (
          <PaginationItem key={index}>
            {!link.url ? (
              <PaginationEllipsis />
            ) : (
              <PaginationLink href={link.url} isActive={link.active}>
                {link.label}
              </PaginationLink>
            )}
          </PaginationItem>
        ))}

        <PaginationItem>
          <PaginationNext
            href={nextLink.url ?? '#'}
            aria-disabled={!nextLink.url}
            className={!nextLink.url ? 'pointer-events-none opacity-50' : ''}
          />
        </PaginationItem>
      </PaginationContent>
    </Pagination>
  );
}
