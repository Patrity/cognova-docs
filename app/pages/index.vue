<script setup lang="ts">
useSeoMeta({
  titleTemplate: '',
  title: 'Cognova - Open Source AI Agent Platform with Encrypted Secret Management',
  ogTitle: 'Cognova - Open Source AI Agent Platform with Encrypted Secret Management',
  description: 'A self-hosted AI knowledge workspace with scheduled agents, document management, encrypted secrets, and extensible skills. A token-efficient open source AI platform.',
  ogDescription: 'A self-hosted AI knowledge workspace with scheduled agents, document management, encrypted secrets, and extensible skills. A token-efficient open source AI platform.'
})

defineOgImageComponent('Docs', {
  title: 'Cognova',
  description: 'Open Source AI Agent Platform with Encrypted Secret Management'
})

const features = [
  {
    title: 'AI Agents & Chat',
    description: 'Schedule cron-based agents for recurring workflows, use interactive streaming chat with full tool-calling support, and access an embedded Claude Code terminal.',
    icon: 'i-lucide-bot'
  },
  {
    title: 'Document Vault',
    description: 'WYSIWYG markdown editor with 20+ syntax highlighters, a full code editor, and public document sharing. Your knowledge, organized and accessible.',
    icon: 'i-lucide-file-text'
  },
  {
    title: 'Skills & Integrations',
    description: 'Connect Discord, Telegram, Slack, and any API through an extensible skills system. Supports standard Claude skills out of the box.',
    icon: 'i-lucide-puzzle'
  },
  {
    title: 'Encrypted Secrets',
    description: 'AES-256-GCM encryption with unique IVs per secret. API keys and credentials are never stored in plaintext — encrypted server-side before touching the database.',
    icon: 'i-lucide-shield-check'
  },
  {
    title: 'Open Source',
    description: 'Self-hostable, MIT licensed, and designed for full control. Run it on your infrastructure with no vendor lock-in and no data leaving your network.',
    icon: 'i-simple-icons-github'
  },
  {
    title: 'Token Efficient',
    description: 'Database-backed context with vector embeddings reduces token waste. Purpose-built architecture avoids the unbounded context accumulation that plagues other AI platforms.',
    icon: 'i-lucide-gauge'
  }
]

const aiFeatures = [
  {
    title: 'Scheduled Agents',
    description: 'Define cron-based agents that run autonomously on a schedule with cost tracking, budget limits, and real-time status monitoring.',
    icon: 'i-lucide-clock'
  },
  {
    title: 'Streaming Chat',
    description: 'Interactive conversations with Claude featuring full tool-calling support, session persistence, and per-conversation cost tracking.',
    icon: 'i-lucide-message-square'
  },
  {
    title: 'Extensible Skills',
    description: 'Build integrations for Discord, Telegram, Slack, and any API. Skills can be triggered by events, cron schedules, or direct invocation.',
    icon: 'i-lucide-plug'
  }
]

const docFeatures = [
  {
    title: 'Rich Editor',
    description: 'TipTap-powered WYSIWYG editor with syntax highlighting for 20+ programming languages and a dedicated code editor for non-markdown files.',
    icon: 'i-lucide-pen-tool'
  },
  {
    title: 'Public Sharing',
    description: 'Share any document via a unique link — use it as a secure pastebin or publish entire folders for collaboration.',
    icon: 'i-lucide-share-2'
  },
  {
    title: 'Obsidian Sync',
    description: 'Automatic vault synchronization from Obsidian. Upload and optionally share your notes without leaving your preferred editor.',
    icon: 'i-lucide-refresh-cw',
    comingSoon: true
  }
]

const statusQuoItems = [
  'API keys stored in plaintext JSON config files',
  'Credentials in known, accessible file paths',
  'Hardcoded secrets in community plugins',
  'Security audits revealing hundreds of vulnerabilities'
]

const cognovaSecurityItems = [
  'AES-256-GCM encryption for all secrets',
  'Unique random IV generated per secret',
  'Auth tags prevent tampering with stored values',
  'Secret values never exposed in API list operations'
]

const skillCards = [
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
    description: 'Every skill is reviewed before publishing. No malicious packages, no crypto-stealing malware, no supply chain attacks.',
    icon: 'i-lucide-shield'
  }
]

const dashboardStats = [
  { label: 'Documents', value: '147' },
  { label: 'Tasks', value: '23' },
  { label: 'Agents', value: '5' },
  { label: 'Token Usage', value: '1.2M' }
]

const recentActivity = [
  { text: 'Agent "daily-summary" completed', time: '2m ago', icon: 'i-lucide-check-circle', color: 'text-green-500' },
  { text: 'Document "api-guide.md" updated', time: '15m ago', icon: 'i-lucide-file-edit', color: 'text-blue-500' },
  { text: 'New task created from chat', time: '1h ago', icon: 'i-lucide-plus-circle', color: 'text-primary' }
]

