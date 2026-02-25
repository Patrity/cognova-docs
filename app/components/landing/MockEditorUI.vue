<template>
  <div class="w-full max-w-lg rounded-xl border border-default overflow-hidden bg-default shadow-2xl">
    <!-- Title bar -->
    <div class="flex items-center gap-2 px-4 py-3 border-b border-default bg-muted/50">
      <div class="flex gap-1.5">
        <div class="size-3 rounded-full bg-red-400" />
        <div class="size-3 rounded-full bg-yellow-400" />
        <div class="size-3 rounded-full bg-green-400" />
      </div>
      <span class="text-xs text-muted font-medium ml-2">project-notes.md</span>
      <div class="ml-auto flex items-center gap-2">
        <UBadge
          variant="subtle"
          color="success"
          size="xs"
        >
          Saved
        </UBadge>
        <UBadge
          variant="subtle"
          size="xs"
        >
          Shared
        </UBadge>
      </div>
    </div>

    <!-- Editor toolbar -->
    <div class="flex items-center gap-1 px-3 py-2 border-b border-default bg-muted/30">
      <div
        v-for="icon in toolbarIcons"
        :key="icon"
        class="p-1.5 rounded hover:bg-muted/50 text-muted"
      >
        <UIcon
          :name="icon"
          class="size-3.5"
        />
      </div>
      <div class="w-px h-4 bg-default mx-1" />
      <div
        v-for="icon in formatIcons"
        :key="icon"
        class="p-1.5 rounded hover:bg-muted/50 text-muted"
      >
        <UIcon
          :name="icon"
          class="size-3.5"
        />
      </div>
    </div>

    <!-- Editor content -->
    <div class="p-5 space-y-3 min-h-[260px] text-sm">
      <h3 class="text-lg font-semibold">
        API Integration Guide
      </h3>
      <p class="text-muted leading-relaxed">
        This document covers the setup process for connecting external services through the skills system. Each skill defines...
      </p>

      <!-- Code block mock -->
      <div class="rounded-lg bg-muted/50 border border-default p-3 font-mono text-xs">
        <div class="flex items-center gap-2 mb-2">
          <span class="text-primary">typescript</span>
          <div class="ml-auto text-muted">
            <UIcon
              name="i-lucide-copy"
              class="size-3.5"
            />
          </div>
        </div>
        <div class="space-y-0.5 text-muted">
          <div>
            <span class="text-blue-400">const</span>
            <span> skill = </span>
            <span class="text-green-400">defineSkill</span>
            <span>({</span>
          </div>
          <div class="pl-4">
            <span class="text-primary">name</span>
            <span>: </span>
            <span class="text-yellow-500">'slack-notify'</span>
            <span>,</span>
          </div>
          <div class="pl-4">
            <span class="text-primary">trigger</span>
            <span>: </span>
            <span class="text-yellow-500">'on-task-complete'</span>
          </div>
          <div>})</div>
        </div>
      </div>

      <p class="text-muted leading-relaxed">
        Skills can be triggered by events, scheduled via cron, or invoked directly from chat...
      </p>
    </div>
  </div>
</template>

<script setup lang="ts">
const toolbarIcons = [
  'i-lucide-heading-1',
  'i-lucide-heading-2',
  'i-lucide-heading-3',
  'i-lucide-list',
  'i-lucide-list-ordered'
]

const formatIcons = [
  'i-lucide-bold',
  'i-lucide-italic',
  'i-lucide-code',
  'i-lucide-link'
]
</script>
