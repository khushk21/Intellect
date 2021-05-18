import React,{useEffect} from "react";
import firebase from "firebase";
import MainAppBar_ from "./MainAppBar";
import {  Button } from "react-bootstrap";
class DeleteQuestion extends React.Component {
    constructor() {
        super();
        this.state = {
         world: "",
         stage: "",
         level: "",
         question: "",
         allow:false
        };
      }
      retrievedQuestion=[];
      k=null;
      updateInput = e => {
          
        this.setState({
          [e.target.name]: e.target.value
        });
      }
     
      getQuestions = async e  =>  { 
         e.preventDefault();
        const db = firebase.firestore();
        const doc= await db.collection(this.state.world).doc(this.state.stage).get()
          this.k=doc.data();
         var l=this.k[this.state.level]
         this.retrievedQuestion=[]
        for( var i=0;i<l.length;i++){
            this.retrievedQuestion.push(l[i]["Question"])
        }
        this.setState({allow:true})

      };
      dq=async e=>{
          e.preventDefault();
          const db=firebase.firestore();
          var temp=this.k[this.state.level]
          if(this.state.question==""){
            alert("Please select a question.")
            this.setState({question:""})
          }
          else{
            for(var i=0;i<temp.length;i++){
              if(temp[i]["Question"]==this.state.question){
                  temp.splice(i,1)
                  break;
              }
          }
          this.k[this.state.level]=temp
          await db.collection(this.state.world).doc(this.state.stage).update({
              "Easy":this.k["Easy"],
              "Medium":this.k["Medium"],
              "Hard":this.k["Hard"]
          }
          )
          this.setState({
            world: "",
            stage: "",
            level: "",
            question: "",
            allow:false
          });
          alert("Question has been deleted.")
          }
          
          //console.log(this.k[this.state.level])

      }
   
    worlds=["World 1", "World 2","World 3"]
    stages=["Stage 1","Stage 2","Stage 3"]
    levels=["Easy","Medium","Hard"]
    render() {
    return (
      <div>
      <MainAppBar_/>
      <div style={{textAlign:'center'}}>
        <form onSubmit={this.getQuestions}>
        <h3 style={{ paddingTop: 50,textAlign:"center",fontSize:40}}>Delete Question</h3>
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
            <label style={{paddingTop:10,fontSize:20}}>
                Choose Stage
            </label>
            <br/>
            <select style={{ borderColor:'pink',borderWidth:3, width: 350, textAlign: 'center'}} name="stage" value={this.state.stage} onChange={this.updateInput} required>
                <option value="">Select Stage</option>
                {this.stages.map(s=><option key={s}>{s}</option>)}
            </select>
            <br/>
            <label style={{paddingTop:10,fontSize:20}}>
                Choose Level
            </label>
            <br/>
            <select style={{ borderColor:'pink',borderWidth:3, width: 350, textAlign: 'center'}} name="level" value={this.state.level} onChange={this.updateInput} required>
                <option value="">Select Level</option>
                {this.levels.map(l=><option key={l}>{l}</option>)}
            </select>
            <br/>
            <div style={{textAlign:'center',paddingTop:20}}>
                <Button type="submit" variant="dark" size='lg'>Retrieve Questions</Button>
              </div>       
             </div>
       </form >
       </div>
       {this.state.allow? <div style={{textAlign:'center',paddingTop:20}}>
              <label style={{paddingTop:10,fontSize:20}}>
                  Choose Question To Delete
              </label>
              <br/>
              <select style={{ borderColor:'pink',borderWidth:3, width: 350, textAlign: 'center'}} name="question" value={this.state.question} onChange={this.updateInput} required>
                  <option value="">Select Question</option>
                  {this.retrievedQuestion.map(q=><option key={q}>{q}</option>)}
              </select>
              <br/>
              <div style={{textAlign:'center',paddingTop:20}}>
                <Button type="submit" variant="dark" size='lg' onClick={this.dq}>Delete Question</Button>
              </div> 
          </div>:""}
        </div>
        ); 
      }  
   }
export default DeleteQuestion;

