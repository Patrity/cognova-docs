<script setup lang="ts">
import type { ContentNavigationItem } from '@nuxt/content'

const navigation = inject<Ref<ContentNavigationItem[]>>('navigation')

const { header } = useAppConfig()

const { data: version } = await useFetch<string>(
  'https://api.github.com/repos/patrity/cognova/releases/latest',
  {
    key: 'cognova-version',
    transform: data => (data as unknown as { tag_name: string }).tag_name?.replace(/^v/, '') || '0.1.0',
    getCachedData: (key, nuxtApp) => nuxtApp.payload.data[key] || nuxtApp.static.data[key],
    default: () => '0.1.0'
  }
)
</script>

<template>
  <UHeader
    :ui="{ center: 'flex-1' }"
    :to="header?.to || '/'"
  >
    <UContentSearchButton
      v-if="header?.search"
      :collapsed="false"
      class="w-full"
    />

    <template
      v-if="header?.logo?.dark || header?.logo?.light || header?.title"
      #title
    >
      <UColorModeImage
        v-if="header?.logo?.dark || header?.logo?.light"
        :light="header?.logo?.light!"
        :dark="header?.logo?.dark!"
        :alt="header?.logo?.alt"
        class="h-6 w-auto shrink-0"
      />

      <span v-else-if="header?.title">
        {{ header.title }}
      </span>
    </template>

    <template
      v-else
      #left
    >
      <NuxtLink
        :to="header?.to || '/'"
        class="flex items-center gap-2"
      >
        <AppLogo class="w-auto h-10" />
        <UBadge
          variant="subtle"
          size="sm"
        >
          v{{ version }}
        </UBadge>
      </NuxtLink>
    </template>

    <template #right>
      <UContentSearchButton
        v-if="header?.search"
        class="lg:hidden"
      />

      <UColorModeButton v-if="header?.colorMode" />

      <template v-if="header?.links">
        <UButton
          v-for="(link, index) of header.links"
          :key="index"
          v-bind="{ color: 'neutral', variant: 'ghost', ...link }"
        />
      </template>
    </template>

    <template #body>
      <UContentNavigation
        highlight
        :navigation="navigation"
      />
    </template>
  </UHeader>
</template>
