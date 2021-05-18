import React from "react";
import firebase from "firebase";
import MainAppBar_ from "./MainAppBar";
import {FacebookIcon, FacebookShareButton,TwitterShareButton, TwitterIcon} from "react-share";
import {Row } from 'reactstrap';
import {  Button } from "react-bootstrap";
import axios from "axios";
class Assignment extends React.Component {
  readList= async e=>{
    const db=firebase.firestore()
    var indexList=[]
    var user=firebase.auth().currentUser;
    var email=user.email;
    const data= await db.collection("Teacher").get()
    data.docs.forEach((doc)=>{
        if(doc.id==email){
            var temp=doc.data()
            indexList=temp["index"]
            this.setState({indexList:indexList})
         }
         
    })
  }
  
    constructor() {
        super();
        this.state = {
         world:"",
         class_index:"",
         assignment_code:"",
         title:"",
         share:false,
         indexList:[]
        };
        this.readList()
      }
      questionBank=[]
      document=null
      updateInput = e => {
        this.setState({
          [e.target.name]: e.target.value
        });
      }
      changeState= e=>{
        this.setState({world:"",
        class_index:"",
        assignment_code:"",
        title:"",
        share:false,
      indexList:[]})
      this.readList()
      }
      sendAssignment =  async e => { 
        e.preventDefault();
        var user=firebase.auth().currentUser;
        var sender=user.email;
        this.questionBank= await getQuestion(this.state.world)
        const db = firebase.firestore();
        var d=new Date();
        d.setDate(d.getDate()+3);
        await db.collection("Assignments").doc(d.toISOString()).set({
              "assignment_code":this.state.assignment_code,
              "cleared_students":[],
              "attempted_students":[],
              "class_index":this.state.class_index,
              "title":this.state.title,
              "world": this.state.world,
              "dueDate":d.toISOString()
          })
          
          await db.collection("Students").where("class_index","==",this.state.class_index).get().then((data)=>{
              data.forEach(async (doc) => {
                  var temp=doc.data();
                  temp["assignment_code"].push(d.toISOString())
                  await db.collection("Students").doc(temp["user_name"]).update(temp)
                   axios.post("/",{email:temp["email"],subject:"New Assignment Added",text:"Dear Student,\nA new assignment has been added.\nPlease complete it within 3 days from today.\nThank you,\nTeam Intellect.",sender:sender})
              })
          })
          var user=firebase.auth().currentUser;
          var email=user.email;
          await db.collection("Teacher").get().then((data)=>{
              data.forEach( async (doc)=>{
                  if(doc.id==email){
                      var temp=doc.data();
                      if(temp["index"].includes(this.state.class_index)){
                          temp["assignment_code"].push(d.toISOString())
                         await db.collection("Teacher").doc(doc.id).update(temp)
                      }
                  }
              })
          })
          this.setState({
            share:true
          })
      };
      
      worlds=["World 1", "World 2","World 3"]
  render() {
    return (
      <div>
      <MainAppBar_/>
      <div style={{textAlign:'center'}}>
          <h3 style={{textAlign:'center', paddingTop: 50,fontSize:40}}>Send Assignments</h3>
          <div 
        style={{textAlign:'center',paddingTop:20}}>
          <form onSubmit={this.sendAssignment}>
            <input style={{borderColor:"pink",borderWidth:3,marginLeft: 40}}
              type="text"
              name="title"
              placeholder="Enter Assignment Title"
              onChange={this.updateInput}
              value={this.state.title}
            required/>
            <br/>
            <input style={{width:180,borderColor:"pink",borderWidth:3,marginTop: 25, marginLeft: 40}}
              type="text"
              name="assignment_code"
              placeholder="Enter Assignment Code"
              onChange={this.updateInput}
              value={this.state.assignment_code}
            required/>
            <h3 style={{paddingTop: 20,fontSize:30}}>Choose Class Index</h3>
            <br/>
            <div style={{textAlign:'center'}}>
            <select name ="class_index" style={{marginLeft:40,width:180, borderColor:"pink",borderWidth:3}} onChange={(e) => this.setState({class_index:e.target.value})} required>
                <option value="">Select Index</option>
                {this.state.indexList.map(i=><option key={i}>{i}</option>)}
            </select>
            </div>
            <br/>
              <div style={{textAlign:"center"}}>
              <h6 style={{fontSize:30}}>
                  Choose the Topic for the Assignment:
              </h6>
              </div>
              <br/>
              <div style={{textAlign:"center"}}>
              <select style={{marginLeft:40,width:180, borderColor:"pink",borderWidth:3}} name="world" value={this.state.world} onChange={this.updateInput} required>
                  <option value="">Select World</option>
                  {this.worlds.map(w=><option key={w}>{w}</option>)}
              </select>
              <br/>
              </div>
             
              <div style={{textAlign:'center',paddingTop:20}}>
              <Button variant='dark' size='sm' type="submit">Submit</Button>

              </div>
          </form >
          </div>
          {this.state.share?
          <div style={{textAlign:'center'}}>
            
              <div style={{paddingTop:20}}>
                  <FacebookShareButton 
                  quote={this.state.assignment_code}
                  hashtag={this.state.title}
                  url="wwww.ntu.edu.sg"
                  >
                      <FacebookIcon logofillcolor="white" round={true}></FacebookIcon>
                  </FacebookShareButton>
                  <TwitterShareButton url="www.ntu.edu.sg" styles={{paddingleft: 15}}
                  title={this.state.assignment_code}>
                      <TwitterIcon logofillcolor="white" round={true}></TwitterIcon>
                  </TwitterShareButton>
              </div>
          <div style={{textAlign:'center',paddingTop:20}}>
                <Button  variant='dark' size='sm' onClick={this.changeState}>
                  Finish
                </Button>
                </div>
          </div>:""}
          <br/>
          </div>
        </div>
        );
      }
   }
   async function getQuestion(world){
       var quest=[];
       const db = firebase.firestore();
       await db.collection(world).get().then((data)=>{
           data.forEach((doc)=>{
            var temp =   doc.data();
               for (var i = 0; i < temp["Easy"].length; i++) {
                   quest.push(temp["Easy"][i]);
               }
               for (var i = 0; i < temp["Medium"].length; i++) {
                 quest.push(temp["Medium"][i]);
             }
             for (var i = 0; i < temp["Hard"].length; i++) {
                 quest.push(temp["Hard"][i]);
             }
               
           })
       })
       return quest;
   }
export default Assignment;