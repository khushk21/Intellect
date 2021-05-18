import firebase from "firebase";
async function readIndexList(set_function){
    const db=firebase.firestore();
    const indexList=[]
    var user=firebase.auth().currentUser;
    var email=user.email;
   const data= await db.collection("Teacher").get()
   data.docs.forEach((doc)=>{
       if(doc.id==email){
           var temp=doc.data()
           set_function(temp["index"])
        }
   })
}
         
            
export default readIndexList;