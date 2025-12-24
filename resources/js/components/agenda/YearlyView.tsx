// src/components/agenda/YearlyView.tsx
'use client';

import { Badge } from '@/components/ui/badge';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { cn } from '@/lib/utils';
import type { Task } from '@/types/agenda';
import {
  eachDayOfInterval,
  endOfMonth,
  format,
  isSameDay,
  startOfMonth,
} from 'date-fns';

interface YearlyViewProps {
  year: number;
  tasks: Task[];
  getTasksForDate: (dateStr: string) => Task[];
  onGoToMonth: (monthIndex: number) => void;
  onDragOver: (e: React.DragEvent<HTMLDivElement>, dateStr: string) => void;
  onDrop: (e: React.DragEvent<HTMLDivElement>, dateStr: string) => void;
  dragOverDate: string | null;
}

export function YearlyView({
  year,
  tasks,
  getTasksForDate,
  onGoToMonth,
  onDragOver,
  onDrop,
  dragOverDate,
}: YearlyViewProps) {
  const today = new Date();

  return (
    <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-4">
      {Array.from({ length: 12 }, (_, i) => {
        const monthDate = new Date(year, i, 1);
        const monthStart = startOfMonth(monthDate);
        const monthEnd = endOfMonth(monthDate);
        const days = eachDayOfInterval({ start: monthStart, end: monthEnd });
        const startDayOfWeek = monthStart.getDay();

        return (
          <Card
            key={i}
            className="cursor-pointer overflow-hidden transition-shadow hover:shadow-lg"
            onClick={() => onGoToMonth(i)}
          >
            <CardHeader className="bg-primary/5 px-3 pt-3 pb-2">
              <CardTitle className="text-center text-sm">
                {format(monthDate, 'MMMM')}
              </CardTitle>
            </CardHeader>
            <CardContent className="p-0">
              <div className="grid grid-cols-7 gap-0 text-xs">
                {['D', 'L', 'M', 'M', 'J', 'V', 'S'].map((d) => (
                  <div
                    key={d}
                    className="p-1 text-center font-medium text-muted-foreground"
                  >
                    {d}
                  </div>
                ))}

                {Array.from({ length: startDayOfWeek }).map((_, idx) => (
                  <div key={`empty-${idx}`} />
                ))}

                {days.map((day) => {
                  const dateStr = format(day, 'yyyy-MM-dd');
                  const dayTasks = getTasksForDate(dateStr);
                  const isToday = isSameDay(day, today);

                  return (
                    <div
                      key={dateStr}
                      onDragOver={(e) => onDragOver(e, dateStr)}
                      onDrop={(e) => onDrop(e, dateStr)}
                      className={cn(
                        'min-h-6 border-t border-l p-1 text-center last:border-r',
                        isToday && 'bg-primary font-bold text-white',
                        dragOverDate === dateStr && 'bg-muted',
                      )}
                    >
                      <div className="font-medium">{format(day, 'd')}</div>
                      {dayTasks.length > 0 && (
                        <div className="mt-0.5 flex justify-center gap-0.5">
                          {dayTasks.slice(0, 3).map((task) => (
                            <div
                              key={task.id}
                              className={cn(
                                'h-1.5 w-1.5 rounded-full',
                                task.color,
                              )}
                              title={`${task.title} [${task.status}]`}
                            />
                          ))}
                          {dayTasks.length > 3 && (
                            <Badge
                              variant="secondary"
                              className="h-3 px-1 text-[10px]"
                            >
                              +{dayTasks.length - 3}
                            </Badge>
                          )}
                        </div>
                      )}
                    </div>
                  );
                })}
              </div>
            </CardContent>
          </Card>
        );
      })}
    </div>
  );
}
