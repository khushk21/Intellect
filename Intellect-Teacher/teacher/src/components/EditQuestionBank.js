import React from "react";
import firebase from "firebase";
import MainAppBar_ from "./MainAppBar";
import {Button} from 'react-bootstrap';
class EditQuestionBank extends React.Component {
    constructor() {
        super();
        this.state = {
         world: "",
         stage: "",
         level: "",
         question: "",
         answer: "",
         option1:"",
         option2:"",
         option3:""
        };
      }
      updateInput = e => {
          
        this.setState({
          [e.target.name]: e.target.value
        });
      }
      addQuestion = async e  =>  { 
        console.log(this.state)
         e.preventDefault();
        const db = firebase.firestore();
        const doc= await db.collection(this.state.world).doc(this.state.stage).get()
        var k=doc.data();
        k[this.state.level].push({"Answer":this.state.answer,"Question":this.state.question,"Options":[this.state.answer,this.state.option1,this.state.option2,this.state.option3]})
        console.log(k[this.state.level])
        const userRef=  db.collection(this.state.world).doc(this.state.stage).update({"Easy":k["Easy"],"Medium":k["Medium"],"Hard":k["Hard"]})
        alert("Question has been added!");
        this.setState({
          world:"",
          stage:"",
          level:"",
          question: "",
          answer: "",
          option1: "",
          option2: "",
          option3: ""
        });
      };
    worlds=["World 1", "World 2","World 3"]
    stages=["Stage 1","Stage 2","Stage 3"]
    levels=["Easy","Medium","Hard"]
    render() {
    return (
      <div>
      <MainAppBar_/>
      <div style={{textAlign:"center"}}>
      <form onSubmit={this.addQuestion}>
      <h3 style={{ paddingTop: 50,textAlign:"center",fontSize:40}}>Add Questions</h3>
      <div style={{paddingTop:20}}>
      <label style={{fontSize:20}}>
                Choose World
            </label>
            <br/>
            <select style={{ borderColor:'pink',borderWidth:3, width: 350, textAlign: 'center'}} name ="world" value={this.state.world} onChange={this.updateInput} required>
                <option value="">Select World</option>
                {this.worlds.map(w=><option key={w}>{w}</option>)}
            </select>
            <br/>
            <label style={{fontSize:20}}>
                Choose Stage
            </label>
            <br/>
            <select style={{ borderColor:'pink',borderWidth:3, width: 350, textAlign: 'center'}} name="stage" value={this.state.stage} onChange={this.updateInput} required>
                <option value="">Select Stage</option>
                {this.stages.map(s=><option key={s}>{s}</option>)}
            </select>
            <br/>
            <label style={{fontSize:20}}>
                Choose Level
            </label>
            <br/>
            <select style={{ borderColor:'pink',borderWidth:3, width: 350, textAlign: 'center'}} name="level" value={this.state.level} onChange={this.updateInput} required>
                <option value="">Select Level</option>
                {this.levels.map(l=><option key={l}>{l}</option>)}
            </select>
            <br/>
            <label style={{fontSize:20}}>
                Question
            </label>
            <br/>
          <input style={{borderColor:'pink',borderWidth:3,width: 350,marginTop: 5, marginBottom: 15, textAlign: 'center'}}
            type="text"
            name="question"
            placeholder="Enter the question"
            onChange={this.updateInput}
            value={this.state.question}
           required/>
          <br/>
          <label style={{fontSize:20}}>
               Answer
            </label>
            <br/>
          <input style={{borderColor:'pink',borderWidth:3,width: 350,marginTop: 5, marginBottom: 15, textAlign: 'center'}}
            type="text"
            name="answer"
            placeholder="Enter the answer"
            onChange={this.updateInput}
            value={this.state.answer}
          required/>
          <br/>
          <label style={{fontSize:20}}>
               Wrong Option 1
            </label>
            <br/>
          <input style={{borderColor:'pink',borderWidth:3,width: 350, marginTop: 5, marginBottom: 15,textAlign: 'center'}}
            type="text"
            name="option1"
            placeholder="Enter wrong option 1"
            onChange={this.updateInput}
            value={this.state.option1}
           required/>
          <br/>
          <label style={{fontSize:20}}>
               Wrong Option 2
            </label>
            <br/>
          <input style={{borderColor:'pink',borderWidth:3,width: 350, marginTop: 5, marginBottom: 15,textAlign: 'center'}}
            type="text"
            name="option2"
            placeholder="Enter wrong option 2"
            onChange={this.updateInput}
            value={this.state.option2}
           required/>
           <br/>
           <label style={{fontSize:20}}>
               Wrong Option 3
            </label>
            <br/>
           <input style={{borderColor:'pink',borderWidth:3,width: 350,textAlign: 'center'}}
            type="text"
            name="option3"
            placeholder="Enter wrong option 3"
            onChange={this.updateInput}
            value={this.state.option3}
           required/>
           <br/>
           <div style={{textAlign:'center',paddingTop:20}}>
                <Button type="submit" variant="dark" size='lg'>Add Question</Button>
              </div> 
      </div>
            
        </form >
      </div>
        </div>
        );
      }
   }
export default EditQuestionBank;

