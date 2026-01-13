import { usePage } from '@inertiajs/react';

export function usePermissions() {
  const { props } = usePage();

  const roles = props.auth?.roles ?? [];
  const permissions = props.auth?.permissions ?? [];

  const hasRole = (role: string) => roles.includes(role);

  const hasAnyRole = (rolesToCheck: string[]) =>
    rolesToCheck.some((r) => roles.includes(r));

  const hasPermission = (permission: string) =>
    permissions.includes(permission);

  return {
    roles,
    permissions,
    hasRole,
    hasAnyRole,
    hasPermission,
  };
}
