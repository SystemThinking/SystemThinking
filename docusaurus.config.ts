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
