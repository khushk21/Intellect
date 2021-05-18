import React from "react";
import { AuthProvider } from "../contexts/AuthContext";
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";
import Dashboard from "./Dashboard";
import Login from "./Login";
import PrivateRoute from "./PrivateRoute";
import ForgotPassword from "./ForgotPassword";
import UpdateProfile from "./UpdateProfile";
import CreateStudent from "./CreateStudent";
import EditQuestionBank from "./EditQuestionBank";
import DeleteQuestion from "./DeleteQuestion";
import Assignment from "./Assignment";
import DeleteStudent from "./DeleteStudent";
import ClassProgress from "./ClassProgress";
import DisplayProgressStudent from "./DisplayProgressStudent";
import DisplayProgressAll from "./DisplayProgressAll";
import AssignmentProgress from "./AssignmentProgress";
import DisplayAssignmentProgress from "./DisplayAssignmentProgress";
import AddIndex from "./AddIndex";
function App() {
  return (
    <div style={{ height:1000,width:'100vw',backgroundSize: 'cover',backgroundColor: '#efefef', backgroundImage:"url(/backgroundpic1.jpg)", backgroundPosition:"Center"}}>
        <Router>
          <AuthProvider>
            <Switch>
              <PrivateRoute exact path="/" component={Dashboard} />
              {/* <PrivateRoute path="/update-profile" component={UpdateProfile} /> */}
              {/* <Route path="/signup" component={Signup} /> */}
              <Route path="/login" component={Login} />
              <Route path="/createstudent" component={CreateStudent} />
              <Route path="/forgot-password" component={ForgotPassword} />
              <Route path="/deletequestion" component={DeleteQuestion}/>
              <Route path="/addquestion" component={EditQuestionBank}/>
              <Route path="/sendassignment" component={Assignment}/>
              <Route path="/deletestudent" component={DeleteStudent}/>
              <Route path="/progress" component={ClassProgress}/>
              <Route path="/displaystudentprogress" component={DisplayProgressStudent}/>
              <Route path="/displayallprogress" component={DisplayProgressAll}/>
              <Route path="/progressassignment" component={AssignmentProgress}/>
              <Route path="/displayassignmentprogress" component={DisplayAssignmentProgress}/>
              <Route path="/addclassindex" component={AddIndex}/>
            </Switch>
          </AuthProvider>
        </Router>

  </div>
  );
}

export default App;
