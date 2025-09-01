/** @type {import('next').NextConfig} */
const nextConfig = {
  // Force new deployment recognition
  generateBuildId: async () => {
    return `egg-characters-${Date.now()}`
  },
  
  // Ensure static export works
  output: 'standalone',
  
  // Optimize images
  images: {
    unoptimized: true,
    domains: ['localhost', 'vercel.app', 'goldium-september.vercel.app']
  },
  
  // Force Vercel to recognize changes
  env: {
    DEPLOYMENT_VERSION: 'egg-characters-latest',
    BUILD_TIME: new Date().toISOString()
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