const sidebarItems = [
  { label: 'Dashboard', icon: 'i-lucide-layout-dashboard', active: true },
  { label: 'Documents', icon: 'i-lucide-file-text', active: false },
  { label: 'Tasks', icon: 'i-lucide-check-square', active: false },
  { label: 'Chat', icon: 'i-lucide-message-circle', active: false },
  { label: 'Agents', icon: 'i-lucide-bot', active: false }
]
</script>

<template>
  <div class="relative">
    <!-- ============================================ -->
    <!-- SECTION 1: Hero                              -->
    <!-- ============================================ -->
    <UPageHero
      :links="[
        {
          label: 'Get Started',
          to: '/getting-started/installation',
          icon: 'i-lucide-rocket',
          size: 'xl' as const
        },
        {
          label: 'View on GitHub',
          to: 'https://github.com/patrity/cognova',
          target: '_blank',
          icon: 'i-simple-icons-github',
          color: 'neutral' as const,
          variant: 'subtle' as const,
          size: 'xl' as const
        }
      ]"
      :ui="{
        container: 'md:pt-18 lg:pt-24',
        title: 'max-w-4xl mx-auto',
        description: 'max-w-2xl mx-auto'
      }"
    >
      <template #top>
        <HeroBackground />
        <LazyStarsBg :star-count="500" />
      </template>

      <template #title>
        <span>Your </span>
        <span class="text-gradient">AI-Powered</span>
        <span> Knowledge Workspace</span>
      </template>

      <template #description>
        An open-source platform that unifies document management, AI agents, and encrypted secret management — so you can focus on building, not configuring.
      </template>

      <!-- Hero screenshot mock -->
      <UPageCard
        variant="subtle"
        class="rounded-xl mt-8"
      >
        <div class="rounded-lg overflow-hidden border border-default bg-default">
          <!-- Mock dashboard header -->
          <div class="flex items-center gap-3 px-4 py-3 border-b border-default bg-muted/30">
            <div class="flex gap-1.5">
              <div class="size-3 rounded-full bg-red-400" />
              <div class="size-3 rounded-full bg-yellow-400" />
              <div class="size-3 rounded-full bg-green-400" />
            </div>
            <div class="flex-1 flex items-center justify-center">
              <div class="bg-muted/50 rounded-md px-4 py-1 text-xs text-muted">
                cognova.local
              </div>
            </div>
          </div>
          <!-- Mock dashboard body -->
          <div class="flex min-h-[300px]">
            <!-- Sidebar -->
            <div class="w-48 border-r border-default p-3 space-y-2 hidden sm:block">
              <div
                v-for="item in sidebarItems"
                :key="item.label"
                class="flex items-center gap-2 px-2 py-1.5 rounded-md text-xs"
                :class="item.active ? 'bg-primary/10 text-primary font-medium' : 'text-muted'"
              >
                <UIcon
                  :name="item.icon"
                  class="size-3.5"
                />
                {{ item.label }}
              </div>
            </div>
            <!-- Main content -->
            <div class="flex-1 p-4 space-y-4">
              <div class="flex items-center justify-between">
                <span class="text-sm font-semibold">Overview</span>
                <UBadge
                  variant="subtle"
                  color="success"
                  size="xs"
                >
                  All systems online
                </UBadge>
              </div>
              <!-- Stats grid -->
              <div class="grid grid-cols-2 md:grid-cols-4 gap-3">
                <div
                  v-for="stat in dashboardStats"
                  :key="stat.label"
                  class="rounded-lg border border-default p-3"
                >
                  <div class="text-xs text-muted">
                    {{ stat.label }}
                  </div>
                  <div class="text-lg font-semibold mt-1">
                    {{ stat.value }}
                  </div>
                </div>
              </div>
              <!-- Recent activity -->
              <div class="space-y-2">
                <span class="text-xs text-muted font-medium">Recent Activity</span>
                <div
                  v-for="activity in recentActivity"
                  :key="activity.text"
                  class="flex items-center gap-2 text-xs text-muted"
                >
                  <UIcon
                    :name="activity.icon"
                    class="size-3.5 shrink-0"
                    :class="activity.color"
                  />
                  <span class="flex-1">{{ activity.text }}</span>
                  <span class="opacity-60">{{ activity.time }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </UPageCard>
    </UPageHero>

    <!-- ============================================ -->
    <!-- SECTION 2: Feature Highlights Grid           -->
    <!-- ============================================ -->
    <UPageSection
      headline="Features"
      title="Everything you need in one workspace"
      description="Cognova brings AI agents, document management, and encrypted secret management together in a single self-hosted platform — built for developers and power users who want full control."
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

    <USeparator :ui="{ border: 'border-primary/20' }" />

    <!-- ============================================ -->
    <!-- SECTION 3: AI Deep Dive                      -->
    <!-- ============================================ -->
    <UPageSection
      headline="Artificial Intelligence"
      title="AI that works for you, not against your budget"
      description="Purpose-built architecture uses database-backed context and vector embeddings instead of accumulating unbounded token history. Schedule agents, stream conversations, and extend capabilities through skills — all with transparent cost tracking."
      orientation="horizontal"
      :features="aiFeatures"
    >
      <LandingMockChatUI />
    </UPageSection>

    <USeparator :ui="{ border: 'border-primary/20' }" />

    <!-- ============================================ -->
    <!-- SECTION 4: Document Management               -->
    <!-- ============================================ -->
    <UPageSection
      headline="Knowledge Management"
      title="A vault for everything you know"
      description="Organize documents, code snippets, and notes in a markdown-first workspace with a rich editor, syntax highlighting, and instant public sharing."
      orientation="horizontal"
      reverse
      :features="docFeatures"
    >
      <LandingMockEditorUI />
    </UPageSection>

    <USeparator :ui="{ border: 'border-primary/20' }" />

    <!-- ============================================ -->
    <!-- SECTION 5: Security Comparison               -->
    <!-- ============================================ -->
    <UPageSection
      headline="Security"
      title="Secrets encrypted from day one"
      description="Other AI agent platforms store your API keys in plaintext JSON files, exposing credentials to supply chain vulnerabilities. Cognova encrypts all secrets with AES-256-GCM before they touch the database."
    >
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6 w-full">
        <!-- Status quo card -->
        <UPageCard
          title="The status quo"
          variant="subtle"
          :ui="{ title: 'text-muted' }"
        >
          <ul class="space-y-3">
            <li
              v-for="item in statusQuoItems"
              :key="item"
              class="flex items-start gap-2.5 text-sm text-muted"
            >
              <UIcon
                name="i-lucide-x"
                class="size-4 text-red-500 shrink-0 mt-0.5"
              />
              {{ item }}
            </li>
          </ul>
        </UPageCard>

        <!-- Cognova card -->
        <UPageCard
          title="The Cognova way"
          highlight
          highlight-color="primary"
          :ui="{ title: 'text-primary' }"
        >
          <ul class="space-y-3">
            <li
              v-for="item in cognovaSecurityItems"
              :key="item"
              class="flex items-start gap-2.5 text-sm"
            >
              <UIcon
                name="i-lucide-check"
                class="size-4 text-green-500 shrink-0 mt-0.5"
              />
              {{ item }}
            </li>
          </ul>
        </UPageCard>
      </div>
    </UPageSection>

    <USeparator :ui="{ border: 'border-primary/20' }" />

    <!-- ============================================ -->
    <!-- SECTION 6: Skills Repository (Coming Soon)   -->
    <!-- ============================================ -->
    <UPageSection
      title="A marketplace for superpowers"
      description="Share and discover community-built skills. Import with one click to extend Cognova with new integrations and capabilities."
      class="relative overflow-hidden"
    >
      <template #headline>
        <UBadge
          variant="subtle"
          size="sm"
        >
          Coming Soon
        </UBadge>
      </template>

      <UPageGrid>
        <UPageCard
          v-for="card in skillCards"
          :key="card.title"
          v-bind="card"
          spotlight
          spotlight-color="primary"
        />
      </UPageGrid>
    </UPageSection>

    <!-- ============================================ -->
    <!-- SECTION 7: Open Source CTA                   -->
    <!-- ============================================ -->
    <UPageCTA
      title="Open source. Self-hosted. Yours."
      description="Cognova is MIT-licensed and designed to run on your infrastructure. No vendor lock-in, no subscription fees, no data leaving your network."
      variant="subtle"
      :links="[
        {
          label: 'Get Started',
          to: '/getting-started/installation',
          icon: 'i-lucide-rocket',
          size: 'xl' as const
        },
        {
          label: 'Star on GitHub',
          to: 'https://github.com/patrity/cognova',
          target: '_blank',
          icon: 'i-lucide-star',
          color: 'neutral' as const,
          variant: 'subtle' as const,
          size: 'xl' as const
        },
        {
          label: 'Follow on X',
          to: 'https://x.com/patrity',
          target: '_blank',
          icon: 'i-simple-icons-x',
          color: 'neutral' as const,
          variant: 'ghost' as const,
          size: 'xl' as const
        }
      ]"
    >
      <LazyStarsBg />
    </UPageCTA>

    <!-- Built by -->
    <div class="text-center py-4 text-sm text-muted">
      Built by <NuxtLink
        to="https://techhivelabs.net"
        target="_blank"
        class="text-primary hover:underline"
      >
        TechHive Labs
      </NuxtLink>
    </div>
  </div>
</template>
