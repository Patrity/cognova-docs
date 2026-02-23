<script setup lang="ts">
import type { CatalogSkill } from '~/components/skills/CatalogCard.vue'

const REGISTRY_URL = 'https://raw.githubusercontent.com/Patrity/cognova-skills/main/registry.json'

useSeoMeta({
  title: 'Skills Repository - Cognova',
  ogTitle: 'Skills Repository - Cognova',
  description: 'Discover, share, and install community-built skills for Cognova. Extend your AI workspace with integrations for Discord, Telegram, Slack, and more.',
  ogDescription: 'Discover, share, and install community-built skills for Cognova. Extend your AI workspace with integrations for Discord, Telegram, Slack, and more.'
})

defineOgImage({
  component: 'Docs',
  headline: 'Skills',
  title: 'Skills Repository',
  description: 'Discover, share, and install community-built skills for Cognova.'
})

const skills = ref<CatalogSkill[]>([])
const loading = ref(true)
const search = ref('')
const activeTag = ref<string | null>(null)
const installTarget = ref('')
const installOpen = ref(false)

const allTags = computed(() => {
  const tagSet = new Set<string>()
  for (const s of skills.value) {
    for (const t of s.tags) tagSet.add(t)
  }
  return [...tagSet].sort()
})

const filteredSkills = computed(() => {
  let result = skills.value

  if (activeTag.value) {
    result = result.filter(s => s.tags.includes(activeTag.value!))
  }

  if (search.value.trim()) {
    const q = search.value.toLowerCase()
    result = result.filter(s =>
      s.name.toLowerCase().includes(q)
      || s.description.toLowerCase().includes(q)
      || s.author.toLowerCase().includes(q)
    )
  }

  return result
})

function toggleTag(tag: string) {
  activeTag.value = activeTag.value === tag ? null : tag
}

function handleInstall(name: string) {
  installTarget.value = name
  installOpen.value = true
}

async function loadRegistry() {
  loading.value = true
  try {
    skills.value = await $fetch<CatalogSkill[]>(REGISTRY_URL)
  } catch {
    skills.value = []
  } finally {
    loading.value = false
  }
}

onMounted(() => loadRegistry())
</script>

<template>
  <div>
    <UPageHero
      :ui="{
        container: 'md:pt-18 lg:pt-24'
      }"
    >
      <template #top>
        <HeroBackground />
      </template>

      <template #title>
        <span>Skills </span>
        <span class="text-gradient">Repository</span>
      </template>

      <template #description>
        Discover, share, and install community-built skills. Extend Cognova with integrations, automations, and new capabilities.
      </template>
    </UPageHero>

    <UPageSection>
      <div class="space-y-4">
        <!-- Search + filter bar -->
        <div class="flex flex-col sm:flex-row gap-3">
          <UInput
            v-model="search"
            icon="i-lucide-search"
            placeholder="Search skills..."
            size="lg"
            class="flex-1"
          />
          <div
            v-if="allTags.length > 0 && !loading"
            class="flex flex-wrap gap-1.5 items-center"
          >
            <UButton
              v-for="tag in allTags"
              :key="tag"
              size="xs"
              :variant="activeTag === tag ? 'solid' : 'outline'"
              :color="tag === 'official' ? 'primary' : 'neutral'"
              @click="toggleTag(tag)"
            >
              {{ tag }}
            </UButton>
          </div>
        </div>

        <!-- Loading -->
        <div
          v-if="loading"
          class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3"
        >
          <div
            v-for="i in 6"
            :key="i"
            class="p-4 rounded-lg border border-default bg-elevated/50"
          >
            <USkeleton class="h-4 w-24 mb-2" />
            <USkeleton class="h-3 w-full mb-1" />
            <USkeleton class="h-3 w-2/3" />
          </div>
        </div>

        <!-- Empty -->
        <div
          v-else-if="skills.length === 0"
          class="flex flex-col items-center justify-center py-16 text-dimmed"
        >
          <UIcon
            name="i-lucide-library"
            class="size-12 mb-4"
          />
          <p class="text-lg font-medium">
            No community skills available yet
          </p>
          <p class="text-sm mt-1">
            The skills registry is empty or hasn't synced yet.
          </p>
        </div>

        <!-- No results -->
        <div
          v-else-if="filteredSkills.length === 0"
          class="text-center py-12 text-muted text-sm"
        >
          No skills matching your search
        </div>

        <!-- Grid -->
        <div
          v-else
          class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3"
        >
          <SkillsCatalogCard
            v-for="skill in filteredSkills"
            :key="skill.name"
            :skill="skill"
            @install="handleInstall"
          />
        </div>
      </div>
    </UPageSection>

    <SkillsInstallModal
      v-model:open="installOpen"
      :skill-name="installTarget"
    />
  </div>
</template>
