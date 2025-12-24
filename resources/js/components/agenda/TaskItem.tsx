// src/components/agenda/TaskItem.tsx
import { STATUS_CONFIG } from '@/constants/agenda';
import { cn } from '@/lib/utils';
import { Task } from '@/types/agenda';
import { GripVertical, Trash2 } from 'lucide-react';

interface TaskItemProps {
  task: Task;
  onEdit: () => void;
  onDelete: () => void;
  draggable?: boolean;
  onDragStart?: (e: React.DragEvent<HTMLDivElement>) => void;
}

export function TaskItem({
  task,
  onEdit,
  onDelete,
  draggable = false,
  onDragStart,
}: TaskItemProps) {
  return (
    <div
      draggable={draggable}
      onDragStart={onDragStart}
      onClick={onEdit}
      className={cn(
        'group flex cursor-pointer items-center gap-1 rounded p-1 text-xs text-white',
        task.color,
      )}
    >
      {draggable && <GripVertical className="h-3 w-3 opacity-70" />}
      <span className="flex-1 truncate">{task.title}</span>
      <div className={cn('text-xs', STATUS_CONFIG[task.status].color)}>
        {STATUS_CONFIG[task.status].icon}
      </div>
      <button
        onClick={(e) => {
          e.stopPropagation();
          onDelete();
        }}
        className="opacity-0 transition-opacity group-hover:opacity-100"
      >
        <Trash2 className="h-3 w-3" />
      </button>
    </div>
  );
}
