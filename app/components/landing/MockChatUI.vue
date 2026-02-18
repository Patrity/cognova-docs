<template>
  <div class="w-full max-w-lg rounded-xl border border-default overflow-hidden bg-default shadow-2xl">
    <!-- Title bar -->
    <div class="flex items-center gap-2 px-4 py-3 border-b border-default bg-muted/50">
      <div class="flex gap-1.5">
        <div class="size-3 rounded-full bg-red-400" />
        <div class="size-3 rounded-full bg-yellow-400" />
        <div class="size-3 rounded-full bg-green-400" />
      </div>
      <span class="text-xs text-muted font-medium ml-2">Cognova Chat</span>
      <div class="ml-auto flex items-center gap-1.5">
        <div class="size-2 rounded-full bg-green-500 animate-pulse" />
        <span class="text-xs text-muted">Connected</span>
      </div>
    </div>

    <!-- Chat messages -->
    <div class="p-4 space-y-4 min-h-[280px]">
      <!-- User message -->
      <div class="flex justify-end">
        <div class="bg-primary/10 text-sm rounded-2xl rounded-br-md px-4 py-2.5 max-w-[80%]">
          Summarize the latest project updates and create tasks for anything that's overdue.
        </div>
      </div>

      <!-- AI message -->
      <div class="flex gap-3">
        <div class="shrink-0 size-7 rounded-full bg-primary/20 flex items-center justify-center">
          <UIcon
            name="i-lucide-bot"
            class="size-4 text-primary"
          />
        </div>
        <div class="space-y-2 text-sm">
          <div class="bg-muted/50 rounded-2xl rounded-bl-md px-4 py-2.5">
            <p>I found 3 overdue items. Here's what I've done:</p>
            <ul class="mt-2 space-y-1 text-muted">
              <li class="flex items-center gap-1.5">
                <UIcon
                  name="i-lucide-check-circle"
                  class="size-3.5 text-green-500 shrink-0"
                />
                Created task: "Update API docs"
              </li>
              <li class="flex items-center gap-1.5">
                <UIcon
                  name="i-lucide-check-circle"
                  class="size-3.5 text-green-500 shrink-0"
                />
                Created task: "Fix auth middleware"
              </li>
              <li class="flex items-center gap-1.5">
                <UIcon
                  name="i-lucide-check-circle"
                  class="size-3.5 text-green-500 shrink-0"
                />
                Created task: "Deploy staging"
              </li>
            </ul>
          </div>
          <div class="flex gap-2">
            <UBadge
              variant="subtle"
              size="xs"
            >
              3 tasks created
            </UBadge>
            <UBadge
              variant="subtle"
              color="neutral"
              size="xs"
            >
              0.02$ cost
            </UBadge>
          </div>
        </div>
      </div>
    </div>

    <!-- Input bar -->
    <div class="px-4 pb-4">
      <div class="flex items-center gap-2 rounded-xl border border-default px-3 py-2.5 bg-muted/30">
        <span class="text-sm text-muted flex-1">Ask anything...</span>
        <div class="size-7 rounded-lg bg-primary flex items-center justify-center">
          <UIcon
            name="i-lucide-arrow-up"
            class="size-4 text-white"
          />
        </div>
      </div>
    </div>
  </div>
</template>
