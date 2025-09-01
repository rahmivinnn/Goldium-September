"use client"

import { useState, useEffect } from "react"
import { motion, AnimatePresence } from "framer-motion"
import { useWalletConnection } from "@/components/providers/WalletConnectionProvider"
import { X, AlertCircle, ExternalLink, ChevronRight } from "lucide-react"
import { Button } from "@/components/ui/button"
import { detectBrowser } from "@/utils/browser-detection"

interface ConnectWalletModalProps {
  isOpen: boolean
  onClose: () => void
}

export default function ConnectWalletModal({ isOpen, onClose }: ConnectWalletModalProps) {
  const { connect, error, retry, clearError, isWalletAvailable, getRecommendedWallet, isBrowserSupported } =
    useWalletConnection()
  const [selectedWallet, setSelectedWallet] = useState<string | null>(null)
  const [isConnecting, setIsConnecting] = useState(false)
  const browserInfo = detectBrowser()

  // Reset state when modal opens/closes
  useEffect(() => {
    if (!isOpen) {
      setSelectedWallet(null)
      setIsConnecting(false)
      clearError()
      // Dispatch event to unlock body scroll
      document.dispatchEvent(new CustomEvent('wallet-modal-close'))
    } else {
      // Dispatch event to lock body scroll
      document.dispatchEvent(new CustomEvent('wallet-modal-open'))
    }

    // Cleanup on unmount
    return () => {
      if (isOpen) {
        document.dispatchEvent(new CustomEvent('wallet-modal-close'))
      }
    }
  }, [isOpen, clearError])

  // Handle wallet selection
  const handleSelectWallet = async (walletName: string) => {
    setSelectedWallet(walletName)
    setIsConnecting(true)
    clearError()

    try {
      // Check if wallet is installed before attempting connection
      if (!isWalletAvailable(walletName.toLowerCase())) {
        throw new Error(`${walletName} wallet is not installed. Please install it first.`)
      }

      const success = await connect(walletName)

      if (success) {
        onClose()
      } else {
        setIsConnecting(false)
      }
    } catch (err: any) {
      console.error("Wallet selection error:", err)
      setIsConnecting(false)
    }
  }

  // Handle retry
  const handleRetry = async () => {
    setIsConnecting(true)
    const success = await retry()

    if (success) {
      onClose()
    } else {
      setIsConnecting(false)
    }
  }

  // Get wallet installation link
  const getWalletInstallLink = (walletName: string) => {
    const browser = browserInfo.name.toLowerCase()

    if (walletName.toLowerCase() === "phantom") {
      if (browser === "chrome")
        return "https://chrome.google.com/webstore/detail/phantom/bfnaelmomeimhlpmgjnjophhpkkoljpa"
      if (browser === "firefox") return "https://addons.mozilla.org/en-US/firefox/addon/phantom-app/"
      if (browser === "edge")
        return "https://microsoftedge.microsoft.com/addons/detail/phantom/bfnaelmomeimhlpmgjnjophhpkkoljpa"
      return "https://phantom.app/download"
    }

    if (walletName.toLowerCase() === "solflare") {
      if (browser === "chrome")
        return "https://chrome.google.com/webstore/detail/solflare-wallet/bhhhlbepdkbapadjdnnojkbgioiodbic"
      if (browser === "firefox") return "https://addons.mozilla.org/en-US/firefox/addon/solflare-wallet/"
      if (browser === "edge")
        return "https://microsoftedge.microsoft.com/addons/detail/solflare-wallet/bhhhlbepdkbapadjdnnojkbgioiodbic"
      return "https://solflare.com/download"
    }

    return "#"
  }

  // Wallet options
  const walletOptions = [
    {
      name: "Phantom",
      displayName: "Phantom",
      icon: "🟣", // Using emoji as fallback
      isAvailable: isWalletAvailable("phantom"),
      isRecommended: getRecommendedWallet() === "phantom",
      description: "A friendly crypto wallet built for DeFi & NFTs"
    },
    {
      name: "Solflare", 
      displayName: "Solflare",
      icon: "🔥", // Using emoji as fallback
      isAvailable: isWalletAvailable("solflare"),
      isRecommended: getRecommendedWallet() === "solflare",
      description: "Powerful wallet for Solana ecosystem"
    },
    {
      name: "Backpack",
      displayName: "Backpack", 
      icon: "🎒", // Using emoji as fallback
      isAvailable: isWalletAvailable("backpack"),
      isRecommended: getRecommendedWallet() === "backpack",
      description: "Multi-chain crypto wallet"
    },
  ]

  if (!isOpen) return null

  return (
    <AnimatePresence>
      {isOpen && (
        <div className="fixed inset-0 z-[9999] flex items-center justify-center p-4 bg-black/70">
          <motion.div
            initial={{ opacity: 0, scale: 0.95, y: 20 }}
            animate={{ opacity: 1, scale: 1, y: 0 }}
            exit={{ opacity: 0, scale: 0.95, y: 20 }}
            transition={{ duration: 0.3, ease: "easeOut" }}
            className="relative w-full max-w-md bg-gradient-to-br from-gray-900/95 to-black/95 border border-yellow-500/30 rounded-2xl shadow-2xl shadow-yellow-500/20 overflow-hidden"
          >
            {/* Header */}
            <div className="flex items-center justify-between p-4 border-b border-gold/20">
              <h2 className="text-xl font-bold text-white">Connect Wallet</h2>
              <button
                onClick={onClose}
                className="p-1 rounded-full hover:bg-white/10 transition-colors"
                aria-label="Close"
              >
                <X className="w-5 h-5 text-gray-400" />
              </button>
            </div>

            {/* Content */}
            <div className="p-4">
              {/* Browser compatibility warning */}
              {!isBrowserSupported && (
                <div className="mb-4 p-3 bg-amber-500/20 border border-amber-500/30 rounded-lg text-amber-400 text-sm">
                  <div className="flex items-start">
                    <AlertCircle className="w-5 h-5 mr-2 flex-shrink-0 mt-0.5" />
                    <div>
                      <p className="font-medium">Browser Compatibility Warning</p>
                      <p className="mt-1">
                        Your browser may have limited compatibility with some wallets. For the best experience, we
                        recommend using Chrome, Firefox, or Brave.
                      </p>
                    </div>
                  </div>
                </div>
              )}

              {/* Error message */}
              {error && (
                <div className="mb-4 p-3 bg-red-500/20 border border-red-500/30 rounded-lg text-red-400 text-sm">
                  <div className="flex items-start">
                    <AlertCircle className="w-5 h-5 mr-2 flex-shrink-0 mt-0.5" />
                    <div>
                      <p className="font-medium">{error.message || "Connection failed"}</p>
                      {(error as any).details && <p className="mt-1">{(error as any).details}</p>}
                      {(error as any).recoverySteps && (
                        <ul className="mt-2 list-disc list-inside">
                          {(error as any).recoverySteps.map((step: string, index: number) => (
                            <li key={index}>{step}</li>
                          ))}
                        </ul>
                      )}
                      {((error as any).code === "WALLET_NOT_FOUND" || error.message?.includes("not installed")) && selectedWallet && (
                        <a
                          href={getWalletInstallLink(selectedWallet)}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="mt-2 flex items-center text-gold hover:underline"
                        >
                          <span>Install {selectedWallet}</span>
                          <ExternalLink className="w-4 h-4 ml-1" />
                        </a>
                      )}
                    </div>
                  </div>
                </div>
              )}

              {/* Wallet options */}
              <div className="space-y-2">
                {walletOptions.map((wallet) => (
                  <button
                    key={wallet.name}
                    onClick={() => handleSelectWallet(wallet.name)}
                    disabled={isConnecting}
                    className={`w-full flex items-center justify-between p-3 rounded-lg border transition-colors ${
                      wallet.isAvailable ? "border-gold/30 hover:bg-gold/10" : "border-gray-700 text-gray-500"
                    }`}
                  >
                    <div className="flex items-center">
                      <div className="w-8 h-8 mr-3 rounded-full bg-black/50 flex items-center justify-center overflow-hidden">
                        <span className="text-lg">{wallet.icon}</span>
                      </div>
                      <div className="text-left">
                        <div className="font-medium">
                          {wallet.displayName}
                          {wallet.isRecommended && <span className="ml-2 text-xs text-gold">Recommended</span>}
                        </div>
                        <div className="text-xs text-gray-400">{wallet.description}</div>
                        {!wallet.isAvailable && <div className="text-xs text-red-400">Not installed</div>}
                      </div>
                    </div>
                    <ChevronRight className="w-5 h-5 text-gray-500" />
                  </button>
                ))}
              </div>

              {/* Retry button */}
              {error && (
                <Button
                  onClick={handleRetry}
                  disabled={isConnecting}
                  className="mt-4 w-full bg-gold hover:bg-gold/90 text-black"
                >
                  {isConnecting ? "Connecting..." : "Retry Connection"}
                </Button>
              )}
            </div>

            {/* Footer */}
            <div className="p-4 border-t border-gold/20 text-xs text-gray-500 text-center">
              By connecting your wallet, you agree to our Terms of Service and Privacy Policy.
            </div>
          </motion.div>
        </div>
      )}
    </AnimatePresence>
  )
}
