<script setup lang="ts">
interface Props {
  status: 'complete' | 'planned' | 'in-progress' | 'deprecated'
}

defineProps<Props>()

const statusConfig: Record<'complete' | 'planned' | 'in-progress' | 'deprecated', { label: string, color: 'success' | 'info' | 'warning' | 'error', icon: string }> = {
  'complete': { label: 'Complete', color: 'success', icon: 'i-lucide-check-circle' },
  'planned': { label: 'Planned', color: 'info', icon: 'i-lucide-clock' },
  'in-progress': { label: 'In Progress', color: 'warning', icon: 'i-lucide-loader' },
  'deprecated': { label: 'Deprecated', color: 'error', icon: 'i-lucide-alert-triangle' }
}
</script>

<template>
  <UBadge
    :color="statusConfig[status].color"
    :icon="statusConfig[status].icon"
    variant="subtle"
  >
    {{ statusConfig[status].label }}
  </UBadge>
</template>
