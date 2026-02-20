<script setup lang="ts">
export interface CatalogSkill {
  name: string
  description: string
  version: string
  author: string
  tags: string[]
  requiresSecrets: string[]
  files: string[]
  updatedAt: string
}

defineProps<{
  skill: CatalogSkill
}>()

const emit = defineEmits<{
  install: [name: string]
}>()
</script>

<template>
  <div class="p-4 rounded-lg border border-default bg-elevated/50 hover:bg-elevated transition-colors">
    <div class="flex items-start justify-between gap-2 mb-2">
      <div class="flex items-center gap-2 min-w-0">
        <UIcon
          name="i-lucide-puzzle"
          class="size-4 shrink-0 text-primary"
        />
        <span class="font-medium truncate">{{ skill.name }}</span>
      </div>
      <UBadge
        variant="subtle"
        color="neutral"
        size="xs"
      >
        v{{ skill.version }}
      </UBadge>
    </div>

    <p class="text-sm text-muted line-clamp-2 mb-3">
      {{ skill.description }}
    </p>

    <div
      v-if="skill.tags.length > 0"
      class="flex flex-wrap gap-1 mb-3"
    >
      <UBadge
        v-for="tag in skill.tags"
        :key="tag"
        variant="subtle"
        :color="tag === 'official' ? 'primary' : 'neutral'"
        size="xs"
      >
        {{ tag }}
      </UBadge>
    </div>

    <div
      v-if="skill.requiresSecrets.length > 0"
      class="flex items-center gap-1 mb-3 text-xs text-dimmed"
    >
      <UIcon
        name="i-lucide-key-round"
        class="size-3 shrink-0"
      />
      <span>Requires: {{ skill.requiresSecrets.join(', ') }}</span>
    </div>

    <div class="flex items-center justify-between">
      <span
        v-if="skill.author"
        class="text-xs text-dimmed"
      >
        by {{ skill.author }}
      </span>
      <span v-else />

      <div class="flex items-center gap-1.5">
        <UButton
          size="xs"
          variant="ghost"
          color="neutral"
          icon="i-lucide-external-link"
          :to="`https://github.com/Patrity/cognova-skills/tree/main/${skill.name}`"
          target="_blank"
        >
          GitHub
        </UButton>
        <NuxtLink :to="`/skills/${skill.name}`">
          <UButton
            size="xs"
            variant="soft"
            color="neutral"
            icon="i-lucide-eye"
          >
            View
          </UButton>
        </NuxtLink>
        <UButton
          size="xs"
          icon="i-lucide-download"
          @click="emit('install', skill.name)"
        >
          Install
        </UButton>
      </div>
    </div>
  </div>
</template>
