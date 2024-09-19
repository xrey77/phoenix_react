import React, { useEffect, useState } from "react";
import $ from "jquery";
import axios from 'axios';

const api = axios.create({
    baseURL: "http://localhost:4000",
    headers: {'Accept': 'application/json',
              'Content-Type': 'application/json',
              'Authorization': 'inherit'},
})

const Profile = () => {
    const [firstname, setFirstname] = useState('');
    const [lastname, setLastname] = useState('');
    const [emailadd, setEmailadd] = useState('');
    const [mobileno, setMobileno] = useState('');
    const [qrcode, setQrcode] = useState('')
    const [role, setRole] = useState('');
    const [userpic, setUserpic] = useState('');
    const [newpassword, setNewpassword] = useState('')
    const [confnewpassword, setConfirmnewpassword] = useState('')
    const [message, setMessage] = useState('');

    let userid: any = sessionStorage.getItem("USERID")

    useEffect(() => {
      const loadProfile = () => {
              api.get("/api/userid/" + userid)
              .then((res: any) => {
                setFirstname(res.data[0].firstname)
                setLastname(res.data[0].lastname)
                setEmailadd(res.data[0].emailadd)
                setMobileno(res.data[0].mobileno)     
                setRole(res.data[0].role)           
                setUserpic(res.data[0].profilepic)
                return;
          }, (error: any) => {
              setMessage(error.message);            
              return;
          });        
         
      }
      loadProfile();
    },[userid])

    const changePwd = () => {
        $("#onetimepassword").hide()
        $("#changepassword").show()
        setNewpassword("")
        setConfirmnewpassword("")
    }

    const oneTimePwd = () => {
        $("#changepassword").hide()
        $("#onetimepassword").show()
    }

    const changePassword = (event: any) => {
      if (newpassword !== confnewpassword) {
        setMessage("New password does not matched.")
        return
      }
      event.preventDefault();
      const data =JSON.stringify({ 
        user : {
          password: newpassword 
        }
      });        
      api.patch("/api/user/update/password/" + userid, data)
         .then((res: any) => {
              setMessage(res.data[0].message)
              window.setTimeout(() => {
                  setMessage("")
                  setNewpassword("")
                  setConfirmnewpassword("")
              }, 4000);
      }, (error: any) => {
          setMessage(error.message);            
      });
    }

    const enableOTP = (event: any) => {
      event.preventDefault()
      const data =JSON.stringify({ 
        user : {
          qrcode: null
        }
      });        
      api.patch("/api/qrcode/enable/" + userid, data)
      .then((res: any) => {
          setMessage(res.data[0].message)
    }, (error: any) => {
        setMessage(error.message);            
    });

    }

    const disableOTP = (event: any) => {
      event.preventDefault()

      const data =JSON.stringify({ 
        user : {
          qrcode: null
        }
      });        

      api.patch("/api/qrcode/disable/" + userid, data)
      .then((res: any) => {
          setMessage(res.data[0].message)
    }, (error: any) => {
        setMessage(error.message);            
    });

    }

    const changePicture = (event: any) => {
      event.preventDefault();

      $("#userpic").attr('src',URL.createObjectURL(event.target.files[0]));

      const data = new FormData();
      data.append("id", userid);
      data.append("profilepic",event.target.files[0])
        api.post("/api/user/update/picture", data, {headers: {"Content-Type": "Multipart/form-data", }})
         .then((res: any) => {
              setMessage(res.data[0].message)
              window.setTimeout(() => {
                      setMessage("")
              }, 4000);
              return;
      }, (error: any) => {
          setMessage(error.message);            
      });
    }

    const updateProfile = (event: any) => {
      event.preventDefault();
          const data =JSON.stringify({ 
            "user": {
              firstname: firstname,
              lastname: lastname,
              mobileno: mobileno
          }});        

        api.patch("/api/user/update/" + userid, data)
          .then((res: any) => {
              setMessage(res.data[0].message)
        }, (error: any) => {
            setMessage(error.message);            
        });
    }

    return (
    <div className="card profile-width mt-2">
    <div className="card-header bg-primary text-white">
        <h3>User's Profile ID No. {userid}</h3>
    </div>
    <div className="card-body">
     <form onSubmit={updateProfile}>
        <div className="row">
          <div className="col">
            <div className="mb-3">
              <label htmlFor="fname" className="form-label">Firstname</label>
              <input type="text" value={firstname} onChange={e => setFirstname(e.target.value)} className="form-control" id="fname"/>
            </div>
            <div className="mb-3">
              <label htmlFor="lname" className="form-label">Lastname</label>
              <input type="text" value={lastname} onChange={e => setLastname(e.target.value)} className="form-control" id="lname"/>
            </div>
          </div>
          <div className="col">
            {
              userpic === null ?
                <img id="userpic" className="user-profile" src="/images/userx.png" alt="" />
              :
                <img id="userpic" className="user-profile" src={userpic} alt="" />
            }
                <div className="mb-3 mt-4">
                    <input onChange={changePicture} className="form-control form-control-sm" id="pix" type="file"/>
                </div>
          </div>
        </div>

        <div className="row">
            <div className="col">
              <div className="mb-3">
                <label htmlFor="mail" className="form-label">Email Address</label>
                <input type="email" value={emailadd} onChange={e => setEmailadd(e.target.value)} className="form-control" id="mail" readOnly/>
              </div>
            </div>
            <div className="col">
              <div className="mb-3">
                <label htmlFor="mobile" className="form-label">Mobile No.</label>
                <input type="text" value={mobileno} onChange={e => setMobileno(e.target.value)} className="form-control" id="mobile"/>
              </div>                
            </div>
            <div className="col">
              <div className="mb-3">
                <label htmlFor="role" className="form-label">Role</label>
                <input type="text" value={role} onChange={e => setRole(e.target.value)} readOnly className="form-control" id="role"/>
              </div>                
            </div>
        </div>

        <div className="mb-3">
           <button type="submit" className="btn btn-primary">Update profile</button>
        </div>

        <hr/>
        <div className="row">
            <div className="col">

                <p className="d-inline-flex gap-1">
                <a onClick={changePwd} className="btn btn-info text-white" data-bs-toggle="collapse" href="#changepassword" role="button" aria-expanded="false" aria-controls="changepassword">
                    Change Password
                </a>
                {/* CHANGE PASSWORD */}
                <button onClick={oneTimePwd} className="btn btn-info text-white" type="button" data-bs-toggle="collapse" data-bs-target="#onetimepassword" aria-expanded="false" aria-controls="onetimepassword">
                    One Time Password (OTP)
                </button>
                </p>
                <div className="collapse" id="changepassword">
                  <div className="card card-body">
                    <div className="row">
                        <div className="col">
                          <div className="mb-3">
                            <input type="password" value={newpassword} onChange={e => setNewpassword(e.target.value)} className="form-control" id="newpwd" placeholder="enter new password"/>
                          </div>
                        </div>
                        <div className="col">
                          <div className="mb-3">
                            <input type="password" value={confnewpassword} onChange={e => setConfirmnewpassword(e.target.value)} className="form-control" id="confnewpwd" placeholder="confirm new password"/>
                          </div>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col">
                            <button onClick={changePassword} type="button" className="btn btn-success">save changes</button>
                        </div>
                        <div className="col">
                            &nbsp;
                        </div>

                    </div>
                  </div>
                </div>
                {/* ONE TIME PASSWORD */}
                <div className="collapse" id="onetimepassword">
                  <div className="card card-body">
                    <div className="w-100">
                        <div className="col">
                          <div className="row">
                          <div className="mb-3">
                  Install <strong>Google Authenticator</strong> or <strong>Microsoft Authenticator</strong>
                      &nbsp;in your <strong>Mobile Phone</strong>, and Scan <strong>QR CODE</strong> below.
                        </div>

                          </div>
                          <div className="row">
                          <div className="mb-3">
                            {
                              qrcode === null ?
                              <img className="qrcode" src="/images/qrcode.png" alt="" />                        
                              :
                              <img className="qrcode" src={qrcode} alt="" />                        
                            }
                          </div>
                          </div>
                        </div>

                        <div className="mb-3">
                            <div className="row g-1">
                                <div className="col-auto">
                                    <button onClick={enableOTP} type="button" className="btn btn-success">Enable OTP</button>
                                </div>
                                <div className="col-auto">
                                  <button onClick={disableOTP} type="button" className="btn btn-secondary text-white">Disable OTP</button>
                                </div>
                            </div>
                        </div>
                      </div>
                  </div>
                </div>

            </div>
        </div>

     </form>
        
    </div>
    <footer className="bg-light text-center text-danger">{message}</footer>

    </div>    
  );
}

export default Profile;