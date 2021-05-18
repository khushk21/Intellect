import React,{useState,useEffect} from 'react'
import {useHistory} from "react-router-dom"
import { readAssignmentData } from './ReadData'
import MainAppBar_ from "./MainAppBar"
import firebase from "firebase";
import {Button} from 'react-bootstrap';
import Spinner from "./Spinner"
export default function AssignmentProgress() {
    const [assignmentData,setAssignmentData]=useState({})
    const [code,setCode]=useState([])
    const [title,setTitle]=useState()
    const history=useHistory()

    useEffect(()=>{
        var user=firebase.auth().currentUser;
        readAssignmentData(user.email,setAssignmentData,setCode)
    },[])
    function ShowProgress(event){
        event.preventDefault()
        var currentData={}
        for(var i in assignmentData){
            if(assignmentData[i]["title"]==title){
                currentData=assignmentData[i]
                break;
            }
        }
        history.push({
            pathname:"/displayassignmentprogress",
            state:{currentData:currentData}
        })
    }
    return (
        <div>
             <MainAppBar_/>
             <div style={{textAlign:'center'}}>
             <form onSubmit={ShowProgress} >
               {code.length!=0?<div style={{textAlign:'center',paddingTop:50}}>
            <label style={{fontSize:40}}>
                Check Assignment Progress
            </label>
            <br/>
            <select style={{ borderColor:'pink',borderWidth:3, width: 350, textAlign: 'center'}} name ="title" onChange={(e) => setTitle(e.target.value)} required>
                <option value="">Select Assignment</option>
                {code.map(c=><option key={c}>{c}</option>)}
            </select>
            <br/>
            
            <div style={{textAlign:'center',paddingTop:20}}>
                <Button type="submit" variant="dark" size='lg'>Submit</Button>
              </div>
            </div> :<div>
                <Spinner/>
                </div>}
            </form>
             </div>
            
        </div>
    )
}
