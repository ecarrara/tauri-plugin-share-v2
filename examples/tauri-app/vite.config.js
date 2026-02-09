import { defineConfig } from 'vite';

export default defineConfig({
  root: 'src',
  clearScreen: false,
  server: {
    strictPort: true,
  },
  envPrefix: ['VITE_', 'TAURI_'],
  build: {
    outDir: '../dist',
    emptyOutDir: true,
    target: 'esnext',
    minify: !process.env.TAURI_DEBUG,
    sourcemap: !!process.env.TAURI_DEBUG,
  },
});
