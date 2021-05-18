import React, { useState,useEffect} from "react";
import {useHistory} from "react-router-dom";
import firebase from "firebase";
import MainAppBar_ from "./MainAppBar";
import readIndexList from "./DataRetrieval"
import {Button} from "react-bootstrap";

export default function ClassProgress() {
   const worlds=["World 1", "World 2","World 3"]
   const stages=["Stage 1","Stage 2","Stage 3","All"]
   const levels=["Easy","Medium","Hard","All"]
   const  [world, setWorld]=useState("")
   const [stage,setStage]=useState("")
   const [level,setLevel]=useState("")
   const [index,setIndex]=useState("")
   const [allow,setAllow]=useState(false)
   const [iList,setIList]=useState([])
   const [studList,setStudList]=useState([])
   const [student,setStudent]=useState("")
useEffect(() => {
    var user=firebase.auth().currentUser;
    (readIndexList(setIList))
}, [])

const check=async e=>{
    e.preventDefault();
    var studentList=[]
    const db=firebase.firestore();
    const data= await db.collection("Students").where("class_index","==",index).get();
    data.docs.forEach((doc)=>{
        var temp=doc.data()
        studentList.push(doc.id)
    })
    studentList.push("All")
    setStudList(studentList)
}
const history=useHistory()

function ShowProgress(){
     if(student==""){
        alert("Please select a student.")
    }
    else if(student!="All"){
        history.push({
            pathname:'/displaystudentprogress',
            state:{world:world,stage:stage,index:index,student:student,level:level}
        })
    }
   
    else{
        history.push({
            pathname:'/displayallprogress',
            state:{world:world,stage:stage,index:index,studList:studList,level:level}
        })
    }
    }
return (
        <div>
             <MainAppBar_/>
             <div style={{textAlign:'center'}}>
        <h3 style={{paddingTop: 60,fontSize:40,textAlign:'center'}}>View progress</h3>
        <div 
        style={{ textAlign:'center',minHeight: "40vh"}}>
        <form onSubmit={check}>
            <label style={{fontSize:20}}>
                Choose World
            </label>
            <br/>
            <select style={{ borderColor:'pink',borderWidth:3, width: 350, textAlign: 'center'}} name ="world" onChange={(e) => setWorld(e.target.value)} required>
                <option value="">Select World</option>
                {worlds.map(w=><option key={w}>{w}</option>)}
            </select>
            <br/>
            <label style={{fontSize:20,paddingTop:10}}>
                Choose Stage
            </label>
            <br/>
            <select style={{ borderColor:'pink',borderWidth:3, width: 350, textAlign: 'center'}} name ="stage" onChange={(e) => setStage(e.target.value)} required>
                <option value="">Select Stage</option>
                {stages.map(s=><option key={s}>{s}</option>)}
            </select>
            <br/>
            <label style={{fontSize:20,paddingTop:10}}>
                Choose Level
            </label>
            <br/>
            <select style={{ borderColor:'pink',borderWidth:3, width: 350, textAlign: 'center'}} name ="level" onChange={(e) => setLevel(e.target.value)} required>
                <option value="">Select Level</option>
                {levels.map(l=><option key={l}>{l}</option>)}
            </select>
            <br/>
            <label style={{fontSize:20,paddingTop:10}}>
                Choose Index
            </label>
            <br/>
            <select style={{ borderColor:'pink',borderWidth:3, width: 350, textAlign: 'center'}} name ="index" onChange={(e) => {setIndex(e.target.value)}} required>
                <option value="">Select Index</option>
                {iList.map(i =><option key={i}>{i}</option>)}
            </select>
            <br/>
            <div style={{textAlign:'center',paddingTop:20}}>
            <Button  variant="dark" size='lg' type="submit">Get Students</Button>
            </div>
            </form>
            </div>
            {studList.length!=0?
            <div>
            <div style={{textAlign:'center',paddingTop:20}}>
                    <label style={{ fontSize:20}}>
                    Choose student
                </label>
                <br/>
                <select style={{ borderColor:'pink',borderWidth:3, width: 350, textAlign: 'center'}} name="student" onChange={(e) => setStudent(e.target.value)} required>
                    <option value="">Select Student</option>
                    {studList.map(stu=><option key={stu}>{stu}</option>)}
                </select>
                <br/>
            </div>
            <div style={{textAlign:'center',paddingTop:20}}>
            <Button variant="dark" size='lg' type="submit" onClick={ShowProgress}>View Progress</Button>               
            </div>
            </div>
                :""}
           </div> 
           </div> 
           
    )
}