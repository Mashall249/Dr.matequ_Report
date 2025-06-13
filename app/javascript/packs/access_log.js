document.addEventListener("turbolinks:load", function () {
  const materialElem = document.getElementById("material-log-data");
  if (!materialElem) return;

  const materialId = materialElem.dataset.materialId;
  const startTime = Date.now();

  window.addEventListener("beforeunload", function () {
    const duration = Math.floor((Date.now() - startTime) / 1000);
    navigator.sendBeacon("/material_access_logs", JSON.stringify({
      material_id: materialId,
      duration: duration
    }));
  });
});