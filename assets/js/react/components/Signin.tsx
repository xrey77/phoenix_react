import React, { useState } from "react";
import axios from 'axios';

const api = axios.create({
    baseURL: "http://localhost:4000",
    headers: {'Accept': 'application/json',
              'Content-Type': 'application/json',
              'Authorization': 'inherit'},
})

const Signin = () => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [message, setMessage] = useState('');
    const [disable, setDisable] = useState(false);

    const submitLogin = (event: any) => {
        event.preventDefault();
        setDisable(true);
        const data =JSON.stringify({ emailadd: username, password: password });        
        api.post("/auth/signin", data)
           .then((res: any) => {
            sessionStorage.setItem("USERID", res.data[0].id)
            sessionStorage.setItem("USERNAME",res.data[0].firstname)
            sessionStorage.setItem("USERPIC", res.data[0].profilepic)
            sessionStorage.setItem("TOKEN",res.data[0].token)
            setMessage(res.data[0].message)
            window.setTimeout(() => {
                if (res.data[0].statuscode === 201) {
                    setMessage("")
                    window.location.href="/"    
                } else {
                    setDisable(false)
                    setMessage("")
                    setUsername("")
                    setPassword("")
                }
            }, 4000);
    
        }, (error: any) => {
            setDisable(false)
            setMessage(error.message);            
        });
    }

    const clearData = () => {
        setUsername("")
        setPassword("")
    }

    return (
        <div className="modal fade" id="staticSigninBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabIndex={-1} aria-labelledby="staticSigninBackdropLabel" aria-hidden="true">
        <div className="modal-dialog modal-dialog-sm modal-dialog-centered">
            <div className="modal-content">
            <div className="modal-header bg-success">
                <h1 className="modal-title fs-5 text-white" id="staticSigninBackdropLabel">Signin to your account</h1>
                <button onClick={clearData} type="button" className="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div className="modal-body">
                <form onSubmit={submitLogin} autoComplete="false">
                  <div className="mb-3">
                    <input type="email" disabled={disable} value={username} onChange={e => setUsername(e.target.value)} required className="form-control" id="usrname" placeholder="enter Email Address"/>
                  </div>                    
                  <div className="mb-3">
                    <input type="password" disabled={disable} value={password} onChange={e => setPassword(e.target.value)} required className="form-control" id="passwd" placeholder="enter Password"/>
                  </div>                    
                  <div className="mb-3">
                    <button type="submit" className="btn btn-success">signin</button>
                  </div>                    
                </form>
            </div>
            <div className="modal-footer">
                <div className="w-100 text-danger">{message}</div>
            </div>
            </div>
        </div>
        </div>
    );
}

export default Signin;