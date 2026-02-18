export default defineAppConfig({
  ui: {
    colors: {
      primary: 'orange',
      neutral: 'stone'
    }
  },
  seo: {
    siteName: 'Cognova Docs'
  },
  header: {
    title: '',
    to: '/',
    logo: {
      alt: '',
      light: '',
      dark: ''
    },
    search: true,
    colorMode: true,
    links: [{
      'icon': 'i-simple-icons-github',
      'to': 'https://github.com/patrity/cognova',
      'target': '_blank',
      'aria-label': 'GitHub'
    }]
  },
  footer: {
    credits: `© ${new Date().getFullYear()} Cognova. Open source under MIT.`,
    colorMode: false,
    links: [{
      'icon': 'i-simple-icons-github',
      'to': 'https://github.com/patrity/cognova',
      'target': '_blank',
      'aria-label': 'Cognova on GitHub'
    }]
  },
  toc: {
    title: 'Table of Contents',
    bottom: {
      title: 'Community',
      edit: 'https://github.com/patrity/cognova-docs/edit/main/content',
      links: [{
        icon: 'i-lucide-star',
        label: 'Star on GitHub',
        to: 'https://github.com/patrity/cognova',
        target: '_blank'
      }, {
        icon: 'i-lucide-book-open',
        label: 'Cognova Docs',
        to: 'https://cognova.dev',
        target: '_blank'
      }]
    }
  }
})
