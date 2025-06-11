function initializeStarRatings() {
  // 画像パスは専用タグから一度だけ取得
  const starPathsElem = document.getElementById('star-image-paths');
  const starOnPath = starPathsElem?.dataset.starOn || '/assets/star-on.png';
  const starOffPath = starPathsElem?.dataset.starOff || '/assets/star-off.png';
  const starHalfPath = starPathsElem?.dataset.starHalf || '/assets/star-half.png';

  // 平均点表示
  document.querySelectorAll('.avg-star-rating').forEach(elem => {
    const score = elem.dataset.score;
    if (!score || elem.dataset.ratyInitialized) return;
    elem.dataset.ratyInitialized = true;

    raty(elem, {
      starOn: starOnPath,
      starOff: starOffPath,
      starHalf: starHalfPath,
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
      starOn: starOnPath,
      starOff: starOffPath,
      starHalf: starHalfPath,
      scoreName: name
    });
  });

  // コメント用
  document.querySelectorAll('.comment-star-rating').forEach(elem => {
    const score = elem.dataset.score;
    if (!score || elem.dataset.ratyInitialized) return;
    elem.dataset.ratyInitialized = true;

    raty(elem, {
      starOn: starOnPath,
      starOff: starOffPath,
      starHalf: starHalfPath,
      score: parseFloat(score),
      readOnly: true
    });
  });
}

// 通常のページ読み込み時
document.addEventListener('turbolinks:load', initializeStarRatings);

// Ajaxで一部更新されたとき
document.addEventListener('ajax:success', initializeStarRatings);