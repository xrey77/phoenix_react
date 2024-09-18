import "bootstrap/dist/css/bootstrap";
import "bootstrap/dist/js/bootstrap.bundle";
import { BrowserRouter } from 'react-router-dom';
import React from "react";
import ReactDOM from "react-dom";
import Main from "./router";
import Header from "./react/components/Navmenu";
import Footer from "./react/components/Footer";

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <BrowserRouter>
     <Header/>
        <Main />
     <Footer/>    
  </BrowserRouter>
);
