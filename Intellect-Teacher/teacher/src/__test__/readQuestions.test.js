import axios from "axios";
test("Check Question List", async()=>{
    var k= await axios.get("http://localhost:8000/api/readQuestion")
    var list=k.data.data;
    expect(list).toBe(3);
});

