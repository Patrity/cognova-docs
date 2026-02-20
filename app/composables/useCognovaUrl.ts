export function useCognovaUrl() {
  return useCookie<string>('cognova-url', {
    maxAge: 60 * 60 * 24 * 365
  })
}
