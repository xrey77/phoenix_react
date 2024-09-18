import { Routes, Route } from "react-router-dom";
import React from "react"
import Home from "./react/components/Home"
import Aboutus from "./react/components/Aboutus";
import Contactus from "./react/components/Contactus";
import Profile from "./react/components/Profile";

const Router = () => {
    return (
      <Routes>
        <Route path='/' element={<Home/>} />
        <Route path='/aboutus' element={<Aboutus />} />        
        <Route path='/contactus' element={<Contactus />} />        
        <Route path='/profile' element={<Profile />} />        
      </Routes>
    );
}  

export default Router;