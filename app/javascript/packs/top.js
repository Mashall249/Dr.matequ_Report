document.addEventListener("turbolinks:load", function () {
  const isLoggedIn = document.body.dataset.userSignedIn === "true";

  const registerBtn = document.getElementById("registerBtn");
  const declineBtn = document.getElementById("declineBtn");
  const card = document.getElementById("registerPromptCard");
  const dialogueContainer = document.getElementById("dialogueContainer");
  const typedText = document.getElementById("typedText");
  const choices = document.getElementById("dialogueChoices");
  const backBtn = document.getElementById("backBtn");
  const retryBtn = document.getElementById("retryBtn");

  // ▼ セリフ定義（配列で複数分）
  const guestDialogues = [
    `<!--　［キミ］ ハ　［登録ヲ コトワッタ］　-->
     <!--　[[ダガ　断ル!!]]　-->
     <!--　［トウロク スル］ ボタン ヲ　オシナサイ　-->`,

    `<!--　冷ヤカシナラ　コトワルワ　-->
     <!--　［ワタシ］ ノ ハナシ　ムシ スル ナンテ　ヒドイヨ　-->
     <!--　コレガ　[[ラストチャンス]]　-->`,

    `<!--　帰レ!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!　-->`
  ];

  const loggedInDialogues = [
    `<!--　［ワタシ］ ワカッテル　［キミ］ ハ モウ トウロク シテイル　-->
     <!--　ナノニ ナゼ オシタノ？　オシャベリガ スキ ナンダネ　-->
     <!--　フフフ……　ジョウダン　スキダヨ　［キミ］　-->`,

    `<!--　マタ キタノ　-->
     <!--　［登録ズミ］ ナノニ　キニ ナッチャウノ？　-->
     <!--　ホント ハ ［ワタシ］ ノ コト スキナンデショ　-->`
  ];

  let dialogueCounter = 0;
  let message = "";
  let i = 0;

  function startDialogue(text) {
    card.style.display = "none";
    dialogueContainer.style.display = "block";
    typedText.innerHTML = "";
    choices.style.display = "none";
    message = text;
    i = 0;
    typeWriter();
  }

  function typeWriter() {
    if (i < message.length) {
      typedText.innerHTML += message[i] === "\n" ? "<br>" : message[i];
      i++;
      setTimeout(typeWriter, 30);
    } else {
      choices.style.display = "block";
    }
  }

  if (registerBtn) {
    registerBtn.addEventListener("click", function (e) {
      if (!isLoggedIn) return; // 通常遷移
      e.preventDefault();
      dialogueCounter++;
      const dialogues = loggedInDialogues;
      const index = Math.min(dialogueCounter - 1, dialogues.length - 1);
      startDialogue(dialogues[index]);
    });
  }

  if (declineBtn) {
    declineBtn.addEventListener("click", function () {
      dialogueCounter++;
      const dialogues = isLoggedIn ? loggedInDialogues : guestDialogues;
      const index = Math.min(dialogueCounter - 1, dialogues.length - 1);
      startDialogue(dialogues[index]);
    });
  }

  if (backBtn) {
    backBtn.addEventListener("click", function () {
      dialogueContainer.style.display = "none";
      choices.style.display = "none";
      card.style.display = "block";
    });
  }

  if (retryBtn) {
    retryBtn.addEventListener("click", function () {
      typedText.innerHTML = "";
      choices.style.display = "none";
      i = 0;
      typeWriter();
    });
  }
});