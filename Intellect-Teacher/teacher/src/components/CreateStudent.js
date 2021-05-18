import React ,{useState} from "react";
import firebase from "firebase";
import MainAppBar_ from "./MainAppBar";
import {  Button } from "react-bootstrap";
import axios from "axios";
class CreateStudent extends React.Component {
  readList= async e=>{
    const db=firebase.firestore()
    var indexList=[]
    var user=firebase.auth().currentUser;
    const data= await db.collection("Teacher").get()
    data.docs.forEach((doc)=>{
        if(doc.id==user.email){
            var temp=doc.data()
            indexList=temp["index"]
            this.setState({indexList:indexList})
         }
         
    })
  }
    constructor() {
        super();
        this.state = {
         email: "",
         fullname: "",
         user_name: "",
         password: "password",
         class_index: "",
         challenge_received:[],
         assignment_code:[],
         experience:0,
         character:"Character 1",
         indexList: []
        };
        this.readList()
      }
      updateInput = e => {
        this.setState({
          [e.target.name]: e.target.value
        });
      }
      addUser = async e => { 
        e.preventDefault();
        var user=firebase.auth().currentUser;
        var sender=user.email;
        const db = firebase.firestore();
        var t=false
        var data=await db.collection("Students").get()
        if(data.empty==false){
          data.docs.forEach((doc)=>{
            if(doc.id==this.state.user_name){
             
              t=true
            this.setState({
              fullname: "",
              email: "",
              user_name: "",
              password: "password",
              class_index: "",
              challenge_received:[],
              assignment_code:[],
              character:"Character 1",
              experience:0,
              indexList:[]
            });
              alert("Username already exists!Please try again!")
              this.readList()
            }
          })
        }
        if(t==false){const userRef = db.collection("Students").doc(this.state.user_name).set({
          fullname: this.state.fullname,
          email: this.state.email,
          user_name:this.state.user_name,
          password:this.state.password,
          class_index:this.state.class_index,
          challenge_received:this.state.challenge_received,
          assignment_code:this.state.assignment_code,
          experience:this.state.experience,
          character:this.state.character
        }); 
        axios.post("/",{email:this.state.email,subject:"Account Registration Completed",text:"Dear Student,\nYour account for the game Intellect has been created by your teacher.\nYour account username is: "+this.state.user_name+".\nYour account password is: password.\nThank you,\nTeam Intellect",sender:sender})
        const userRef1=db.collection("Students").doc(this.state.user_name).collection("World 1").doc("Stage 1").set({"Levels":{"Easy":{"score":0,"time_taken":0,"attempts":0,"correct_questions":0}},"total_score":0});
              this.setState({
                fullname: "",
                email: "",
                user_name: "",
                password: "password",
                class_index: "",
                challenge_received:[],
                assignment_code:[],
                character:"Character 1",
                experience:0,
                indexList:[]
              });
              alert("Student has been added!")}
              this.readList()
      };
  render() {
    return (
      <div>
      <MainAppBar_/>
      <div>
        <h3 style={{textAlign:'center', paddingTop: 50,fontSize:40}}>Add New Student</h3>
        <div className="d-flex align-items-center justify-content-center"
        style={{ minHeight: "40vh"}}>
          <form onSubmit={this.addUser}>
            <input style={{borderColor:'pink',borderWidth:3,width: 350,  textAlign: 'center'}} 
              type="text"
              name="fullname"
              placeholder="Enter Full name"
              onChange={this.updateInput}
              value={this.state.fullname}
            required/>
            <br/>
            <input style={{borderColor:'pink',borderWidth:3,marginTop: 25, marginBottom: 25, width: 350, textAlign: 'center'}}
              type="email"
              name="email"
              placeholder="Enter email address"
              onChange={this.updateInput}
              value={this.state.email}
            required/>
            <br/>
            <input style={{borderColor:'pink',borderWidth:3,width: 350, textAlign: 'center'}}
              type="text"
              name="user_name"
              placeholder="Enter username"
              onChange={this.updateInput}
              value={this.state.user_name}
            required/>
            <br/>
            
            <h3 style={{textAlign:'center', paddingTop: 20,fontSize:30}}>Choose Class Index</h3>
            <br/>
            <select name ="class_index" style={{ borderColor:'pink',borderWidth:3, width: 350, textAlign: 'center'}} onChange={(e) => this.setState({class_index:e.target.value})} required>
                <option value="">Select Index</option>
                {this.state.indexList.map(i=><option key={i}>{i}</option>)}
            </select>
            <br/>
              <div style={{textAlign:'center',paddingTop:20}}>
                <Button type="submit" variant="dark" size='lg'>Submit</Button>
              </div>
          </form >
          </div>
        </div>
        </div>
        );
      }
   }
export default CreateStudent;
