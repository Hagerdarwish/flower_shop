importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyDKWdkFjeKkEAfKFrMO2svs48t2d9OqRGw",
  appId: "1:725835190067:web:86225b1572d53a90e53846",
  messagingSenderId: "725835190067",
  projectId: "elevate-flower-app",
  authDomain: "elevate-flower-app.firebaseapp.com",
  storageBucket: "elevate-flower-app.firebasestorage.app",
});

const messaging = firebase.messaging();
