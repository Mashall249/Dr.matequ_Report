document.addEventListener("turbolinks:load", function () {
  const isLoggedIn = document.body.dataset.userSignedIn === "true";

  const registerBtn = document.getElementById("registerBtn");
  const declineBtn = document.getElementById("declineBtn");
  const card = document.getElementById("registerPromptCard");
  const dialogueContainer = document.getElementById("dialogueContainer");
  const typedText = document.getElementById("typedText");

  // セリフ定義（登録済み）
  const dialogueIfLoggedIn = `<!--　［ワタシ］ ワカッテル　［キミ］ ハ モウ 登録シテイル　-->

<!--　ソレデモ 押ストハ　マサカ ノ　［登録ノ トウスイ］　-->

<!--　フフフ……　冗談スキダヨ　［キミ］　-->`;

  const dialogueIfDeclined = `<!--　［キミ］ ハ　［登録ヲ コトワッタ］　-->

<!--　［［ダガ断ル！！］］　-->

<!--　メニュー　ノ[［新規登録］] ボタン ヲ　押シナサイ　-->`;

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