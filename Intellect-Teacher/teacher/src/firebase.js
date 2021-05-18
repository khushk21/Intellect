import firebase from "firebase/app";
import "firebase/auth";

const app = firebase.initializeApp({
  apiKey: "AIzaSyDFV42ag3HMnB2OJlJjui_Pf3I4Q1e-1sM",
  authDomain: "intellect-94dcd.firebaseapp.com",
  projectId: "intellect-94dcd",
  storageBucket: "intellect-94dcd.appspot.com",
  messagingSenderId: "487267581103",
  appId: "1:487267581103:web:9cc5bc550e5905c336e85a",
});

export const auth = app.auth();
export default app;
