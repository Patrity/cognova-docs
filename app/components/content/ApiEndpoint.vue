<script setup lang="ts">
interface Props {
  method: 'GET' | 'POST' | 'PUT' | 'DELETE' | 'PATCH'
  path: string
  auth?: boolean
}

withDefaults(defineProps<Props>(), {
  auth: true
})

const methodColors: Record<string, 'success' | 'primary' | 'warning' | 'error' | 'info'> = {
  GET: 'success',
  POST: 'primary',
  PUT: 'warning',
  DELETE: 'error',
  PATCH: 'info'
}
</script>

<template>
  <div class="my-4 p-4 rounded-lg border border-gray-200 dark:border-gray-700">
    <div class="flex items-center gap-2 mb-2">
      <UBadge
        :color="methodColors[method]"
        variant="solid"
      >
        {{ method }}
      </UBadge>
      <code class="text-sm font-mono">{{ path }}</code>
      <UBadge
        v-if="auth"
        color="neutral"
        variant="subtle"
        icon="i-lucide-lock"
      >
        Auth Required
      </UBadge>
    </div>
    <div class="prose dark:prose-invert max-w-none">
      <slot />
    </div>
  </div>
</template>
