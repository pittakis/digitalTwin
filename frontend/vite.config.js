import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
    server: {
    host: '0.0.0.0', // ← your local IP or hostname
    port: 7779,        // ← your desired port
    strictPort: true,  // ← optional: fail if 3000 is busy
        allowedHosts: [
      'pittakis.onthewifi.com',    // <-- your domain
    ],
  }
})
