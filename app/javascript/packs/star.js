document.addEventListener('turbolinks:load', function () {
  const starPathsElem = document.getElementById('star-image-paths');
  if (!starPathsElem) return;

  //URLを渡すための架け橋
  const starOn = starPathsElem.dataset.starOn;
  const starOff = starPathsElem.dataset.starOff;
  const starHalf = starPathsElem.dataset.starHalf;

  // 平均点表示用（読み取り専用）
  document.querySelectorAll('.avg-star-rating').forEach(elem => {
    const score = elem.dataset.score;
    if (!score) return;

    raty(elem, {
      starOn: starOn,
      starOff: starOff,
      starHalf: starHalf,
      score: parseFloat(score),
      readOnly: true
    });
  });

  // 投稿用（スコア送信）
  document.querySelectorAll('.post-star-rating').forEach(elem => {
    const name = elem.dataset.name;
    if (!name) return;

    raty(elem, {
      starOn: starOn,
      starOff: starOff,
      starHalf: starHalf,
      scoreName: name
    });
  });

  // コメントごとの評価表示（読み取り専用）
  document.querySelectorAll('.comment-star-rating').forEach(elem => {
    const score = elem.dataset.score;
    if (!score) return;

    raty(elem, {
      starOn: starOn,
      starOff: starOff,
      starHalf: starHalf,
      score: parseFloat(score),
      readOnly: true
    });
  });
});

// 通常のページ読み込み時
document.addEventListener('turbolinks:load', initializeStarRatings);

// Ajaxで一部更新されたとき
document.addEventListener('ajax:success', function() {
  initializeStarRatings();
});