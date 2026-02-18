<script lang="ts" setup>
const props = withDefaults(defineProps<{ title?: string, description?: string, headline?: string }>(), {
  title: 'Cognova',
  description: 'Open Source AI Agent Platform'
})

const title = computed(() => (props.title || '').slice(0, 60))
const description = computed(() => (props.description || '').slice(0, 200))
</script>

<template>
  <div class="w-full h-full flex flex-col justify-between bg-[#1c1917] p-[60px]">
    <!-- Decorative gradient blob -->
    <svg
      class="absolute right-0 top-0"
      width="629"
      height="593"
      viewBox="0 0 629 593"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
    >
      <g filter="url(#filter0_f_og)">
        <path
          d="M628.5 -578L639.334 -94.4223L806.598 -548.281L659.827 -87.387L965.396 -462.344L676.925 -74.0787L1087.69 -329.501L688.776 -55.9396L1160.22 -164.149L694.095 -34.9354L1175.13 15.7948L692.306 -13.3422L1130.8 190.83L683.602 6.50012L1032.04 341.989L668.927 22.4412L889.557 452.891L649.872 32.7537L718.78 511.519L628.5 36.32L538.22 511.519L607.128 32.7537L367.443 452.891L588.073 22.4412L224.955 341.989L573.398 6.50012L126.198 190.83L564.694 -13.3422L81.8734 15.7948L562.905 -34.9354L96.7839 -164.149L568.224 -55.9396L169.314 -329.501L580.075 -74.0787L291.604 -462.344L597.173 -87.387L450.402 -548.281L617.666 -94.4223L628.5 -578Z"
          fill="#f97316"
        />
      </g>
      <defs>
        <filter
          id="filter0_f_og"
          x="0.873535"
          y="-659"
          width="1255.25"
          height="1251.52"
          filterUnits="userSpaceOnUse"
          color-interpolation-filters="sRGB"
        >
          <feFlood
            flood-opacity="0"
            result="BackgroundImageFix"
          />
          <feBlend
            mode="normal"
            in="SourceGraphic"
            in2="BackgroundImageFix"
            result="shape"
          />
          <feGaussianBlur
            stdDeviation="40.5"
            result="effect1_foregroundBlur_og"
          />
        </filter>
      </defs>
    </svg>

    <!-- Content -->
    <div class="flex flex-col flex-1 justify-center">
      <p
        v-if="headline"
        class="uppercase text-[24px] text-[#f97316] mb-4 font-semibold"
      >
        {{ headline }}
      </p>
      <h1
        v-if="title"
        class="m-0 text-[72px] font-bold mb-4 text-white leading-tight"
      >
        {{ title }}
      </h1>
      <p
        v-if="description"
        class="text-[30px] text-[#a8a29e] leading-snug w-[700px]"
      >
        {{ description }}
      </p>
    </div>

    <!-- Footer branding -->
    <div class="flex items-center justify-between">
      <div class="flex items-center gap-3">
        <svg
          width="28"
          height="28"
          viewBox="0 0 24 24"
          fill="none"
          stroke="#f97316"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <path d="M12 5a3 3 0 1 0-5.997.125 4 4 0 0 0-2.526 5.77 4 4 0 0 0 .556 6.588A4 4 0 1 0 12 18Z" />
          <path d="M12 5a3 3 0 1 1 5.997.125 4 4 0 0 1 2.526 5.77 4 4 0 0 1-.556 6.588A4 4 0 1 1 12 18Z" />
          <path d="M15 13a4.5 4.5 0 0 1-3-4 4.5 4.5 0 0 1-3 4" />
        </svg>
        <span class="text-[24px] font-semibold text-white">cognova</span>
      </div>
      <span class="text-[20px] text-[#a8a29e]">cognova.dev</span>
    </div>
  </div>
</template>
