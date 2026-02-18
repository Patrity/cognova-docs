import { defineContentConfig, defineCollection, z } from '@nuxt/content'

const docsSchema = z.object({
  title: z.string(),
  description: z.string().optional(),
  status: z.enum(['complete', 'planned', 'in-progress', 'deprecated']).default('complete'),
  navigation: z.object({
    icon: z.string().optional()
  }).optional()
})

export default defineContentConfig({
  collections: {
    landing: defineCollection({
      type: 'page',
      source: 'index.md',
      schema: docsSchema
    }),
    docs: defineCollection({
      type: 'page',
      source: '**/*.md',
      schema: docsSchema
    })
  }
})
