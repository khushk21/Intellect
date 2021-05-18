import React from "react";
import { Navbar, Nav,NavDropdown } from "react-bootstrap";
export default function MainAppBar_(){
  return(
<>
    <Navbar bg="dark" variant="dark">
    <Navbar.Brand href="/">Intellect</Navbar.Brand>
    <Navbar.Toggle aria-controls="responsive-navbar-nav"/>
    <Nav className="mr-auto">
      <Nav.Link href="/">Home</Nav.Link>
      <Nav.Link href="/addclassindex">Add New Index</Nav.Link>
      <Nav.Link href="/sendassignment">Send New Assignment</Nav.Link>
      <NavDropdown title="Manage Students" variant="dark" bg="dark">
      <NavDropdown.Item href="/createstudent">Add New Student</NavDropdown.Item>
      <NavDropdown.Divider/>
      <NavDropdown.Item href="/deletestudent">Delete Student Account</NavDropdown.Item>
      </NavDropdown>
      <NavDropdown title="View Progress" variant="dark" bg="dark">
      <NavDropdown.Item href="/progress">Class Progress</NavDropdown.Item>
      <NavDropdown.Divider/>
      <NavDropdown.Item href="/progressassignment">Assignment Progress</NavDropdown.Item>
      </NavDropdown>
      <NavDropdown title="Edit Question Bank" variant="dark" bg="dark">
      <NavDropdown.Item href="/addquestion">Add Question</NavDropdown.Item>
      <NavDropdown.Divider/>
      <NavDropdown.Item href="/deletequestion">Delete Question</NavDropdown.Item>
      </NavDropdown>
    </Nav>
  </Navbar>
  </>
  );
}