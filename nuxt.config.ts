// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  modules: [
    '@nuxt/eslint',
    '@nuxt/image',
    '@nuxt/ui',
    '@nuxtjs/seo',
    '@nuxt/content',
    'nuxt-llms',
    '@nuxtjs/mcp-toolkit'
  ],

  devtools: {
    enabled: true
  },

  app: {
    head: {
      link: [
        { rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg' },
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
      ]
    }
  },

  css: ['~/assets/css/main.css'],

  site: {
    url: 'https://cognova.dev',
    name: 'Cognova',
    description: 'An open-source AI-powered knowledge workspace with encrypted security, scheduled agents, and extensible skills.',
    defaultLocale: 'en'
  },

  content: {
    build: {
      markdown: {
        toc: {
          searchDepth: 1
        }
      }
    }
  },

  routeRules: {
    '/': { prerender: true },
    '/skills': { prerender: true },
    '/skills/**': { swr: 3600 },
    '/docs/**': { prerender: true }
  },

  experimental: {
    asyncContext: true
  },

  compatibilityDate: '2024-07-11',

  nitro: {
    prerender: {
      routes: [
        '/'
      ],
      crawlLinks: true,
      autoSubfolderIndex: false
    }
  },

  eslint: {
    config: {
      stylistic: {
        commaDangle: 'never',
        braceStyle: '1tbs'
      }
    }
  },

  icon: {
    provider: 'iconify'
  },

  llms: {
    domain: 'https://cognova.dev/',
    title: 'Cognova Documentation',
    description: 'Documentation for Cognova, an open-source AI-powered knowledge workspace with encrypted security, scheduled agents, and extensible skills.',
    full: {
      title: 'Cognova - Full Documentation',
      description: 'Complete documentation for Cognova including getting started, user guide, Claude integration, API reference, and architecture.'
    },
    sections: [
      {
        title: 'Getting Started',
        contentCollection: 'docs',
        contentFilters: [
          { field: 'path', operator: 'LIKE', value: '/docs/getting-started%' }
        ]
      },
      {
        title: 'User Guide',
        contentCollection: 'docs',
        contentFilters: [
          { field: 'path', operator: 'LIKE', value: '/docs/guide%' }
        ]
      },
      {
        title: 'Claude Integration',
        contentCollection: 'docs',
        contentFilters: [
          { field: 'path', operator: 'LIKE', value: '/docs/claude%' }
        ]
      },
      {
        title: 'API Reference',
        contentCollection: 'docs',
        contentFilters: [
          { field: 'path', operator: 'LIKE', value: '/docs/api%' }
        ]
      }
    ]
  },

  mcp: {
    name: 'Cognova Docs'
  },

  ogImage: {
    defaults: {
      component: 'Docs',
      width: 1200,
      height: 600
    }
  }
})
