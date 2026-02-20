<script setup lang="ts">
const props = defineProps<{
  skillName: string
}>()

const open = defineModel<boolean>('open', { default: false })

const cognovaUrl = useCognovaUrl()
const urlInput = ref(cognovaUrl.value || '')
const error = ref('')

function handleInstall() {
  const url = urlInput.value.trim()

  if (!url) {
    error.value = 'Please enter your Cognova URL'
    return
  }

  if (!url.startsWith('http://') && !url.startsWith('https://')) {
    error.value = 'URL must start with http:// or https://'
    return
  }

  // Save to cookie
  cognovaUrl.value = url.replace(/\/+$/, '')
  error.value = ''

  // Redirect to install
  const installUrl = `${cognovaUrl.value}/skills/library?install=${encodeURIComponent(props.skillName)}`
  navigateTo(installUrl, { external: true })
}
</script>

<template>
  <UModal v-model:open="open">
    <template #content>
      <UCard>
        <template #header>
          <div class="flex items-center gap-2">
            <UIcon
              name="i-lucide-download"
              class="size-5 text-primary"
            />
            <span class="font-semibold">Install {{ skillName }}</span>
          </div>
        </template>

        <div class="space-y-4">
          <p class="text-sm text-muted">
            Enter the URL of your Cognova instance to install this skill. We'll redirect you to complete the installation.
          </p>

          <div>
            <label class="text-sm font-medium mb-1.5 block">Cognova URL</label>
            <UInput
              v-model="urlInput"
              placeholder="http://localhost:3002"
              size="lg"
              :color="error ? 'error' : undefined"
              @keyup.enter="handleInstall"
            />
            <p
              v-if="error"
              class="text-xs text-error mt-1"
            >
              {{ error }}
            </p>
          </div>

          <p class="text-xs text-dimmed">
            Your URL is saved locally so you won't need to enter it again.
          </p>
        </div>

        <template #footer>
          <div class="flex justify-end gap-2">
            <UButton
              color="neutral"
              variant="ghost"
              @click="open = false"
            >
              Cancel
            </UButton>
            <UButton
              icon="i-lucide-download"
              @click="handleInstall"
            >
              Install
            </UButton>
          </div>
        </template>
      </UCard>
    </template>
  </UModal>
</template>
