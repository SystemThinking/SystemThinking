import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

const config: Config = {
  title: 'Systémové myslenie',
  tagline: 'Roman Kazička',
  url: 'https://systemthinking.sk',
  baseUrl: '/',
  favicon: 'img/favicon.ico',

  organizationName: 'SystemThinking',
  projectName: 'SystemThinking',
  deploymentBranch: 'gh-pages',
  onBrokenLinks: 'warn',
  onBrokenMarkdownLinks: 'warn',
  future: {v4: true},

  headTags: [
    {
      tagName: 'link',
      attributes: {rel: 'preconnect', href: 'https://fonts.googleapis.com'},
    },
    {
      tagName: 'link',
      attributes: {
        rel: 'stylesheet',
        href: 'https://fonts.googleapis.com/css2?family=Big+Shoulders+Stencil+Display:wght@700;800&family=IBM+Plex+Sans:ital,wght@0,400;0,500;0,600;0,700;1,400&family=IBM+Plex+Mono:wght@400;500;600&display=swap',
      },
    },
  ],

  presets: [
    [
      'classic',
      {
        docs: false,
        blog: false,
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      } satisfies Preset.Options,
    ],
  ],

  themeConfig: {
    colorMode: {
      defaultMode: 'dark',
      disableSwitch: true,
      respectPrefersColorScheme: false,
    },
    navbar: {
      title: 'Systémové myslenie',
      items: [
        {to: '/', label: 'Slovensky', position: 'left'},
        {to: '/en', label: 'English', position: 'left'},
      ],
    },
    footer: {
      style: 'dark',
      links: [],
      copyright: `© ${new Date().getFullYear()} Roman Kazička · systemthinking.sk`,
    },
  } satisfies Preset.ThemeConfig,
};

export default config;
