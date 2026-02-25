import { defineContentConfig, defineCollection, z } from '@nuxt/content'

const docsSchema = z.object({
  title: z.string(),
  description: z.string().optional(),
  status: z.enum(['complete', 'planned', 'in-progress', 'deprecated']).default('complete'),
  links: z.array(z.record(z.string(), z.unknown())).optional(),
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
      source: {
        include: '**/*.md',
        exclude: ['index.md'],
        prefix: 'docs'
      },
      schema: docsSchema
    })
  }
})
