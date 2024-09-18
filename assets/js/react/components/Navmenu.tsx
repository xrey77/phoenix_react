import React, { useEffect } from "react";
import { Link } from "react-router-dom";
import Signin from "./Signin";
import Signup from "./Signup";
import "../../../css/app.css";

const Navmenu = () => {
    let username: any = sessionStorage.getItem("USERNAME");

    const signout = () => {
      sessionStorage.removeItem("USERNAME")
      window.location.href = "/"
    }

    return (
    <>
      <nav className="navbar navbar-expand-lg bg-body-tertiary">
        <div className="container-fluid">
          <Link className="navbar-brand" to={'/'}>
            <img className="logo" src={"/images/logo.png"} alt="" />
          </Link>
          <button className="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasExample" aria-controls="offcanvasExample">
            <span className="navbar-toggler-icon"></span>
            <span className="cap">PHOENIX</span>
          </button>
          <div className="collapse navbar-collapse" id="navbarSupportedContent">
            <ul className="navbar-nav me-auto mb-2 mb-lg-0">
              <li className="nav-item">
                <Link className="nav-link active" aria-current="page" to={'/aboutus'}>About Us</Link>
              </li>
              <li className="nav-item dropdown">
                <a className="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                  Products
                </a>
                <ul className="dropdown-menu">
                  <li><a className="dropdown-item" href="#">Product 1</a></li>
                  <li><a className="dropdown-item" href="#">Product 2</a></li>
                  <li><a className="dropdown-item" href="#">Product 3</a></li>
                  <li><hr className="dropdown-divider"/></li>
                  <li><a className="dropdown-item" href="#">Product 4</a></li>
                </ul>
              </li>
              <li className="nav-item">
                <Link className="nav-link" to={'/contactus'}>Contact Us</Link>
              </li>
            </ul>
            {
              username !== null ?

              <li className="nav-item dropdown  user-left">
                <a className="nav-link dropdown-toggle" href="#/" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                  <span><img className="user" src="/images/userx.png" alt=""/>&nbsp;</span><span>{username}</span>
                </a>
                <ul className="dropdown-menu">
                  <li><a onClick={signout} className="dropdown-item" href="#/">Logout</a></li>
                  <li><Link className="dropdown-item" to={'/profile'}>Profile</Link></li>
                  <li><a className="dropdown-item" href="#">Messenger</a></li>
                </ul>
              </li>

              :
                <ul className="navbar-nav mr-auto">
                  <li className="nav-item">
                    <a className="nav-link" href="#/" data-bs-toggle="modal" data-bs-target="#staticSigninBackdrop">Signin</a>
                  </li>
                  <li className="nav-item">
                    <a className="nav-link" href="#/" data-bs-toggle="modal" data-bs-target="#staticSignupBackdrop">Signup</a>
                  </li>
                </ul>
            }


          </div>
        </div>
      </nav>
      {/* DRAWER MENU */}
      <div className="offcanvas offcanvas-end" tabIndex={-1} id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
        <div className="offcanvas-header bg-success ">
          <h5 className="offcanvas-title text-white" id="offcanvasExampleLabel">Drawer Menu</h5>
          <button type="button" className="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <div className="offcanvas-body">
         <ul className="nav flex-column">
          <li className="nav-item" data-bs-dismiss="offcanvas">
            <Link className="nav-link active" aria-current="page" to={'/aboutus'}>About Us</Link>
          </li>
          <hr/>
          <li className="nav-item dropdown">
                <a className="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                  Products
                </a>
                <ul className="dropdown-menu">
                  <li data-bs-dismiss="offcanvas"><a className="dropdown-item" href="#">Product 1</a></li>
                  <li><a className="dropdown-item" href="#">Product 2</a></li>
                  <li data-bs-dismiss="offcanvas"><a className="dropdown-item" href="#">Product 3</a></li>
                  <li><hr className="dropdown-divider"/></li>
                  <li data-bs-dismiss="offcanvas"><a className="dropdown-item" href="#">Product 4</a></li>
                </ul>
              </li>
          <hr/>
          <li className="nav-item" data-bs-dismiss="offcanvas">
            <Link className="nav-link" to={'/contactus'}>Contact Us</Link>
          </li>
          <hr/>

          {
            username !== null ?
            <li className="nav-item dropdown">
              <a className="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              <span><img className="user" src="/images/userx.png" alt=""/></span>&nbsp; <span>{username}</span>
              </a>
              <ul className="dropdown-menu">
                <li data-bs-dismiss="offcanvas"><a onClick={signout} className="dropdown-item" href="#/">Logout</a></li>
                <li><a className="dropdown-item" href="#">Product 2</a></li>
                <li data-bs-dismiss="offcanvas"><Link className="dropdown-item" to={'/profile'}>Profile</Link></li>
                <li><hr className="dropdown-divider"/></li>
                <li data-bs-dismiss="offcanvas"><a className="dropdown-item" href="#/">Messenger</a></li>
              </ul>
              </li>
          :
          <>
          <li className="nav-item" data-bs-dismiss="offcanvas">
            <a className="nav-link" href="#/" data-bs-toggle="modal" data-bs-target="#staticSigninBackdrop">Signin</a>
          </li>
          <hr/>
          <li className="nav-item" data-bs-dismiss="offcanvas">
          <a className="nav-link" href="#/" data-bs-toggle="modal" data-bs-target="#staticSignupBackdrop">Signup</a>
          </li>
          </>

          }

          <hr/>
         </ul>
        </div>
      </div>

      <Signin/>
      <Signup/>
  </>
  );
}

export default Navmenu;