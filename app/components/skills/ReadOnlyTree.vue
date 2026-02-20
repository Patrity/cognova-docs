<script setup lang="ts">
defineProps<{
  files: string[]
  selectedPath: string
}>()

const emit = defineEmits<{
  select: [path: string]
}>()

function getIcon(filename: string): string {
  const ext = filename.split('.').pop()?.toLowerCase()
  switch (ext) {
    case 'py': return 'i-lucide-file-code'
    case 'md': return 'i-lucide-file-text'
    case 'json': return 'i-lucide-file-json'
    case 'ts':
    case 'js': return 'i-lucide-file-code'
    case 'yaml':
    case 'yml': return 'i-lucide-file-cog'
    case 'sh': return 'i-lucide-terminal'
    default: return 'i-lucide-file'
  }
}
</script>

<template>
  <div class="flex flex-col gap-0.5 p-2">
    <button
      v-for="file in files"
      :key="file"
      class="flex items-center gap-2 px-2 py-1.5 rounded text-sm text-left w-full transition-colors"
      :class="selectedPath === file ? 'bg-primary/10 text-primary' : 'text-muted hover:bg-elevated hover:text-default'"
      @click="emit('select', file)"
    >
      <UIcon
        :name="getIcon(file)"
        class="size-4 shrink-0"
      />
      <span class="truncate">{{ file }}</span>
    </button>
  </div>
</template>
