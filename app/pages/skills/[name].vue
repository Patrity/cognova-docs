<script setup lang="ts">
import type { CatalogSkill } from '~/components/skills/CatalogCard.vue'

const REGISTRY_URL = 'https://raw.githubusercontent.com/Patrity/cognova-skills/main/registry.json'
const RAW_BASE = 'https://raw.githubusercontent.com/Patrity/cognova-skills/main'

const route = useRoute()
const skillName = computed(() => route.params.name as string)

const skill = ref<CatalogSkill | null>(null)
const loading = ref(true)
const selectedFile = ref('')
const fileContent = ref('')
const fileLoading = ref(false)
const installOpen = ref(false)

useSeoMeta({
  title: () => skill.value ? `${skill.value.name} - Skills - Cognova` : 'Skill - Cognova',
  ogTitle: () => skill.value ? `${skill.value.name} - Cognova Skills` : 'Skill - Cognova',
  description: () => skill.value?.description || '',
  ogDescription: () => skill.value?.description || ''
})

defineOgImageComponent('Docs', {
  headline: 'Skill',
  title: skillName.value,
  description: 'Community skill for Cognova'
})

async function loadSkill() {
  loading.value = true
  try {
    const registry = await $fetch<CatalogSkill[]>(REGISTRY_URL)
    skill.value = registry.find(s => s.name === skillName.value) || null

    if (skill.value?.files.length) {
      const defaultFile = skill.value.files.find(f => f === 'SKILL.md') || skill.value.files[0]
      await selectFile(defaultFile)
    }
  } catch {
    skill.value = null
  } finally {
    loading.value = false
  }
}

async function selectFile(file: string) {
  selectedFile.value = file
  fileLoading.value = true
  try {
    const url = `${RAW_BASE}/${skillName.value}/${file}`
    fileContent.value = await $fetch<string>(url, { responseType: 'text' })
  } catch {
    fileContent.value = '// Failed to load file'
  } finally {
    fileLoading.value = false
  }
}

onMounted(() => loadSkill())
</script>

<template>
  <div class="min-h-[calc(100vh-64px)]">
    <!-- Loading -->
    <div
      v-if="loading"
      class="flex items-center justify-center py-24"
    >
      <UIcon
        name="i-lucide-loader-2"
        class="size-6 animate-spin text-dimmed"
      />
    </div>

    <!-- Not found -->
    <div
      v-else-if="!skill"
      class="flex flex-col items-center justify-center py-24 text-dimmed"
    >
      <UIcon
        name="i-lucide-package-x"
        class="size-12 mb-4"
      />
      <p class="text-lg font-medium">
        Skill not found
      </p>
      <NuxtLink
        to="/skills"
        class="mt-4"
      >
        <UButton
          variant="soft"
          icon="i-lucide-arrow-left"
        >
          Back to Skills
        </UButton>
      </NuxtLink>
    </div>

    <!-- Skill detail -->
    <div
      v-else
      class="flex flex-col"
    >
      <!-- Header -->
      <div class="border-b border-default px-4 sm:px-6 py-4">
        <div class="max-w-7xl mx-auto flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          <div class="flex items-center gap-3 min-w-0">
            <NuxtLink to="/skills">
              <UButton
                icon="i-lucide-arrow-left"
                variant="ghost"
                color="neutral"
                size="sm"
              />
            </NuxtLink>
            <UIcon
              name="i-lucide-puzzle"
              class="size-5 text-primary shrink-0"
            />
            <h1 class="text-lg font-semibold truncate">
              {{ skill.name }}
            </h1>
            <UBadge
              variant="subtle"
              color="neutral"
              size="sm"
            >
              v{{ skill.version }}
            </UBadge>
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

          <div class="flex items-center gap-2">
            <span
              v-if="skill.author"
              class="text-sm text-muted hidden sm:block"
            >
              by {{ skill.author }}
            </span>
            <UButton
              size="sm"
              variant="ghost"
              color="neutral"
              icon="i-lucide-external-link"
              :to="`https://github.com/Patrity/cognova-skills/tree/main/${skill.name}`"
              target="_blank"
            >
              GitHub
            </UButton>
            <UButton
              size="sm"
              icon="i-lucide-download"
              @click="installOpen = true"
            >
              Install
            </UButton>
          </div>
        </div>

        <p
          v-if="skill.description"
          class="max-w-7xl mx-auto text-sm text-muted mt-2 pl-11"
        >
          {{ skill.description }}
        </p>
      </div>

      <!-- Two-panel layout -->
      <div class="flex flex-1 max-w-7xl mx-auto w-full">
        <!-- File tree sidebar -->
        <div class="w-48 shrink-0 border-r border-default hidden md:block overflow-auto">
          <div class="p-2 text-xs font-medium text-dimmed uppercase tracking-wide">
            Files
          </div>
          <SkillsReadOnlyTree
            :files="skill.files"
            :selected-path="selectedFile"
            @select="selectFile"
          />
        </div>

        <!-- Mobile file select -->
        <div class="md:hidden border-b border-default px-4 py-2 w-full">
          <select
            :value="selectedFile"
            class="w-full bg-default border border-default rounded px-3 py-1.5 text-sm"
            @change="selectFile(($event.target as HTMLSelectElement).value)"
          >
            <option
              v-for="file in skill.files"
              :key="file"
              :value="file"
            >
              {{ file }}
            </option>
          </select>
        </div>

        <!-- Code viewer -->
        <div class="flex-1 min-w-0">
          <div class="flex items-center gap-2 px-4 py-2 border-b border-default text-sm text-muted">
            <UIcon
              name="i-lucide-file-code"
              class="size-4"
            />
            <span>{{ selectedFile }}</span>
          </div>

          <div
            v-if="fileLoading"
            class="flex items-center justify-center py-24"
          >
            <UIcon
              name="i-lucide-loader-2"
              class="size-6 animate-spin text-dimmed"
            />
          </div>

          <ClientOnly v-else>
            <SkillsCodeViewer
              :content="fileContent"
              :filename="selectedFile"
            />
          </ClientOnly>
        </div>
      </div>
    </div>

    <SkillsInstallModal
      v-model:open="installOpen"
      :skill-name="skillName"
    />
  </div>
</template>
