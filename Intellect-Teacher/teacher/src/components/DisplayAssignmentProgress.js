import React from 'react'
import { useLocation } from "react-router-dom";
import MainAppBar_ from "./MainAppBar";
import {Table} from "react-bootstrap";
import Plot from "react-plotly.js";

export default function DisplayAssignmentProgress() {

    const location=useLocation()
    console.log(location.state.currentData)
    var data = location.state.currentData
    var passedStudent=[]
    var average =0
    var scoreDist = {
        "0-40":0,
        "41-80":0,
        "81-110":0
    }
    for(var i in data['cleared_student']){
        average+=data['cleared_student'][i]['score']
        if(data['cleared_student'][i]['score'] <= 40)
            scoreDist['0-40']++
        else if(data['cleared_student'][i]['score'] <= 80)
            scoreDist['41-80']++
        else if(data['cleared_student'][i]['score'] > 80)
            scoreDist['81-110']++
    }
    average = average/(data['cleared_student'].length)
    return (
        <div style={{textAlign:'center' ,height:2500,width:'100vw',backgroundSize: 'cover',backgroundColor: '#efefef', backgroundImage:"url(/backgroundpic1.jpg)", backgroundPosition:"Center"}}>
             <MainAppBar_/>
             
            {data['assignment_code']} - {data['title']}
            <br/>
            Due on {data['dueDate'].substring(0,10)}
            <br/>
            World - {data['world']}
            <br/>
            Class Index - {data['class_index']}
            <br/>
            Students who passed: 
            <Table striped bordered hover variant="dark">
                <thead>
                    <tr>
                    <th>Student</th>
                    <th>Score</th>
                    </tr>
                </thead>
                <tbody>
                     {data['cleared_student'].map((item)=>{
                         passedStudent.push(item['student'])
                         return (
                            <tr>
                                <td>{item["student"]}</td>
                                <td>{item["score"]}</td>
                            </tr>
                 );})}
                </tbody>
            </Table>
            Students who failed:
            <Table striped bordered hover variant="dark">
                <thead>
                    <tr>
                    <th>Student</th>
                    </tr>
                </thead>
                <tbody>
                     {(data['attempted_students'].filter(x => !passedStudent.includes(x)).map((item)=>{
                         return (
                            <tr>
                                <td>{item}</td>
                            </tr>
                 );}))}
                </tbody>
            </Table>

            <Plot data={[
                    {
                        x: data['cleared_student'].map((item)=>{
                            return item['student']}),
                        y: data['cleared_student'].map((item)=>{
                            return item['score']}),
                            type: "bar",
                    },
                ]} layout={{ width: 600, height: 400, title: "Student Scores" }} />

            <br/>

            <Plot
                data={[{
                    values: [average,
                        110 - average,],
                    labels: ["Average Points Scored", "Average Points Lost"],
                    type: "pie",
                    },
                ]} layout={{
                    width: 600,
                    height: 400,
                    title: "Average Score",
                }}
            />
            <br/>
            <Plot data={[
                    {
                        x:  ["0-40","41-80","81-110",],
                        y: [scoreDist["0-40"],scoreDist["41-80"],scoreDist["81-110"]],
                            type: "bar",
                    },
                ]} layout={{ width: 600, height: 400, title: "Student Score Distribution" }} />
            </div>
    )
}