import firebase from "firebase";
export async function readWSLData(set_function, setChoice, student, world, stage, level) {
    const db = firebase.firestore()
    setChoice(1)
    var studentData = {}
    const data = await db.collection("Students").doc(student).collection(world).get()
    if (data.empty == false) {
        data.docs.forEach((doc) => {
            if (doc.id == stage) {
                var temp = doc.data()['Levels']
                for (var i in temp) {
                    if (i == level) {
                        console.log(temp)
                        studentData[level] = temp[i]
                        break;
                    }
                }
            }
        })
    }
    console.log(studentData)
    set_function(studentData)
}
export async function readWSData(set_function, setChoice, student, world, stage) {
    const db = firebase.firestore()
    var studentData = {}
    setChoice(2)
    const data = await db.collection("Students").doc(student).collection(world).get()
    if (!data.empty) {
        data.docs.forEach((doc) => {
            if (doc.id == stage) {
                var temp = doc.data()['Levels']
                for (var level in temp) {
                    studentData[level] = temp[level]
                }
            }
        })
    }
    set_function(studentData)
}

export async function readWLData(set_function, setChoice, student, world, level) {
    const db = firebase.firestore()
    var studentData = {}
    setChoice(3)
    const data = await db.collection("Students").doc(student).collection(world).get()
    if (!data.empty) {
        data.docs.forEach((doc) => {
            var temp = doc.data()['Levels']
            for (var l in temp) {
                if (l == level) {
                    studentData[doc.id] = temp[l]
                }
            }
        })
    }
    set_function(studentData)
}

