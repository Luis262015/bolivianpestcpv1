import { Button } from '@/components/ui/button';
import {
  Dialog,
  DialogContent,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';

interface Item {
  id: number;
  nombre: string;
}

interface ItemDialogProps {
  isOpen: boolean;
  onOpenChange: (open: boolean) => void;
  editItem: Item | null;
  itemName: string;
  setItemName: (name: string) => void;
  onSubmit: (e: React.FormEvent) => void;
  titlePage: string;
}

export default function ItemDialog({
  isOpen,
  onOpenChange,
  editItem,
  itemName,
  setItemName,
  onSubmit,
  titlePage,
}: ItemDialogProps) {
  return (
    <Dialog open={isOpen} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-md">
        <DialogHeader>
          <DialogTitle>{editItem ? 'Editar' : 'Crear'}</DialogTitle>
        </DialogHeader>
        <form onSubmit={onSubmit} className="space-y-4">
          <div>
            <Label htmlFor="nombre">Nombre: {titlePage}</Label>
            <Input
              id="nombre"
              value={itemName}
              onChange={(e) => setItemName(e.target.value)}
              required
            />
          </div>

          <DialogFooter>
            <Button type="submit" className="w-full">
              {editItem ? 'Actualizar' : 'Crear'}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
}
