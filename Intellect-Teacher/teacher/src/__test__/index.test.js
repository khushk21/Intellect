import axios from "axios";
test("Check Class Indexes Retrieval", async()=>{
    var k= await axios.get("http://localhost:8000/api/test")
    var list=k.data.data;
    expect(list.length).toBe(3);
});

