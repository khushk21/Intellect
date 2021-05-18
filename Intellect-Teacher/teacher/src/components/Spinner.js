import React, { Fragment } from "react";
import spinner from "../spinner.gif";

export default () => (
  <Fragment>
    <img
      src={spinner}
      style={{height:800,width:1500 , display: "block" }}
      alt="Loading..."
    />
  </Fragment>
);