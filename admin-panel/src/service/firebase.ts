import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";
import { getStorage } from "firebase/storage";
import { getAuth, signInWithEmailAndPassword, onAuthStateChanged, signOut } from "firebase/auth";

const firebaseConfig = {
    apiKey: "AIzaSyB3XpAmIZAY61wlCknDjxZo4TdDrOy7XRE",
    authDomain: "flutter-firebase-starter-7c77a.firebaseapp.com",
    projectId: "flutter-firebase-starter-7c77a",
    storageBucket: "flutter-firebase-starter-7c77a.appspot.com",
    messagingSenderId: "246161893617",
    appId: "1:246161893617:web:ae5c5d570ab515fb4ba150"
};

const firebaseApp = initializeApp(firebaseConfig);

export const firestore = getFirestore(firebaseApp);

export const auth = getAuth();

const storage = getStorage(firebaseApp);

export {
    storage as default,
    signInWithEmailAndPassword,
    onAuthStateChanged,
    signOut
}