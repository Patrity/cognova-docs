<script setup lang="ts">
useSeoMeta({
  title: 'Skills Repository - Cognova',
  ogTitle: 'Skills Repository - Cognova',
  description: 'Discover, share, and install community-built skills for Cognova. Extend your AI workspace with integrations for Discord, Telegram, Slack, and more.',
  ogDescription: 'Discover, share, and install community-built skills for Cognova. Extend your AI workspace with integrations for Discord, Telegram, Slack, and more.'
})

defineOgImageComponent('Docs', {
  headline: 'Coming Soon',
  title: 'Skills Repository',
  description: 'Discover, share, and install community-built skills for Cognova.'
})

const features = [
  {
    title: 'Share Skills',
    description: 'Publish your custom integrations and automations for the community to discover and use.',
    icon: 'i-lucide-upload'
  },
  {
    title: 'One-Click Import',
    description: 'Browse community skills and install them instantly — no config files to edit, no CLI commands to memorize.',
    icon: 'i-lucide-download'
  },
  {
    title: 'Curated & Safe',
    description: 'Every skill is reviewed before publishing. No malicious packages, no supply chain attacks.',
    icon: 'i-lucide-shield'
  },
  {
    title: 'Built-in Integrations',
    description: 'Connect Discord, Telegram, Slack, and any API through an extensible skills system with standard Claude skills support.',
    icon: 'i-lucide-plug'
  },
  {
    title: 'Event-Driven',
    description: 'Skills can be triggered by events, cron schedules, or direct invocation from chat conversations.',
    icon: 'i-lucide-zap'
  },
  {
    title: 'Open Source',
    description: 'All skills are open source. Read the code, fork it, customize it, and contribute back to the community.',
    icon: 'i-simple-icons-github'
  }
]
</script>

<template>
  <div class="relative">
    <UPageHero
      :ui="{
        container: 'md:pt-18 lg:pt-24'
      }"
    >
      <template #top>
        <HeroBackground />
      </template>

      <template #headline>
        <UBadge
          variant="subtle"
          size="lg"
        >
          Coming Soon
        </UBadge>
      </template>

      <template #title>
        <span>Skills </span>
        <span class="text-gradient">Repository</span>
      </template>

      <template #description>
        A curated marketplace for community-built skills. Share your integrations, discover new capabilities, and extend Cognova with one click.
      </template>

      <template #links>
        <UButton
          label="Star on GitHub"
          to="https://github.com/patrity/cognova"
          target="_blank"
          icon="i-lucide-star"
          size="xl"
          color="neutral"
          variant="subtle"
        />
        <UButton
          label="Back to Docs"
          to="/getting-started/installation"
          icon="i-lucide-arrow-left"
          size="xl"
          variant="ghost"
        />
      </template>
    </UPageHero>

    <UPageSection
      headline="What to expect"
      title="Everything you need to extend Cognova"
      description="The skills repository will be a curated marketplace where you can discover, share, and install integrations with a single click."
    >
      <UPageGrid>
        <UPageCard
          v-for="card in features"
          :key="card.title"
          v-bind="card"
          spotlight
          spotlight-color="primary"
        />
      </UPageGrid>
    </UPageSection>

    <UPageSection>
      <div class="max-w-xl mx-auto text-center space-y-6">
        <UIcon
          name="i-lucide-bell"
          class="size-10 text-primary"
        />
        <h2 class="text-2xl font-semibold">
          Stay in the loop
        </h2>
        <p class="text-muted text-lg">
          The skills repository is under active development. Star the project on GitHub to get notified when it launches.
        </p>
        <UButton
          label="Watch on GitHub"
          to="https://github.com/patrity/cognova"
          target="_blank"
          icon="i-simple-icons-github"
          size="xl"
        />
      </div>
    </UPageSection>
  </div>
</template>
