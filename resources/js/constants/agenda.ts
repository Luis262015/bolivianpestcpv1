// src/constants/agenda.ts
import type { TaskStatus } from '@/types/agenda';
import { CheckCircle2, Clock, XCircle } from 'lucide-react';
import type { ReactNode } from 'react';
import React from 'react';

export const COLORS = [
  'bg-red-500',
  'bg-blue-500',
  'bg-green-500',
  'bg-yellow-500',
  'bg-purple-500',
];

export const STATUS_CONFIG: Record<
  TaskStatus,
  { label: string; icon: ReactNode; color: string }
> = {
  pendiente: {
    label: 'Pendiente',
    icon: React.createElement(Clock, { className: 'h-3 w-3' }),
    color: 'text-orange-600',
  },
  postergado: {
    label: 'Postergado',
    // icon: <XCircle className="h-3 w-3" />,
    icon: React.createElement(XCircle, { className: 'h-3 w-3' }),
    color: 'text-red-600',
  },
  completado: {
    label: 'Completado',
    // icon: <CheckCircle2 className="h-3 w-3"/>,
    icon: React.createElement(CheckCircle2, { className: 'h-3 w-3' }),
    color: 'text-green-600',
  },
};
