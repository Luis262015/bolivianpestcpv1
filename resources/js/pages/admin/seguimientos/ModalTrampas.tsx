import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';

interface ModalTrampasProps {
  open: boolean;
  onClose: () => void;
}

export default function ModalTrampas({ open, onClose }: ModalTrampasProps) {
  return (
    <Dialog
      open={open}
      onOpenChange={(isOpen) => {
        if (!isOpen) onClose();
      }}
    >
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Nuevo seguimiento de trampas</DialogTitle>
        </DialogHeader>
      </DialogContent>
    </Dialog>
  );
}
