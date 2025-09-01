"use client"

import React, { createContext, useContext, useState, useCallback, useEffect, type ReactNode } from "react"
import { useWallet } from "@solana/wallet-adapter-react"
import { useToast } from "@/components/ui/use-toast"
import { detectBrowser } from "@/utils/browser-detection"
import { isWalletInstalled, getRecommendedWallet } from "@/utils/wallet-detection"
import { isBrowserSupported, getBrowserRecommendedWallet } from "@/utils/browser-detection"
import { parseWalletError } from "@/utils/connection-error"

type ConnectionStatus = "disconnected" | "connecting" | "connected" | "error"

interface WalletConnectionContextType {
  status: ConnectionStatus
  error: Error | null
  connect: (walletName?: string) => Promise<boolean>
  disconnect: () => Promise<void>
  retry: () => Promise<boolean>
  clearError: () => void
  isWalletAvailable: (walletName: string) => boolean
  getRecommendedWallet: () => string | null
  isBrowserSupported: () => boolean
}

const WalletConnectionContext = createContext<WalletConnectionContextType | undefined>(undefined)

export function WalletConnectionProvider({ children }: { children: ReactNode }) {
  const { select, connect: walletConnect, disconnect: walletDisconnect, wallet, connected, wallets } = useWallet()
  const [status, setStatus] = useState<ConnectionStatus>(connected ? "connected" : "disconnected")
  const [error, setError] = useState<Error | null>(null)
  const { toast } = useToast()

  const connect = useCallback(async (walletName?: string) => {
    try {
      setStatus("connecting")
      setError(null)

      // If walletName is provided, select the wallet first
      if (walletName && wallets) {
        // Find the wallet adapter by name from the existing wallets
        const normalizedWalletName = walletName.toLowerCase()
        const selectedWallet = wallets.find(w => 
          w.adapter.name.toLowerCase().includes(normalizedWalletName) ||
          normalizedWalletName.includes(w.adapter.name.toLowerCase())
        )
        
        if (selectedWallet) {
          console.log(`Selecting wallet: ${selectedWallet.adapter.name}`)
          select(selectedWallet.adapter.name)
          // Wait a bit for the wallet to be selected
          await new Promise(resolve => setTimeout(resolve, 500))
        } else {
          console.error(`Available wallets:`, wallets.map(w => w.adapter.name))
          throw new Error(`Wallet '${walletName}' not found or not supported`)
        }
      }

      // Check if wallet is available and installed
      if (wallet && wallet.readyState !== 'Installed') {
        console.error(`Wallet readyState: ${wallet.readyState}`)
        throw new Error(`${wallet.adapter.name} wallet is not installed or ready. Please install it first and refresh the page.`)
      }

      // If no wallet is selected, throw an error
      if (!wallet) {
        throw new Error("No wallet selected. Please select a wallet first.")
      }

      console.log(`Attempting to connect to ${wallet.adapter.name}...`)
      await walletConnect()
      setStatus("connected")

      toast({
        title: "Wallet Connected",
        description: `Successfully connected to ${wallet.adapter.name}.`,
      })
      
      return true
    } catch (err: any) {
      console.error("Wallet connection error:", err)
      setStatus("error")
      
      // Parse the error using utility function
      const parsedError = parseWalletError(err)
      setError(parsedError as any)

      toast({
        title: "Connection Failed",
        description: parsedError.message,
        variant: "destructive",
      })
      
      return false
    }
  }, [wallet, walletConnect, select, toast, wallets])

  const disconnect = useCallback(async () => {
    try {
      // Only attempt to disconnect if wallet is actually connected
      if (connected && wallet) {
        await walletDisconnect()
      }
      
      setStatus("disconnected")
      setError(null)

      toast({
        title: "Wallet Disconnected",
        description: "Your wallet has been disconnected.",
      })
    } catch (err: any) {
      console.error("Wallet disconnection error:", err)
      
      // If the error is about wallet not being connected, just set status to disconnected
      if (err?.message?.includes("not connected")) {
        setStatus("disconnected")
        setError(null)
        return
      }
      
      setError(err instanceof Error ? err : new Error(err?.message || "Failed to disconnect wallet"))

      toast({
        title: "Disconnection Failed",
        description: err?.message || "Failed to disconnect wallet",
        variant: "destructive",
      })
    }
  }, [connected, wallet, walletDisconnect, toast])

  const retry = useCallback(async () => {
    if (error) {
      setError(null)
      return await connect()
    }
    return false
  }, [error, connect])

  const clearError = useCallback(() => {
    setError(null)
  }, [])

  const isWalletAvailable = useCallback((walletName: string) => {
    return isWalletInstalled(walletName)
  }, [])

  // Body scroll lock management for modal
  useEffect(() => {
    const handleModalOpen = () => {
      document.body.classList.add('wallet-modal-open')
    }

    const handleModalClose = () => {
      document.body.classList.remove('wallet-modal-open')
    }

    // Listen for wallet modal events
    document.addEventListener('wallet-modal-open', handleModalOpen)
    document.addEventListener('wallet-modal-close', handleModalClose)

    return () => {
      document.removeEventListener('wallet-modal-open', handleModalOpen)
      document.removeEventListener('wallet-modal-close', handleModalClose)
      document.body.classList.remove('wallet-modal-open')
    }
  }, [])

  return (
    <WalletConnectionContext.Provider value={{ 
      status, 
      error, 
      connect, 
      disconnect, 
      retry, 
      clearError, 
      isWalletAvailable, 
        getRecommendedWallet: () => getRecommendedWallet() || getBrowserRecommendedWallet(), 
  isBrowserSupported 
    }}>
      {children}
    </WalletConnectionContext.Provider>
  )
}

export function useWalletConnection() {
  const context = useContext(WalletConnectionContext)
  if (!context) {
    throw new Error("useWalletConnection must be used within a WalletConnectionProvider")
  }
  return context
}
