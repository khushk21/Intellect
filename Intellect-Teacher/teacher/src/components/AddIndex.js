import React from "react";
import firebase from "firebase";
import MainAppBar_ from "./MainAppBar";
import {  Button } from "react-bootstrap";
class AddIndex extends React.Component {
    constructor() {
        super();
        this.state = {
         index:""
        };
      }
      updateInput = e => {
        this.setState({
          [e.target.name]: e.target.value
        });
      }
      addIndex = async e  =>  { 
         e.preventDefault();
        const db = firebase.firestore();
        var user=firebase.auth().currentUser;
        var email=user.email;
         await db.collection("Teacher").doc(email).get().then(async (doc) => {
            if (doc.exists) {
                var data=doc.data()['index'];
                if(data.includes(this.state.index)){
                    alert("Index already exists. Try again.")
                this.setState({index:""})
                }
             else {
                data.push(this.state.index)
                await db.collection("Teacher").doc(email).update({"index":data})
                alert("New class index has been added!")
                this.setState({index:""})
            }
        }
        })
      };
    render() {
    return (
      <div>
      <MainAppBar_/>
      <div>
      <h3 style={{ paddingTop: 100,textAlign:"center",fontSize:40}}>Add Class Index</h3>
        <div className="d-flex align-items-center justify-content-center"
        style={{ minHeight: "20vh"}}>
        <form onSubmit={this.addIndex}>
        <input style={{borderColor:"pink",borderWidth:3,textAlign: 'center' ,width:350}}
            type="text"
            name="index"
            placeholder="Enter new class index"
            onChange={this.updateInput}
            value={this.state.index}
           required/>
           <br/>
           <div style={{paddingTop:20,textAlign:'center',}}>
           <Button variant='dark' size='lg' type="submit">Add Index</Button>
           </div>
           </form>
        </div>
        </div>  
        </div>
        );
        
      }
      
   }
  
   
export default AddIndex;

