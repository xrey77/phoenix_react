import React, { useState } from "react";
import axios from 'axios';

const api = axios.create({
    baseURL: "http://localhost:4000",
    headers: {'Accept': 'application/json',
              'Content-Type': 'application/json',
              'Authorization': 'inherit'},
})

const Signup = () => {
    const [firstname, setFirstname] = useState('');
    const [lastname, setLastname] = useState('');
    const [emailadd, setEmailadd] = useState('');
    const [mobileno, setMobileno] = useState('');
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [message, setMessage] = useState('');

    const submitRegistration = (event: any) => {
        event.preventDefault();
        const data =JSON.stringify({ 
            "account": {
            firstname: firstname,
            lastname: lastname,
            emailadd: emailadd,
            mobileno: mobileno,
            username: username, 
            password: password,
            role: "User"
        }});        

        api.post("/auth/signup", data)
           .then((res: any) => {
            setMessage(res.data[0].message)
            window.setTimeout(() => {
              if (res.data[0].statuscode !== 201) {
                setMessage("")
              }
            }, 4000);
        }, (error: any) => {
            setMessage(error.message);            
        });
    }

    const clearData = () => {
      setFirstname("")
      setLastname("")
      setEmailadd("")
      setMobileno("")
      setMessage("")
      setUsername("")
      setPassword("")
    }    

    return (
        <div className="modal fade" id="staticSignupBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabIndex={-1} aria-labelledby="staticSignupBackdropLabel" aria-hidden="true">
        <div className="modal-dialog modal-dialog-centered">
            <div className="modal-content">
            <div className="modal-header bg-primary">
                <h1 className="modal-title fs-5 text-white" id="staticSignupBackdropLabel">Create your Account</h1>
                <button onClick={clearData} type="button" className="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div className="modal-body">
                <form onSubmit={submitRegistration}>
                   <div className="row">
                       <div className="col">
                         <div className="mb-3">
                            <input type="text" value={firstname} onChange={e => setFirstname(e.target.value)} required className="form-control" id="fname"  autoComplete="false" placeholder="enter Firstname"/>
                         </div>                    
                       </div>
                       <div className="col">
                         <div className="mb-3">
                            <input type="text" value={lastname} onChange={e => setLastname(e.target.value)} className="form-control" required id="lname" autoComplete="false" placeholder="enter Lastname"/>
                         </div>                    
                       </div>
                   </div>

                   <div className="row">
                       <div className="col">
                         <div className="mb-3">
                            <input type="email" value={emailadd} onChange={e => setEmailadd(e.target.value)} className="form-control" required id="emailadd" placeholder="emter Email Address"/>
                         </div>                    
                       </div>
                       <div className="col">
                         <div className="mb-3">
                            <input type="text" value={mobileno} onChange={e => setMobileno(e.target.value)} className="form-control" required id="mobileno" placeholder="enter Mobileno"/>
                         </div>                    
                       </div>
                   </div>


                   <div className="row">
                       <div className="col">
                         <div className="mb-3">
                            <input type="text" value={username} onChange={e => setUsername(e.target.value)} className="form-control" required id="usr_name" placeholder="emter Username"/>
                         </div>                    
                       </div>
                       <div className="col">
                         <div className="mb-3">
                            <input type="password" value={password} onChange={e => setPassword(e.target.value)} className="form-control" required id="pass_wd" placeholder="enter Password"/>
                         </div>                    
                       </div>
                   </div>


                  <div className="mb-3">
                    <button type="submit" className="btn btn-primary">signup</button>
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

export default Signup;