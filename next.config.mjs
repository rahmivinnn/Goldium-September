/** @type {import('next').NextConfig} */
const NUCLEAR_DEPLOYMENT = require('./NUCLEAR_DEPLOYMENT.js')

const nextConfig = {
  // NUCLEAR FORCE: Generate unique build ID
  generateBuildId: async () => {
    return `NUCLEAR-EGG-CHARS-${Date.now()}`
  },
  
  // Ensure static export works
  output: 'standalone',
  
  // Optimize images
  images: {
    unoptimized: true,
    domains: ['localhost', 'vercel.app', 'goldium-september.vercel.app']
  },
  
  // NUCLEAR FORCE: Environment variables
  env: {
    DEPLOYMENT_VERSION: 'NUCLEAR-EGG-CHARACTERS-LATEST',
    BUILD_TIME: new Date().toISOString(),
    NUCLEAR_DEPLOYMENT_ID: `nuclear-${Date.now()}`,
    EGG_CHARACTERS_VERSION: '2.0.0-NUCLEAR'
  },
  
  // Webpack config to force rebuild
  webpack: (config, { buildId, dev, isServer, defaultLoaders, webpack }) => {
    // Force rebuild by adding deployment marker
    config.plugins.push(
      new webpack.DefinePlugin({
        'process.env.DEPLOYMENT_MARKER': JSON.stringify(`egg-chars-${Date.now()}`)
      })
    )
    return config
  }
}

export default nextConfig