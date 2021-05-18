import React, { useEffect, useState } from "react";
import { useLocation,useHistory } from "react-router-dom";
import { readWSLData, readWSData, readWLData, readWData } from "./ReadData";
import Plot from "react-plotly.js";
import {  Table } from "react-bootstrap";
import MainAppBar_ from "./MainAppBar";
import { CircularProgressbar } from 'react-circular-progressbar';
import Spinner from "./Spinner";

export default function DisplayProgressStudent() {
  const [studentData, setStudentData] = useState({});
  const [choice, setChoice] = useState(0);
  const[loading,setLoading]=useState(true)
  const location = useLocation();
  const wValues = [
    "Stage 1 Easy",
    "Stage 1 Medium",
    "Stage 1 Hard",
    "Stage 2 Easy",
    "Stage 2 Medium",
    "Stage 2 Hard",
    "Stage 3 Easy",
    "Stage 3 Medium",
    "Stage 3 Hard",
  ];
  const history=useHistory()
  const wslValues = [];
  const wsValues = ["Easy", "Medium", "Hard"];
  const wlValues = ["Stage 1", "Stage 2", "Stage 3"];
const w=location.state.world
const s=location.state.stage
const l=location.state.level
var start=0
const stu=(location.state.student).toUpperCase()
  useEffect(() => {
     start=new Date();
    if (location.state.stage != "All" && location.state.level != "All") {
      readWSLData(
        setStudentData,
        setChoice,
        location.state.student,
        location.state.world,
        location.state.stage,
        location.state.level
      );
    } else if (location.state.stage != "All" && location.state.level == "All") {
      readWSData(
        setStudentData,
        setChoice,
        location.state.student,
        location.state.world,
        location.state.stage
      );
    } else if (location.state.stage == "All" && location.state.level != "All") {
      readWLData(
        setStudentData,
        setChoice,
        location.state.student,
        location.state.world,
        location.state.level
      );
    } else if (location.state.stage == "All" && location.state.level == "All") {
      readWData(
        setStudentData,
        setChoice,
        location.state.student,
        location.state.world
      );
    }
  }, []);

  function PlotData1(props) {
    const data = props.stData;
    return (
      <div>
          <MainAppBar_/>
        <header style={{fontSize:40}}>{stu}'s Data For {w}, {s}, {l} Level </header>
        <header style={{fontSize:40}}></header>
        <Table striped bordered hover variant="dark">
          <thead>
            <tr>
              <th>Score</th>
              <th>Correct Questions</th>
              <th>Attempts</th>
              <th>Time Taken</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>{studentData[location.state.level]["score"]}</td>
              <td>{studentData[location.state.level]["correct_questions"]}</td>
              <td>{studentData[location.state.level]["attempts"]}</td>
              <td>{studentData[location.state.level]["time_taken"]}</td>
            </tr>
          </tbody>
        </Table>

        <br />
        <Plot
          data={[
            {
              x: ["Score", "Attempts", "Time Taken"],
              y: [
                studentData[location.state.level]["score"],
                studentData[location.state.level]["attempts"],
                studentData[location.state.level]["time_taken"],
              ],
              type: "bar",
            },
          ]}
          layout={{ width: 1200, height: 400, title: "Level Statistics" }}
        />
        <br />
        <br/>
        <Plot
          data={[
            {
              values: [
                studentData[location.state.level]["correct_questions"],
                10 - studentData[location.state.level]["correct_questions"],
              ],
              labels: ["Correct", "Incorrect / Not attempted"],
              type: "pie",
            },
          ]}
          layout={{
            width: 1200,
            height: 400,
            title: "Percentage of Correct Questions",
          }}
        />
        <br/>
        <br/>
        <Plot
          data={[
            {
              values: [
                studentData[location.state.level]["score"],
                130 - studentData[location.state.level]["score"],
              ],
              labels: ["Points Scored", "Points Lost"],
              type: "pie",
            },
          ]}
          layout={{
            width: 1200,
            height: 400,
            title: "Percentage of Points Scored",
          }}
        />
      </div>
    );
  }

  function CreateRow2(key) {
    return (
      <tr>
        <td>{key}</td>
        <td>{studentData[key]["score"]}</td>
        <td>{studentData[key]["correct_questions"]}</td>
        <td>{studentData[key]["attempts"]}</td>
        <td>{studentData[key]["time_taken"]}</td>
      </tr>
    );
  }

  function CreateData2(key) {
    return {
      x: ["Score", "Attempts", "Time Taken", "Correct Question"],
      y: [
        studentData[key]["score"],
        studentData[key]["attempts"],
        studentData[key]["time_taken"],
        studentData[key]["correct_questions"],
      ],
      type: "bar",
      name: key,
    };
    
  }

  function PieChartQuestions(key) {
    return (
      <Plot
        data={[
          {
            values: [
              studentData[key]["correct_questions"],
              10 - studentData[key]["correct_questions"],
            ],
            labels: ["Correct", "Incorrect / Not attempted"],
            type: "pie",
          },
        ]}
        layout={{
          width: 600,
          height: 400,
          title: "Percentage of Correct Questions - " + key,
        }}
      />
    );
  }

  function PieChartScore(key) {
    return (
      <Plot
        data={[
          {
            values: [
              studentData[key]["score"],
              130 - studentData[key]["score"],
            ],
            labels: ["Points scored", "Points lost"],
            type: "pie",
          },
        ]}
        layout={{
          width: 600,
          height: 400,
          title: "Percentage of Points Scored - " + key,
        }}
      />
    );
  }

  function PieChartTime(key) {
    return (
      <Plot
        data={[
          {
            values: [
              studentData[key]["time_taken"],
              50 - studentData[key]["time_taken"],
            ],
            labels: ["Time Used", "Time Left"],
            type: "pie",
          },
        ]}
        layout={{
          width: 600,
          height: 400,
          title: "Percentage of Time Used - " + key,
        }}
      />
    );
  }

  function PlotData2(props) {
    const data = props.stData;
    var exists = [];
    for (var k = 0; k < wsValues.length; k++) {
      if (Object.keys(studentData).includes(wsValues[k])) {
        exists.push(wsValues[k]);
      }
    }
    return (
      <div>
        <header style={{fontSize:40}}>{stu}'s Data For {w}, {s}, {l} Levels</header>
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
          <tbody>{exists.map(CreateRow2)}</tbody>
        </Table>
        <br />
        <Plot
          data={exists.map(CreateData2)}
          layout={{
            width: 600,
            height: 400,
            title: "Statistics",
            barmode: "group",
          }}
        />
        <br />
        {exists.map(PieChartQuestions)}
        <br />
        {exists.map(PieChartScore)}
        <br />
        {exists.map(PieChartTime)}
      </div>
    );
  }

  function PlotData3(props) {
    const data = props.stData;
    var exists = [];
    for (var k = 0; k < wlValues.length; k++) {
      if (Object.keys(studentData).includes(wlValues[k])) {
        exists.push(wlValues[k]);
      }
    }
    return (
      <div>
        <header style={{fontSize:40}}>{stu}'s Data For {w}, {s} Stages, {l} Level</header>
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
          <tbody>{exists.map(CreateRow2)}</tbody>
        </Table>
        <br />
        <Plot
          data={exists.map(CreateData2)}
          layout={{
            width: 600,
            height: 400,
            title: "Statistics",
            barmode: "group",
          }}
        />
        <br />
        {exists.map(PieChartQuestions)}
        <br />
        {exists.map(PieChartScore)}
        <br />
        {exists.map(PieChartTime)}
      </div>
    );
  }

  function CreateRow4(key) {
    return (
      <tr>
        <td>{key.substring(0, 7)}</td>
        <td>{key.substring(8)}</td>
        <td>{studentData[key]["score"]}</td>
        <td>{studentData[key]["correct_questions"]}</td>
        <td>{studentData[key]["attempts"]}</td>
        <td>{studentData[key]["time_taken"]}</td>
      </tr>
    );
  }

  function PieChartQuestions4(data,key) {
     return (
      <Plot
        data={[
          {
            values: [
              data[key]["correct_questions"],
              90 - data[key]["correct_questions"],
            ],
            labels: ["Correct", "Incorrect/ Unattempted "],
            type: "pie",
          },
        ]}
        layout={{
          width: 600,
          height: 400,
          title: "Percentage of Correct Questions - " + key,
        }}
      />
    );
  }

  function PieChartScore4(data,key) {
    return (
      <Plot
        data={[
          {
            values: [
                data[key]["score"],
              1170 - data[key]["score"],
            ],
            labels: ["Points scored", "Points lost"],
            type: "pie",
          },
        ]}
        layout={{
          width: 600,
          height: 400,
          title: "Percentage of Points Scored - " + key,
        }}
      />
    );
  }

  function PieChartTime4(data,key) {
    return (
      <Plot
        data={[
          {
            values: [
              data[key]["time_taken"],
              450 - data[key]["time_taken"],
            ],
            labels: ["Time Used", "Time Left"],
            type: "pie",
          },
        ]}
        layout={{
          width: 600,
          height: 400,
          title: "Percentage of Time Used - " + key,
        }}
      />
    );
  }


  function CreateData4(key, data) {
  
    return {
      x: ["Score", "Attempts", "Time Taken", "Correct Question"],
      y: [
        data[key]["score"],
        data[key]["attempts"],
        data[key]["time_taken"],
        data[key]["correct_questions"],
      ],
      type: "bar",
      name: key,
    };
  }

  function PlotData4(props) {
    var exists = [];
    for (var k = 0; k < wValues.length; k++) {
      if (Object.keys(studentData).includes(wValues[k])) {
        exists.push(wValues[k]);
      }
    }
    var stagewise = {
      "Stage 1": { correct_questions: 0, score: 0, time_taken: 0, attempts: 0 },
      "Stage 2": { correct_questions: 0, score: 0, time_taken: 0, attempts: 0 },
      "Stage 3": { correct_questions: 0, score: 0, time_taken: 0, attempts: 0 },
    };
    var levelwise = {
      Easy: { correct_questions: 0, score: 0, time_taken: 0, attempts: 0 },
      Medium: { correct_questions: 0, score: 0, time_taken: 0, attempts: 0 },
      Hard: { correct_questions: 0, score: 0, time_taken: 0, attempts: 0 },
    };
    for (var key in studentData) {
      stagewise[key.substring(0, 7)]["correct_questions"] +=
        studentData[key]["correct_questions"];
      stagewise[key.substring(0, 7)]["score"] += studentData[key]["score"];
      stagewise[key.substring(0, 7)]["time_taken"] +=
        studentData[key]["time_taken"];
      stagewise[key.substring(0, 7)]["attempts"] +=
        studentData[key]["attempts"];

      levelwise[key.substring(8)]["correct_questions"] +=
        studentData[key]["correct_questions"];
      levelwise[key.substring(8)]["score"] += studentData[key]["score"];
      levelwise[key.substring(8)]["time_taken"] +=
        studentData[key]["time_taken"];
      levelwise[key.substring(8)]["attempts"] += studentData[key]["attempts"];
    }

    var stageTotal = {total: { correct_questions: 0, score: 0, time_taken: 0, attempts: 0 },}
    for (var key in stagewise){
        stageTotal["total"]["correct_questions"] += stagewise[key]["correct_questions"];
        stageTotal["total"]["score"] += stagewise[key]["score"];
        stageTotal["total"]["time_taken"] += stagewise[key]["time_taken"];
        stageTotal["total"]["attempts"] += stagewise[key]["attempts"];    
    }
    return (
      <div>
        <header style={{fontSize:40}}>{stu}'s Data For {w}, {s} Stages, {l} Levels</header>
        <Table striped bordered hover variant="dark">
          <thead>
            <tr>
              <th>Stage</th>
              <th>Level</th>
              <th>Score</th>
              <th>Correct Questions</th>
              <th>Attempts</th>
              <th>Time Taken</th>
            </tr>
          </thead>
          <tbody>{exists.map(CreateRow4)}</tbody>
        </Table>
        <br />
        <Plot
          data={[
            CreateData4("Stage 1", stagewise),
            CreateData4("Stage 2", stagewise),
            CreateData4("Stage 3", stagewise),
          ]}
          layout={{
            width: 600,
            height: 400,
            title: "Statistics",
            barmode: "group",
          }}
        />
        <br />
        <Plot
          data={[
            CreateData4("Easy", levelwise),
            CreateData4("Medium", levelwise),
            CreateData4("Hard", levelwise),
          ]}
          layout={{
            width: 600,
            height: 400,
            title: "Statistics",
            barmode: "group",
          }}
        />
        <br/>
        {PieChartQuestions4(stageTotal,"total")}
      <br/> 
        {PieChartScore4(stageTotal,"total")}
        <br/>
        {PieChartTime4(stageTotal,"total")}
    </div>
    );
  }

  return (
    <div style={{textAlign:'center' ,height:2500,width:'100vw',backgroundSize: 'cover',backgroundColor: '#efefef', backgroundImage:"url(/backgroundpic1.jpg)", backgroundPosition:"Center"}}>
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
      ) : (
          <div>
            <div>
            <header style={{textAlign:"center", fontSize:30}}>No data found yet</header>
            </div>
            <Spinner/>
            </div>
      )}
    </div>
  );
}