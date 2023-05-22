import React from "react"
import { Link } from "react-router-dom";

export const UnauthenticatedView = () => {
  return <div>
    Please <Link to="/signin">Sign In</Link> to view the contents of this page
  </div>
}