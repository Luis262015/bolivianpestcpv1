// src/components/agenda/TaskDialog.tsx
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
import { COLORS, STATUS_CONFIG } from '@/constants/agenda';
import { cn } from '@/lib/utils';
import type { Task, TaskStatus } from '@/types/agenda';
import { format } from 'date-fns';

interface TaskDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  editingTask: Task | null;
  selectedDate: Date | null;
  taskTitle: string;
  setTaskTitle: (title: string) => void;
  taskColor: string;
  setTaskColor: (color: string) => void;
  taskStatus: TaskStatus;
  setTaskStatus: (status: TaskStatus) => void;
  onSave: () => void;
}

export function TaskDialog({
  open,
  onOpenChange,
  editingTask,
  selectedDate,
  taskTitle,
  setTaskTitle,
  taskColor,
  setTaskColor,
  taskStatus,
  setTaskStatus,
  onSave,
}: TaskDialogProps) {
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle>
            {editingTask ? 'Editar tarea' : 'Nueva tarea'} -{' '}
            {selectedDate && format(selectedDate, 'dd MMMM yyyy')}
          </DialogTitle>
        </DialogHeader>
        <div className="space-y-4">
          <div>
            <Label htmlFor="title">Título</Label>
            <Input
              id="title"
              value={taskTitle}
              onChange={(e) => setTaskTitle(e.target.value)}
              placeholder="Reunión con equipo"
              autoFocus
            />
          </div>

          <div>
            <Label>Estado</Label>
            <div className="mt-2 grid grid-cols-3 gap-2">
              {(['pendiente', 'postergado', 'completado'] as TaskStatus[]).map(
                (status) => (
                  <Button
                    key={status}
                    variant={taskStatus === status ? 'default' : 'outline'}
                    size="sm"
                    onClick={() => setTaskStatus(status)}
                    className="flex items-center gap-1"
                  >
                    {STATUS_CONFIG[status].icon}
                    {STATUS_CONFIG[status].label}
                  </Button>
                ),
              )}
            </div>
          </div>

          <div>
            <Label>Color</Label>
            <div className="mt-2 flex gap-2">
              {COLORS.map((color) => (
                <button
                  key={color}
                  onClick={() => setTaskColor(color)}
                  className={cn(
                    'h-8 w-8 rounded-full transition-transform',
                    color,
                    taskColor === color &&
                      'scale-110 ring-2 ring-foreground ring-offset-2',
                  )}
                />
              ))}
            </div>
          </div>
        </div>
        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)}>
            Cancelar
          </Button>
          <Button onClick={onSave}>
            {editingTask ? 'Actualizar' : 'Guardar'}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
