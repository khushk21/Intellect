import React, { useEffect, useState } from 'react'
import { useLocation } from "react-router-dom";
import {readAllWSLData,readAllWSData,readAllWLData,readAllWData} from './ReadData';
import Plot from "react-plotly.js";
import {Table} from "react-bootstrap";
import MainAppBar_ from './MainAppBar';
import Spinner from './Spinner';
export default function DisplayProgressAll() {
    const [studentData,setStudentData]=useState({})
    const [indStudentData,setIndStudentData]=useState({})    
    const [choice,setChoice]=useState(0)
    const location=useLocation()
    const studentList=location.state.studList.slice(0,-1)
    const w=location.state.world
    const s=location.state.stage
    const l=location.state.level
    useEffect( ()=>{
        if(location.state.stage!="All" && location.state.level !="All"){
            (readAllWSLData(setStudentData,setChoice,location.state.world,location.state.stage,location.state.level,studentList,setIndStudentData))
        }
        else if(location.state.stage!="All" && location.state.level =="All"){
            readAllWSData(setStudentData,setChoice,location.state.world,location.state.stage,studentList,setIndStudentData)
                }
        else if(location.state.stage=="All" && location.state.level !="All"){
            readAllWLData(setStudentData,setChoice,location.state.world,location.state.level,studentList,setIndStudentData)
        }
        else if(location.state.stage=="All" && location.state.level =="All"){
            readAllWData(setStudentData,setChoice,location.state.world,studentList,setIndStudentData)
            }
    },[])

    function CreateRowWSLindi(key) {
        return (
          <tr>
            <td>{key}</td>
            <td>{indStudentData[key]["score"]}</td>
            <td>{indStudentData[key]["correctQuestions"]}</td>
            <td>{indStudentData[key]["attempts"]}</td>
            <td>{indStudentData[key]["time"]}</td>
          </tr>
        );
      }

      function CreateRowWSLaverage() {
        return (
          <tr>
            <td>{studentData["totalScore"]}</td>
            <td>{studentData["totalCorrectQuestions"]}</td>
            <td>{studentData["totalAttempts"]}</td>
            <td>{studentData["totalTime"]}</td>
          </tr>
        );
      }

      function DistGraphs(){
        var timeDist = {"0":0,"1-10":0,"11-20":0,"21-30":0,"31-40":0,"41-50":0}
        var scoreDist = {"0":0,"1-40":0,"41-80":0,"81-120":0,"121-130":0}
        var cqDist = {"0":0,"1-3":0,"4-6":0,"7-9":0,"10":0}
        var attemptDist = {"< 5":0,"5-10":0,"> 10":0}
        for(var key in indStudentData){
            if(indStudentData[key]["time"]<=1)
                timeDist["0"] += 1
            else if(indStudentData[key]["time"]<=10 )
                timeDist["1-10"] += 1
            else if(indStudentData[key]["time"]<=20)
                timeDist["11-20"] += 1
            else if(indStudentData[key]["time"]<=30)
                timeDist["21-30"] += 1
            else if(indStudentData[key]["time"]<=40)
                timeDist["31-40"] += 1
            else if(indStudentData[key]["time"]<=50)
                timeDist["41-50"] += 1
            
            if(indStudentData[key]["score"]==0)
                scoreDist["0"]+=1
            else if(indStudentData[key]["score"]<=40 )
                scoreDist["1-40"] += 1
            else if(indStudentData[key]["score"]<=80)
                scoreDist["41-80"] += 1
            else if(indStudentData[key]["score"]<=120)
                scoreDist["81-120"] += 1
            else if(indStudentData[key]["score"]<=130)
                scoreDist["121-130"] += 1

            if(indStudentData[key]["correctQuestions"]==0)
                cqDist["0"]+=1
            else if(indStudentData[key]["correctQuestions"]<=3 )
                cqDist["1-3"] += 1
            else if(indStudentData[key]["correctQuestions"]<=6)
                cqDist["4-6"] += 1
            else if(indStudentData[key]["correctQuestions"]<=9)
                cqDist["7-9"] += 1
            else if(indStudentData[key]["correctQuestions"]==10)
                cqDist["10"] += 1

            if(indStudentData[key]["attempts"]<5)
                attemptDist["< 5"]+=1
            else if(indStudentData[key]["attempts"]<=10 )
                attemptDist["5-10"] += 1
            else if(indStudentData[key]["attempts"]>10)
                attemptDist["> 10"] += 1
        } 

        return (<div>
        <Plot
          data={[
            {
              x: ["0","1-10","11-20","21-30","31-40","41-50"],
              y: 
                [timeDist["0"],timeDist["1-10"],timeDist["11-20"],timeDist["21-30"],timeDist["31-40"],timeDist["41-50"]],
              type: "bar",
            },
          ]}
          layout={{ width: 600, height: 400, title: "Time Distribution" }}
        />
         <Plot
          data={[
            {
              x: ["0","1-40","41-80","81-120","121-130"],
              y: 
                [scoreDist["0"],scoreDist["1-40"],scoreDist["41-80"],scoreDist["81-120"],scoreDist["121-130"]],
              type: "bar",
            },
          ]}
          layout={{ width: 600, height: 400, title: "Score Distribution" }}
        />
        <br/>
        <Plot
          data={[
            {
              x: ["0","1-3","4-6","7-9","10-"],
              y: [cqDist["0"],cqDist["1-3"],cqDist["4-6"],cqDist["7-9"],cqDist["10"]],
              type: "bar",
            },
          ]}
          layout={{ width: 600, height: 400, title: "Correct Question Distribution" }}
        />
        <Plot
          data={[
            {
              x: ["< 5","5-10","> 10"],
              y: [attemptDist['< 5'],attemptDist['5-10'],attemptDist['> 10']],
              type: "bar",
            },
          ]}
          layout={{ width: 600, height: 400, title: "Attempts Distribution" }}
        /></div>
        )
      }

    function PlotData1(props){
         
        return (
        <div>
            <header style={{fontSize:40}}>Individual Student Data For {w}, {s}, {l} Level</header>
            <Table striped bordered hover variant="dark">
            <thead>
                <tr>
                <th>Student</th>
                <th>Score</th>
                <th>Correct Questions</th>
                <th>Attempts</th>
                <th>Time Taken</th>
                </tr>
            </thead>
            <tbody>{Object.keys(indStudentData).map(CreateRowWSLindi)}</tbody>
            </Table>
            <br/>
            <br/>
            <header  style={{fontSize:40}}>Average Student Data For {w}, {s}, {l} Level</header>
            <Table striped bordered hover variant="dark">
            <thead>
                <tr>
                <th>Score</th>
                <th>Correct Questions</th>
                <th>Attempts</th>
                <th>Time Taken</th>
                </tr>
            </thead>
            <tbody>{CreateRowWSLaverage()}</tbody>
            </Table>
            <br/>
            <br/>
            {DistGraphs()}
        </div>)
    }

    function CreateRowWSaverage(key) {
        return (
          <tr>
              <td>{key}</td>
            <td>{studentData[key]["totalScore"]}</td>
            <td>{studentData[key]["totalCorrectQuestions"]}</td>
            <td>{studentData[key]["totalAttempts"]}</td>
            <td>{studentData[key]["totalTime"]}</td>
          </tr>
        );
      }

    function PlotData2(props){
        return (
        <div>
            <header style={{fontSize:40}}>Individual Student Data For {w}, {s}, {l} Levels</header>
            <Table striped bordered hover variant="dark">
            <thead>
                <tr>
                <th>Student</th>
                <th>Score</th>
                <th>Correct Questions</th>
                <th>Attempts</th>
                <th>Time Taken</th>
                </tr>
            </thead>
            <tbody>{Object.keys(indStudentData).map(CreateRowWSLindi)}</tbody>
            </Table>
            <br/>
            <br/>
            <header style={{fontSize:40}}>Average Student Data For {w}, {s}, {l} Levels</header>
            <Table striped bordered hover variant="dark">
            <thead>
                <tr>
                    <th>Level</th>
                <th>Score</th>
                <th>Correct Questions</th>
                <th>Attempts</th>
                <th>Time Taken</th>
                </tr>
            </thead>
            <tbody>{["Easy","Medium","Hard"].map(CreateRowWSaverage)}</tbody>
            </Table>
            <br/>
            <br/>
            {DistGraphs()}
        </div>)
        
    }
    function PlotData3(props){
        return (
            <div>
                <header style={{fontSize:40}}>Individual Student Data For {w}, {s} Stages, {l} Level</header>
                <Table striped bordered hover variant="dark">
                <thead>
                    <tr>
                    <th>Student</th>
                    <th>Score</th>
                    <th>Correct Questions</th>
                    <th>Attempts</th>
                    <th>Time Taken</th>
                    </tr>
                </thead>
                <tbody>{Object.keys(indStudentData).map(CreateRowWSLindi)}</tbody>
                </Table>
                <br/>
                <br/>
           
                <header style={{fontSize:40}}>Average Student Data For {w}, {s} Stages, {l} Level</header>
                <Table striped bordered hover variant="dark">
                <thead>
                    <tr>
                    <th>Stage</th>
                    <th>Score</th>
                    <th>Correct Questions</th>
                    <th>Attempts</th>
                    <th>Time Taken</th>
                    </tr>
                </thead>
                <tbody>{["Stage 1 "+location.state.level,"Stage 2 "+location.state.level,"Stage 3 "+location.state.level,].map(CreateRowWSaverage)}</tbody>
                </Table>
                <br/>
                <br/>
                {DistGraphs()}

                </div>
                )
    }
    
    function PlotData4(props){
        return (
        <div>
            <header style={{fontSize:40}}>Individual Student Data For {w}, {s} Stages, {l} Levels</header>
            <Table striped bordered hover variant="dark">
            <thead>
                <tr>
                <th>Student</th>
                <th>Score</th>
                <th>Correct Questions</th>
                <th>Attempts</th>
                <th>Time Taken</th>
                </tr>
            </thead>
            <tbody>{Object.keys(indStudentData).map(CreateRowWSLindi)}</tbody>
            </Table>
            <br/>
            <br/>
            <header style={{fontSize:40}}>Average Student Data For {w}, {s} Stages, {l} Levels</header>
            <Table striped bordered hover variant="dark">
            <thead>
                <tr>
                <th>Stage</th>
                <th>Score</th>
                <th>Correct Questions</th>
                <th>Attempts</th>
                <th>Time Taken</th>
                </tr>
            </thead>
            <tbody>{["Stage 1","Stage 2","Stage 3"].map(CreateRowWSaverage)}</tbody>
            </Table>
            <br/>
            <br/>
                {DistGraphs()}
        </div>)
    }
    return (
        <div style={{textAlign:'center' ,height:2500,width:'100vw',backgroundSize: 'cover',backgroundColor: '#efefef', backgroundImage:"url(/backgroundpic1.jpg)", backgroundPosition:"Center"}}>
            <MainAppBar_/>
      {Object.keys(studentData).length != 0 ? (
        choice == 1 ? (
          <PlotData1 stData={studentData} />
        ) : choice == 2 ? (
          <PlotData2 stData={studentData} />
        ) : choice == 3 ? (
          <PlotData3 stData={studentData} />
        ) : choice == 4 ? (
          <PlotData4 stData={studentData} />
        ) : (
          "No data"
        )
      ) : <div>
      <div>
            <div>
            <header style={{textAlign:"center", fontSize:30}}>No data found yet</header>
            </div>
            <Spinner/>
            </div>
    </div>
  }
    </div>
    )
}