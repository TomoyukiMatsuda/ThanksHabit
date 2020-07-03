document.addEventListener('turbolinks:load', () => {
  // フラッシュメッセージ要素を取得
  const flashMsg = document.querySelector('.alert-message-container');

  // flashMsgを透過しながら非表示にする関数を定義
  const fadeOutFlashMsg = () => {
    const timer_id = setInterval(() => {
      const opacity = flashMsg.style.opacity

      if (opacity > 0) {
        flashMsg.style.opacity = opacity - 0.01
      } else {
        flashMsg.style.display = 'none'
        clearInterval(timer_id);
      }
    }, 30);
  }

  // フラッシュメッセージがある場合にfadeOutFlashMsgを呼び出す
  if (flashMsg !== null) {
    flashMsg.style.opacity = 0.7
    setTimeout(fadeOutFlashMsg, 3000);
  };
});