document.addEventListener("turbolinks:load", function () {
  const materialElem = document.getElementById("material-log-data");
  if (!materialElem) return;

  const materialId = materialElem.dataset.materialId;
  const startTime = Date.now();

  window.addEventListener("beforeunload", function () {
    const duration = Math.floor((Date.now() - startTime) / 1000);

    // CSRFトークンを取得
    const token = document.querySelector('meta[name="csrf-token"]').getAttribute("content");

    fetch("/access_logs", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": token
      },
      body: JSON.stringify({
        material_id: materialId,
        duration: duration
      }),
      keepalive: true  // ← beforeunload でも送信完了を待てる
    });
  });
});