// resources/js/components/MultiSelect.tsx
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import {
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
} from '@/components/ui/command';
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from '@/components/ui/popover';
import { Check, ChevronDown, X } from 'lucide-react';
import { useState } from 'react';

interface Etiqueta {
  id: number;
  nombre: string;
}

interface MultiSelectProps {
  opciones: Etiqueta[];
  seleccionadas: number[];
  onChange: (ids: number[]) => void;
  placeholder?: string;
}

export function MultiSelect({
  opciones,
  seleccionadas,
  onChange,
  placeholder = 'Selecciona etiquetas...',
}: MultiSelectProps) {
  const [open, setOpen] = useState(false);
  const [search, setSearch] = useState('');

  const etiquetasFiltradas = opciones.filter((e) =>
    e.nombre.toLowerCase().includes(search.toLowerCase()),
  );

  // Alternar selección
  const toggleEtiqueta = (id: number) => {
    if (seleccionadas.includes(id)) {
      onChange(seleccionadas.filter((i) => i !== id)); // Deseleccionar
    } else {
      onChange([...seleccionadas, id]); // Seleccionar
    }
    setOpen(false);
  };

  const handleRemove = (id: number) => {
    onChange(seleccionadas.filter((i) => i !== id));
  };

  return (
    <Popover open={open} onOpenChange={setOpen}>
      <PopoverTrigger asChild>
        <Button
          variant="outline"
          role="combobox"
          className="h-auto w-full justify-between p-2"
        >
          <div className="flex flex-wrap gap-1">
            {seleccionadas?.length > 0 ? (
              seleccionadas.map((id) => {
                const etiqueta = opciones.find((e) => e.id === id);
                return etiqueta ? (
                  <Badge key={id} variant="secondary" className="mr-1 mb-1">
                    {etiqueta.nombre}
                    <X
                      className="ml-1 h-3 w-3 cursor-pointer"
                      onClick={(e) => {
                        e.stopPropagation();
                        handleRemove(id);
                      }}
                    />
                  </Badge>
                ) : null;
              })
            ) : (
              <span className="text-muted-foreground">{placeholder}</span>
            )}
          </div>
          <span className="ml-2">
            <ChevronDown></ChevronDown>
          </span>
        </Button>
      </PopoverTrigger>
      <PopoverContent className="w-full p-0" align="start">
        <Command>
          <CommandInput
            placeholder="Buscar etiqueta..."
            value={search}
            onValueChange={setSearch}
          />
          <CommandEmpty>No se encontraron etiquetas.</CommandEmpty>
          <CommandGroup className="max-h-64 overflow-auto">
            {etiquetasFiltradas.map((etiqueta) => {
              const isSelected = seleccionadas.includes(etiqueta.id);
              return (
                <CommandItem
                  key={etiqueta.id}
                  onSelect={() => toggleEtiqueta(etiqueta.id)} // Alternar
                  className="cursor-pointer"
                >
                  <div className="flex w-full items-center">
                    <div
                      className={`mr-2 h-4 w-4 rounded border ${
                        isSelected
                          ? 'bg-primary text-primary-foreground'
                          : 'border-gray-300'
                      }`}
                    >
                      {isSelected && <Check></Check>}
                    </div>
                    {etiqueta.nombre}
                  </div>
                </CommandItem>
              );
            })}
          </CommandGroup>
        </Command>
      </PopoverContent>
    </Popover>
  );
}
