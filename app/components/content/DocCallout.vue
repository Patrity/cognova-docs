<script setup lang="ts">
interface Props {
  type?: 'info' | 'warning' | 'tip' | 'danger'
  title?: string
}

defineProps<Props>()

const config: Record<string, { color: 'info' | 'warning' | 'success' | 'error', icon: string }> = {
  info: { color: 'info', icon: 'i-lucide-info' },
  warning: { color: 'warning', icon: 'i-lucide-alert-triangle' },
  tip: { color: 'success', icon: 'i-lucide-lightbulb' },
  danger: { color: 'error', icon: 'i-lucide-x-circle' }
}
</script>

<template>
  <UAlert
    :color="config[type || 'info'].color"
    :icon="config[type || 'info'].icon"
    :title="title"
    class="my-4"
  >
    <template #description>
      <slot />
    </template>
  </UAlert>
</template>
