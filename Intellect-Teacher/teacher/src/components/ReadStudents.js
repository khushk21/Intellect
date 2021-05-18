import firebase from "firebase";
async function readStudents(classIndex,set_function) {
    const db=firebase.firestore();
    var studentList=[]
    const data= await db.collection.where("class_index","==",classIndex).get();
    data.docs.forEach((doc)=>{
        var temp=doc.data()
        studentList.push(doc.id)

    })
    set_function(studentList)
}
export default readStudents;