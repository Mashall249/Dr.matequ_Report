document.addEventListener('turbolinks:load', () => {
  document.querySelectorAll('.favorite-toggle').forEach(btn => {
    btn.addEventListener('ajax:success', (event) => {
      const [data, status, xhr] = event.detail;
      const materialId = btn.dataset.materialId;

      // 例: アイコンを切り替えたり、メッセージを表示したり
      console.log(`お気に入り処理成功: ${materialId}`);
    });

    btn.addEventListener('ajax:error', () => {
      alert('お気に入り処理に失敗しました');
    });
  });
});