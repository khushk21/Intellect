import axios from "axios";
test("Check Add Question", async()=>{
    var k= await axios.get("http://localhost:8000/api/checkProgress")
    var l=k.data.data;
    expect (l).toBe(4);
});

