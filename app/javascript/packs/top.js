document.addEventListener("turbolinks:load", function () {
  const isLoggedIn = document.body.dataset.userSignedIn === "true";

  const registerBtn = document.getElementById("registerBtn");
  const declineBtn = document.getElementById("declineBtn");
  const card = document.getElementById("registerPromptCard");
  const dialogueContainer = document.getElementById("dialogueContainer");
  const typedText = document.getElementById("typedText");

  // セリフ定義（登録済み）
  const dialogueIfLoggedIn = `<!--　［ワタシ］ ワカッテル　［キミ］ ハ モウ トウロク シテイル　-->

<!--　ソレデモ オス トハ　マサカ ノ　［トウロク ノ トウスイ］　-->

<!--　フフフ……　ジョウダン　スキダヨ　［キミ］　-->`;

  const dialogueIfDeclined = `<!--　［キミ］ ハ　［トウロク ヲ コトワッタ］　-->

<!--　ソレハ　［［フメイナ ケッテイ］］　ダネ　-->

<!--　デモ　［ワタシ］ ナラ　マダ マニアウ　ト シンジテル　-->

<!--　［トウロク スル］ ボタン ヲ　オシナサイ　-->`;

  let i = 0;
  let message = "";

  function typeWriter() {
    if (!typedText) return;
    if (i < message.length) {
      typedText.innerHTML += message[i] === "\n" ? "<br>" : message[i];
      i++;
      setTimeout(typeWriter, 30);
    }
  }

  if (declineBtn) {
    declineBtn.addEventListener("click", function () {
      card.style.display = "none";
      dialogueContainer.style.display = "block";
      message = dialogueIfDeclined;
      typedText.innerHTML = "";
      i = 0;
      typeWriter();
    });
  }

  if (registerBtn && isLoggedIn) {
    registerBtn.addEventListener("click", function (event) {
      event.preventDefault();
      card.style.display = "none";
      dialogueContainer.style.display = "block";
      message = dialogueIfLoggedIn;
      typedText.innerHTML = "";
      i = 0;
      typeWriter();
    });
  }
});