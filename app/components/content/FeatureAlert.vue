<script setup lang="ts">
interface Props {
  status: 'complete' | 'planned' | 'in-progress' | 'deprecated'
  title?: string
}

const props = defineProps<Props>()

const alertConfig: Record<'complete' | 'planned' | 'in-progress' | 'deprecated', { color: 'success' | 'info' | 'warning' | 'error', icon: string, defaultTitle: string }> = {
  'complete': {
    color: 'success',
    icon: 'i-lucide-check-circle',
    defaultTitle: 'This feature is implemented'
  },
  'planned': {
    color: 'info',
    icon: 'i-lucide-clock',
    defaultTitle: 'This feature is planned but not yet implemented'
  },
  'in-progress': {
    color: 'warning',
    icon: 'i-lucide-loader',
    defaultTitle: 'This feature is currently being developed'
  },
  'deprecated': {
    color: 'error',
    icon: 'i-lucide-alert-triangle',
    defaultTitle: 'This feature is deprecated'
  }
}

const config = computed(() => alertConfig[props.status])
</script>

<template>
  <UAlert
    :color="config.color"
    :icon="config.icon"
    :title="title || config.defaultTitle"
    class="my-4"
  >
    <slot />
  </UAlert>
</template>
