function initializeStarRatings() {
  // 平均点表示
  document.querySelectorAll('.avg-star-rating').forEach(elem => {
    const score = elem.dataset.score;
    if (!score || elem.dataset.ratyInitialized) return;
    elem.dataset.ratyInitialized = true;

    raty(elem, {
      starOn: elem.dataset.starOn || '/assets/star-on.png',
      starOff: elem.dataset.starOff || '/assets/star-off.png',
      starHalf: elem.dataset.starHalf || '/assets/star-half.png',
      score: parseFloat(score),
      readOnly: true
    });
  });

  // 投稿用（スコア送信用）
  document.querySelectorAll('.post-star-rating').forEach(elem => {
    const name = elem.dataset.name;
    if (!name || elem.dataset.ratyInitialized) return;
    elem.dataset.ratyInitialized = true;

    raty(elem, {
      starOn: elem.dataset.starOn || '/assets/star-on.png',
      starOff: elem.dataset.starOff || '/assets/star-off.png',
      starHalf: elem.dataset.starHalf || '/assets/star-half.png',
      scoreName: name
    });
  });

  // コメント用
  document.querySelectorAll('.comment-star-rating').forEach(elem => {
    const score = elem.dataset.score;
    if (!score || elem.dataset.ratyInitialized) return;
    elem.dataset.ratyInitialized = true;

    raty(elem, {
      starOn: elem.dataset.starOn || '/assets/star-on.png',
      starOff: elem.dataset.starOff || '/assets/star-off.png',
      starHalf: elem.dataset.starHalf || '/assets/star-half.png',
      score: parseFloat(score),
      readOnly: true
    });
  });
}

// 通常のページ読み込み時
document.addEventListener('turbolinks:load', initializeStarRatings);

// Ajaxで一部更新されたとき
document.addEventListener('ajax:success', function() {
  initializeStarRatings();
});