export async function readWData(set_function, setChoice, student, world) {
    const db = firebase.firestore()
    var studentData = {}
    setChoice(4)
    const data = await db.collection("Students").doc(student).collection(world).get()
    if (!data.empty) {
        data.docs.forEach((doc) => {
            var temp = doc.data()['Levels']
            for (var l in temp) {
                studentData[doc.id + " " + l] = temp[l]
            }
        })
    }
    set_function(studentData)
}
export async function readAllWSLData(set_function, setChoice, world, stage, level, studentList, setIndividual) {
    var studentData = {
        "totalScore": 0,
        "totalAttempts": 0,
        "totalCorrectQuestions": 0,
        "totalTime": 0
    }
    const db = firebase.firestore();
    var singleStudent = {}
    setChoice(1)
    for (var i = 0; i < studentList.length; i++) {
        singleStudent[studentList[i]] = {
            "score": 0,
            "attempts": 0,
            "correctQuestions": 0,
            "time": 0
        }
        const data = await db.collection("Students").doc(studentList[i]).collection(world).get()
        if (data.empty == false) {
            data.docs.forEach((doc) => {
                if (doc.id == stage) {
                    var temp = doc.data()['Levels']
                    for (var j in temp) {
                        if (j == level) {
                            singleStudent[studentList[i]]["score"] = temp[j]["score"]
                            singleStudent[studentList[i]]["attempts"] = temp[j]["attempts"]
                            singleStudent[studentList[i]]["correctQuestions"] = temp[j]["correct_questions"]
                            singleStudent[studentList[i]]["time"] = temp[j]["time_taken"]
                            studentData["totalScore"] += temp[j]["score"]
                            studentData["totalAttempts"] += temp[j]["attempts"]
                            studentData["totalCorrectQuestions"] += temp[j]["correct_questions"]
                            studentData["totalTime"] += temp[j]["time_taken"]
                            break;
                        }
                    }
                }
            })
        }
    }
    setIndividual(singleStudent)
    studentData["totalScore"] = (studentData["totalScore"] / studentList.length).toFixed(2)
    studentData["totalAttempts"] = (studentData["totalAttempts"] / studentList.length).toFixed(2)
    studentData["totalCorrectQuestions"] = (studentData["totalCorrectQuestions"] / studentList.length).toFixed(2)
    studentData["totalTime"] = (studentData["totalTime"] / studentList.length).toFixed(2)
    set_function(studentData)
}
export async function readAllWSData(set_function, setChoice, world, stage, studentList, setIndividual) {
    var studentData = {
        "Easy": {
            "totalScore": 0,
            "totalAttempts": 0,
            "totalCorrectQuestions": 0,
            "totalTime": 0
        },
        "Medium": {
            "totalScore": 0,
            "totalAttempts": 0,
            "totalCorrectQuestions": 0,
            "totalTime": 0
        },
        "Hard": {
            "totalScore": 0,
            "totalAttempts": 0,
            "totalCorrectQuestions": 0,
            "totalTime": 0
        }
    }
    const db = firebase.firestore()
    var singleStudent = {}
    setChoice(2)
    for (var i = 0; i < studentList.length; i++) {
        singleStudent[studentList[i]] = {
            "score": 0,
            "time": 0,
            "correctQuestions": 0,
            "attempts": 0
        }
        const data = await db.collection("Students").doc(studentList[i]).collection(world).get()
        if (data.empty == false) {
            data.docs.forEach((doc) => {
                if (doc.exists) {
                    if (doc.id == stage) {
                        var temp = doc.data()["Levels"]
                        for (var xyz in temp) {
                            singleStudent[studentList[i]]["score"] += temp[xyz]["score"]
                            singleStudent[studentList[i]]["time"] += temp[xyz]["time_taken"]
                            singleStudent[studentList[i]]["correctQuestions"] += temp[xyz]["correct_questions"]
                            singleStudent[studentList[i]]["attempts"] += temp[xyz]["attempts"]
                            studentData[xyz]["totalScore"] += temp["Easy"]["score"]
                            studentData[xyz]["totalCorrectQuestions"] += temp["Easy"]["correct_questions"]
                            studentData[xyz]["totalAttempts"] += temp["Easy"]["attempts"]
                            studentData[xyz]["totalTime"] += temp["Easy"]["time_taken"]
                        }
                    }
                }
            })
        }
        singleStudent[studentList[i]]["score"] = (singleStudent[studentList[i]]["score"] / 3).toFixed(2)
        singleStudent[studentList[i]]["time"] = (singleStudent[studentList[i]]["time"] / 3).toFixed(2)
        singleStudent[studentList[i]]["correctQuestions"] = (singleStudent[studentList[i]]["correctQuestions"] / 3).toFixed(2)
        singleStudent[studentList[i]]["attempts"] = (singleStudent[studentList[i]]["attempts"] / 3).toFixed(2)

    }
    setIndividual(singleStudent)["Easy", "Medium", "Hard"].forEach((item) => {
        studentData[item]["totalScore"] = (studentData[item]["totalScore"] / studentList.length).toFixed(2)
        studentData[item]["totalAttempts"] = (studentData[item]["totalAttempts"] / studentList.length).toFixed(2)
        studentData[item]["totalCorrectQuestions"] = (studentData[item]["totalCorrectQuestions"] / studentList.length).toFixed(2)
        studentData[item]["totalTime"] = (studentData[item]["totalTime"] / studentList.length).toFixed(2)

    })
    set_function(studentData)
}
export async function readAllWLData(set_function, setChoice, world, level, studentList, setIndividual) {
    var stage1 = "Stage 1 " + level
    var stage2 = "Stage 2 " + level
    var stage3 = "Stage 3 " + level
    var studentData = {}
    var s1 = {
        "totalScore": 0,
        "totalAttempts": 0,
        "totalCorrectQuestions": 0,
        "totalTime": 0
    }
    var s2 = {
        "totalScore": 0,
        "totalAttempts": 0,
        "totalCorrectQuestions": 0,
        "totalTime": 0
    }
    var s3 = {
        "totalScore": 0,
        "totalAttempts": 0,
        "totalCorrectQuestions": 0,
        "totalTime": 0
    }
    var singleStudent = {}
    const db = firebase.firestore()
    setChoice(3)
    for (var i = 0; i < studentList.length; i++) {
        singleStudent[studentList[i]] = {
            "score": 0,
            "time": 0,
            "attempts": 0,
            "correctQuestions": 0
        }
        const data = await db.collection("Students").doc(studentList[i]).collection(world).get()
        if (data.empty == false) {
            data.docs.forEach((doc) => {
                if (doc.exists) {
                    var temp = doc.data()["Levels"]
                    for (var key in temp) {
                        if (Object.keys(temp).includes(level)) {
                            singleStudent[studentList[i]]["score"] += temp[level]["score"]
                            singleStudent[studentList[i]]["attempts"] += temp[level]["attempts"]
                            singleStudent[studentList[i]]["correctQuestions"] += temp[level]["correct_questions"]
                            singleStudent[studentList[i]]["time"] += temp[level]["time_taken"]

                            if (doc.id == "Stage 1") {
                                s1["totalTime"] += temp[level]["time_taken"]
                                s1["totalCorrectQuestions"] += temp[level]["correct_questions"]
                                s1["totalScore"] += temp[level]["score"]
                                s1["totalAttempts"] += temp[level]["attempts"]
                            } else if (doc.id == "Stage 2") {
                                s2["totalTime"] += temp[level]["time_taken"]
                                s2["totalCorrectQuestions"] += temp[level]["correct_questions"]
                                s2["totalScore"] += temp[level]["score"]
                                s2["totalAttempts"] += temp[level]["attempts"]
                            } else if (doc.id == "Stage 3") {
                                s3["totalTime"] += temp[level]["time_taken"]
                                s3["totalCorrectQuestions"] += temp[level]["correct_questions"]
                                s3["totalScore"] += temp[level]["score"]
                                s3["totalAttempts"] += temp[level]["attempts"]
                            }
                        }
                    }
                }
            })
        }
        singleStudent[studentList[i]]["score"] = (singleStudent[studentList[i]]["score"] / 3).toFixed(2)
        singleStudent[studentList[i]]["time"] = (singleStudent[studentList[i]]["time"] / 3).toFixed(2)
        singleStudent[studentList[i]]["correctQuestions"] = (singleStudent[studentList[i]]["correctQuestions"] / 3).toFixed(2)
        singleStudent[studentList[i]]["attempts"] = (singleStudent[studentList[i]]["attempts"] / 3).toFixed(2)
    }
    s1["totalScore"] = (s1["totalScore"] / studentList.length).toFixed(2)
    s1["totalTime"] = (s1["totalTime"] / studentList.length).toFixed(2)
    s1["totalCorrectQuestions"] = (s1["totalCorrectQuestions"] / studentList.length).toFixed(2)
    s1["totalAttempts"] = (s1["totalAttempts"] / studentList.length).toFixed(2)

    s2["totalScore"] = (s2["totalScore"] / studentList.length).toFixed(2)
    s2["totalTime"] = (s2["totalTime"] / studentList.length).toFixed(2)
    s2["totalCorrectQuestions"] = (s2["totalCorrectQuestions"] / studentList.length).toFixed(2)
    s2["totalAttempts"] = (s2["totalAttempts"] / studentList.length).toFixed(2)

    s3["totalScore"] = (s3["totalScore"] / studentList.length).toFixed(2)
    s3["totalTime"] = (s3["totalTime"] / studentList.length).toFixed(2)
    s3["totalCorrectQuestions"] = (s3["totalCorrectQuestions"] / studentList.length).toFixed(2)
    s3["totalAttempts"] = (s3["totalAttempts"] / studentList.length).toFixed(2)
    studentData[stage1] = s1
    studentData[stage2] = s2
    studentData[stage3] = s3
    set_function(studentData)
    setIndividual(singleStudent)
}
export async function readAllWData(set_function, setChoice, world, studentList, setIndividual) {
    const db = firebase.firestore()
    var studentData = {}
    var s1 = {
        "totalScore": 0,
        "totalAttempts": 0,
        "totalCorrectQuestions": 0,
        "totalTime": 0
    }
    var s2 = {
        "totalScore": 0,
        "totalAttempts": 0,
        "totalCorrectQuestions": 0,
        "totalTime": 0
    }
    var s3 = {
        "totalScore": 0,
        "totalAttempts": 0,
        "totalCorrectQuestions": 0,
        "totalTime": 0
    }
    var singleStudent = {}
    setChoice(4)
    for (var i = 0; i < studentList.length; i++) {
        singleStudent[studentList[i]] = {
            "score": 0,
            "attempts": 0,
            "correctQuestions": 0,
            "time": 0
        }
        const data = await db.collection("Students").doc(studentList[i]).collection(world).get()
        if (data.empty == false) {
            data.docs.forEach((doc) => {
                if (doc.exists) {
                    var temp = doc.data()["Levels"]
                    for (var xyz in temp) {
                        singleStudent[studentList[i]]["score"] += temp[xyz]["score"]
                        singleStudent[studentList[i]]["correctQuestions"] += temp[xyz]["correct_questions"]
                        singleStudent[studentList[i]]["time"] += temp[xyz]["time_taken"]
                        singleStudent[studentList[i]]["attempts"] += temp[xyz]["attempts"]
                        if (doc.id == "Stage 1") {
                            s1["totalTime"] += temp[xyz]["time_taken"]
                            s1["totalCorrectQuestions"] += temp[xyz]["correct_questions"]
                            s1["totalScore"] += temp[xyz]["score"]
                            s1["totalAttempts"] += temp[xyz]["attempts"]
                        } else if (doc.id == "Stage 2") {
                            s2["totalTime"] += temp[xyz]["time_taken"]
                            s2["totalCorrectQuestions"] += temp[xyz]["correct_questions"]
                            s2["totalScore"] += temp[xyz]["score"]
                            s2["totalAttempts"] += temp[xyz]["attempts"]
                        } else if (doc.id == "Stage 3") {
                            s3["totalTime"] += temp[xyz]["time_taken"]
                            s3["totalCorrectQuestions"] += temp[xyz]["correct_questions"]
                            s3["totalScore"] += temp[xyz]["score"]
                            s3["totalAttempts"] += temp[xyz]["attempts"]
                        }
                    }

                }
            })
        }

        singleStudent[studentList[i]]["score"] = (singleStudent[studentList[i]]["score"] / 9).toFixed(2)
        singleStudent[studentList[i]]["correctQuestions"] = (singleStudent[studentList[i]]["correctQuestions"] / 9).toFixed(2)
        singleStudent[studentList[i]]["attempts"] = (singleStudent[studentList[i]]["attempts"] / 9).toFixed(2)
        singleStudent[studentList[i]]["time"] = (singleStudent[studentList[i]]["time"] / 9).toFixed(2)


    }


    s1["totalScore"] = (s1["totalScore"] / studentList.length).toFixed(2)
    s1["totalTime"] = (s1["totalTime"] / studentList.length).toFixed(2)
    s1["totalCorrectQuestions"] = (s1["totalCorrectQuestions"] / studentList.length).toFixed(2)
    s1["totalAttempts"] = (s1["totalAttempts"] / studentList.length).toFixed(2)

    s2["totalScore"] = (s2["totalScore"] / studentList.length).toFixed(2)
    s2["totalTime"] = (s2["totalTime"] / studentList.length).toFixed(2)
    s2["totalCorrectQuestions"] = (s2["totalCorrectQuestions"] / studentList.length).toFixed(2)
    s2["totalAttempts"] = (s2["totalAttempts"] / studentList.length).toFixed(2)

    s3["totalScore"] = (s3["totalScore"] / studentList.length).toFixed(2)
    s3["totalTime"] = (s3["totalTime"] / studentList.length).toFixed(2)
    s3["totalCorrectQuestions"] = (s3["totalCorrectQuestions"] / studentList.length).toFixed(2)
    s3["totalAttempts"] = (s3["totalAttempts"] / studentList.length).toFixed(2)

    studentData["Stage 1"] = s1
    studentData["Stage 2"] = s2
    studentData["Stage 3"] = s3
    set_function(studentData)
    setIndividual(singleStudent)
}
export async function readAssignmentData(teacher, set_function, setTitle) {
    var assignmentData = {}
    var assignmentId = []
    var assignmentTitle = []
    const db = firebase.firestore()
    var document = await db.collection("Teacher").doc(teacher).get()
    assignmentId = document.data()["assignment_code"]
    var data = await db.collection("Assignments").get()
    if (data.empty == false) {
        for (var i = 0; i < assignmentId.length; i++) {
            assignmentData[assignmentId[i]] = {
                "assignment_code": "",
                "attempted_students": [],
                "class_index": "",
                "dueDate": "",
                "title": "",
                "world": "",
                "cleared_student": {}
            }
            data.docs.forEach((doc) => {
                if (doc.id == assignmentId[i]) {
                    var temp = doc.data()
                    assignmentTitle.push(temp["title"])
                    assignmentData[assignmentId[i]]["assignment_code"] = temp["assignment_code"]
                    assignmentData[assignmentId[i]]["attempted_students"] = temp["attempted_students"]
                    assignmentData[assignmentId[i]]["class_index"] = temp["class_index"]
                    assignmentData[assignmentId[i]]["dueDate"] = temp["dueDate"]
                    assignmentData[assignmentId[i]]["title"] = temp["title"]
                    assignmentData[assignmentId[i]]["world"] = temp["world"]
                    assignmentData[assignmentId[i]]["cleared_student"] = temp["cleared_students"]
                }
            })
        }
    }
    setTitle(assignmentTitle)
    set_function(assignmentData)
}