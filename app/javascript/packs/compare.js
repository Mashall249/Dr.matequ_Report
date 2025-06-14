document.addEventListener("turbolinks:load", function () {
  const savedIds = JSON.parse(localStorage.getItem("compare_ids") || "[]");
  const selectedIds = new Set(savedIds);

  const compareBtn = document.getElementById("go-to-compare");

  document.querySelectorAll(".compare-toggle").forEach((button) => {
    const id = button.dataset.id;

    // 初期化：選択済みボタンを再設定
    if (selectedIds.has(id)) {
      button.classList.remove("btn-outline-primary");
      button.classList.add("btn-primary");
      button.textContent = "選択中";
    }

    button.addEventListener("click", () => {
      if (selectedIds.has(id)) {
        selectedIds.delete(id);
        button.classList.remove("btn-primary");
        button.classList.add("btn-outline-primary");
        button.textContent = "比較に追加";
      } else {
        selectedIds.add(id);
        button.classList.remove("btn-outline-primary");
        button.classList.add("btn-primary");
        button.textContent = "選択中";
      }

      // 保存
      localStorage.setItem("compare_ids", JSON.stringify([...selectedIds]));

      // 比較ボタンの有効/無効更新（存在チェックを追加）
      if (compareBtn) {
        compareBtn.disabled = selectedIds.size < 2;
      }
    });
  });

  // ページ読み込み時点でボタン状態を更新
  if (compareBtn) {
    compareBtn.disabled = selectedIds.size < 2;
  }

  // 比較ボタン押下時：URL生成
  if (compareBtn) {
    compareBtn.addEventListener("click", () => {
      if (selectedIds.size >= 2) {
        const query = Array.from(selectedIds).map(id => `ids[]=${id}`).join("&");
        localStorage.removeItem("compare_ids");
        window.location.href = `/materials/compare?${query}`;
      }
    });
  }
});