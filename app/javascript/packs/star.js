document.addEventListener('turbolinks:load', function () {
  // 平均点表示用（読み取り専用）
  document.querySelectorAll('.avg-star-rating').forEach(elem => {
    const score = elem.dataset.score;
    if (!score) return;

    raty(elem, {
      starOn: '/assets/star-on.png',
      starOff: '/assets/star-off.png',
      starHalf: '/assets/star-half.png',
      score: parseFloat(score),
      readOnly: true
    });
  });

  // 投稿用（スコア送信）
  document.querySelectorAll('.post-star-rating').forEach(elem => {
    const name = elem.dataset.name;
    if (!name) return;

    raty(elem, {
      starOn: '/assets/star-on.png',
      starOff: '/assets/star-off.png',
      starHalf: '/assets/star-half.png',
      scoreName: name
    });
  });

  // コメントごとの評価表示（読み取り専用）
  document.querySelectorAll('.comment-star-rating').forEach(elem => {
    const score = elem.dataset.score;
    if (!score) return;

    raty(elem, {
      starOn: '/assets/star-on.png',
      starOff: '/assets/star-off.png',
      starHalf: '/assets/star-half.png',
      score: parseFloat(score),
      readOnly: true
    });
  });
});