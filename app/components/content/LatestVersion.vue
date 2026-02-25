<script setup lang="ts">
const props = defineProps<{
  repo: string
}>()

const { data: version } = await useFetch(
  `https://api.github.com/repos/${props.repo}/releases/latest`,
  {
    key: `github-version-${props.repo}`,
    transform: (data: { tag_name: string }) => data.tag_name?.replace(/^v/, '') || '',
    getCachedData: (key, nuxtApp) => nuxtApp.payload.data[key] || nuxtApp.static.data[key]
  }
)
</script>

<template>
  <strong>{{ version || 'latest' }}</strong>
</template>
