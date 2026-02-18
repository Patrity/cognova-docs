<script setup lang="ts">
const props = defineProps<{
  repo: string
}>()

const { data: version } = await useFetch<{ tag_name: string }>(
  `https://api.github.com/repos/${props.repo}/releases/latest`,
  {
    key: `github-version-${props.repo}`,
    transform: data => data.tag_name?.replace(/^v/, ''),
    getCachedData: (key, nuxtApp) => nuxtApp.payload.data[key] || nuxtApp.static.data[key]
  }
)
</script>

<template>
  <strong>{{ version || 'latest' }}</strong>
</template>
