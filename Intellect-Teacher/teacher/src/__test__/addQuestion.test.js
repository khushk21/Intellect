import axios from "axios";
test("Check Add Question", async()=>{
    var k= await axios.get("http://localhost:8000/api/addQuestion")
    var difference=k.data.data;
    expect (difference).toBe(1);
});

