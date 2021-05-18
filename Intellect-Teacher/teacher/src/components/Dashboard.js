import React, { useState } from "react";
import {  Button } from "react-bootstrap";
import { useAuth } from "../contexts/AuthContext";
import {  useHistory } from "react-router-dom";
import MainAppBar_ from "./MainAppBar"

export default function Dashboard() {
  const [error, setError] = useState("");
  const { currentUser, logout } = useAuth();
  const history = useHistory();

  async function handleLogout() {
    setError("");

    try {
      await logout();
      history.push("/login");
    } catch {
      setError("Failed to log out");
    }
  }
console.log(error)

  return (
    <>
      <MainAppBar_/>
      <div>
        <div className="d-flex align-items-center justify-content-center" style={{paddingTop: 30, minHeight: "35vh"}}>
          <h1 style={{fontSize:50}}>Welcome, Teacher!</h1>
        </div>
        <div className="d-flex align-items-center justify-content-center" style={{ minHeight: "5vh"}}>
          <h1 style={{fontSize:20}}>What do you want to do today?</h1>
        </div>
        <div className="d-flex align-items-center justify-content-center" style={{paddingTop: 150}}> 
          <Button type='submit' variant='dark' size="lg" onClick={handleLogout}>
            Log Out
          </Button>
        </div>
      </div>
    </>
  );
}
