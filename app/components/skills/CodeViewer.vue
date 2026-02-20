<script setup lang="ts">
import { Codemirror } from 'vue-codemirror'
import { EditorView } from '@codemirror/view'
import { python } from '@codemirror/lang-python'
import { markdown } from '@codemirror/lang-markdown'
import { json } from '@codemirror/lang-json'
import { javascript } from '@codemirror/lang-javascript'
import { yaml } from '@codemirror/lang-yaml'
import { oneDark } from '@codemirror/theme-one-dark'

const props = defineProps<{
  content: string
  filename: string
}>()

const colorMode = useColorMode()

const extensions = computed(() => {
  const ext = props.filename.split('.').pop()?.toLowerCase()
  const exts = [EditorView.editable.of(false)]

  if (colorMode.value === 'dark') {
    exts.push(oneDark)
  }

  if (ext === 'py') exts.push(python())
  else if (ext === 'md') exts.push(markdown())
  else if (ext === 'json') exts.push(json())
  else if (ext === 'ts' || ext === 'js') exts.push(javascript())
  else if (ext === 'yaml' || ext === 'yml') exts.push(yaml())

  return exts
})
</script>

<template>
  <Codemirror
    :model-value="content"
    :extensions="extensions"
    :style="{ height: '100%' }"
  />
</template>
