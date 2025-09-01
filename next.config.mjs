/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  eslint: {
    ignoreDuringBuilds: true,
  },
  typescript: {
    ignoreBuildErrors: true,
  },
  images: {
    unoptimized: true,
  },
  // Netlify configuration
  trailingSlash: true,
  // Disable features that don't work with static export
  experimental: {
    // Remove any experimental features that require server
  },
  webpack: (config, { isServer }) => {
    // Fix for pino-pretty
    if (isServer) {
      config.externals.push('pino-pretty');
    }
    
    // Fix for client-side wallet adapters
    config.resolve.fallback = {
      ...config.resolve.fallback,
      fs: false,
      net: false,
      tls: false,
    };
    
    return config;
  },
}

export default nextConfig;
