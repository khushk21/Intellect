import React from "react";
import firebase from "firebase";
import MainAppBar_ from "./MainAppBar";
import {  Button } from "react-bootstrap";
import axios from "axios";
class DeleteStudent extends React.Component {
    constructor() {
        super();
        this.state = {
         username:""
        };
      }
      updateInput = e => {
        this.setState({
          [e.target.name]: e.target.value
        });
      }
      deleteUser = async e  =>  { 
         e.preventDefault();
        var user=firebase.auth().currentUser;
        var sender=user.email;
        const db = firebase.firestore();
         await db.collection("Students").doc(this.state.username).get().then(async (doc) => {
            if (doc.exists) {
              var data1= await db.collection("Students").doc(this.state.username).collection("World 1").get();
              if(data1.empty==false){
                data1.docs.forEach((doc1)=>{
                  db.collection("Students").doc(this.state.username).collection("World 1").doc(doc1.id).delete()
                })
              }
              var data2= await db.collection("Students").doc(this.state.username).collection("World 2").get();
              if(data2.empty==false){
                data2.docs.forEach((doc2)=>{
                  db.collection("Students").doc(this.state.username).collection("World 2").doc(doc2.id).delete()
                })
              }var data3= await db.collection("Students").doc(this.state.username).collection("World 3").get();
              if(data3.empty==false){
                data3.docs.forEach((doc3)=>{
                  db.collection("Students").doc(this.state.username).collection("World 3").doc(doc3.id).delete()
                })
              }
              axios.post("/",{email:doc.data()["email"],subject:"Account Termination",text:"Dear Student,\nYour account for the game Intellect has been deleted by your teacher.\nThank you,\nTeam Intellect.",sender:sender})
              db.collection("Students").doc(this.state.username).delete();
            this.setState({username:""});
            alert("Student account has been deleted.")
            } else {
                alert("Username entered does not exists. Try again.")
            this.setState({username:""})
            }
        })
      };
    render() {
    return (
      <div>
      <MainAppBar_/>
      <div>
      <h3 style={{textAlign:'center', paddingTop: 50,fontSize:40}}>Delete Student Account</h3>
        <div 
        style={{ minHeight: "20vh",textAlign:'center',paddingTop:30}}>
        <form onSubmit={this.deleteUser}>
        <input style={{borderColor:'pink',borderWidth:3,textAlign: 'center' ,width:350}}
            type="text"
            name="username"
            placeholder="Enter username"
            onChange={this.updateInput}
            value={this.state.username}
           required/>
           <br/>
           <div style={{textAlign:'center',paddingTop:20}}>
           <Button variant='dark' size='lg' type="submit">Delete Student</Button>
           </div>
           </form>
        </div>
        </div>  
        </div>
        );
        
      }
      
   }
  
   
export default DeleteStudent;

