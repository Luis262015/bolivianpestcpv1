// src/components/agenda/TaskList.tsx
'use client';

import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { ScrollArea } from '@/components/ui/scroll-area';
import { STATUS_CONFIG } from '@/constants/agenda';
import { cn } from '@/lib/utils';
import type { Task } from '@/types/agenda';
import { format } from 'date-fns';
import { Plus, Trash2 } from 'lucide-react';

interface TaskListProps {
  tasks: Task[];
  onOpenDialog: (date?: Date, task?: Task) => void;
  onDeleteTask: (id: string) => void;
}

export function TaskList({ tasks, onOpenDialog, onDeleteTask }: TaskListProps) {
  const sortedTasks = [...tasks].sort((a, b) => a.date.localeCompare(b.date));

  return (
    <Card className="h-full">
      <CardHeader>
        <CardTitle className="flex items-center justify-between text-lg">
          Tareas ({tasks.length})
          <Button size="sm" onClick={() => onOpenDialog(new Date())}>
            <Plus className="mr-1 h-4 w-4" /> Nueva
          </Button>
        </CardTitle>
      </CardHeader>
      <CardContent className="p-0">
        <ScrollArea className="h-[calc(100vh-16rem)] px-4">
          {sortedTasks.length === 0 ? (
            <p className="py-8 text-center text-muted-foreground">
              No hay tareas
            </p>
          ) : (
            <div className="space-y-3 pb-4">
              {sortedTasks.map((task) => (
                <div
                  key={task.id}
                  className="flex cursor-pointer items-start gap-3 rounded-lg border bg-card p-3 transition-colors hover:bg-muted/50"
                  onClick={() => onOpenDialog(undefined, task)}
                >
                  <div
                    className={cn(
                      'mt-1 h-3 w-3 flex-shrink-0 rounded-full',
                      task.color,
                    )}
                  />
                  <div className="min-w-0 flex-1">
                    <p className="truncate text-sm font-medium">{task.title}</p>
                    <div className="mt-1 flex items-center gap-2 text-xs text-muted-foreground">
                      <span>{format(new Date(task.date), 'dd MMM yyyy')}</span>
                      <span className="mx-1">•</span>
                      <span className={STATUS_CONFIG[task.status].color}>
                        {STATUS_CONFIG[task.status].icon}{' '}
                        {STATUS_CONFIG[task.status].label}
                      </span>
                    </div>
                  </div>
                  <Button
                    size="sm"
                    variant="ghost"
                    onClick={(e) => {
                      e.stopPropagation();
                      onDeleteTask(task.id);
                    }}
                  >
                    <Trash2 className="h-4 w-4" />
                  </Button>
                </div>
              ))}
            </div>
          )}
        </ScrollArea>
      </CardContent>
    </Card>
  );
}
