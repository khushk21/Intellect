import axios from "axios";
test("Check Student List", async()=>{
    var k= await axios.get("http://localhost:8000/api/students")
    var list=k.data.data;
    expect(list.length).toBe(5);
});

