import { share, canShare } from 'tauri-plugin-share-api';

const btn = document.getElementById('share-btn');
const status = document.getElementById('status');

btn.addEventListener('click', async () => {
  try {
    if (await canShare()) {
      await share({
        url: 'https://github.com/ecarrara/tauri-plugin-share-v2',
        title: 'Tauri Share Plugin',
        text: 'Check out this Tauri v2 share plugin!',
      });
      status.textContent = '✅ Shared successfully!';
    } else {
      status.textContent = '❌ Sharing not available on this platform';
    }
  } catch (err) {
    status.textContent = `❌ Error: ${err}`;
  }
});
