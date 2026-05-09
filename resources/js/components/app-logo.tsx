import { AppLogoIcon } from './app-logo-icon';
import { useSidebar } from '@/components/ui/sidebar';

export default function AppLogo() {
  const { state } = useSidebar();
  const isCollapsed = state === 'collapsed';

  return (
    <>
      <div className="flex h-10 w-10 items-center justify-center">
        <AppLogoIcon className="h-6 w-6" />
      </div>
      {!isCollapsed && (
        <div className="ml-2 flex-1 text-left text-sm">
          <span className="mb-0.5 truncate leading-tight font-semibold">
            Bolivian Pest
          </span>
        </div>
      )}
    </>
  );
}
