using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using E_CommerceDbFirst.Models;

namespace E_CommerceDbFirst.Controllers.Api
{
    public class AccountsController : ApiController
    {
        data_Base db;
        public AccountsController()
        {
            db = new data_Base();
        }
        [HttpGet]
        public IHttpActionResult getUsers()
        {
            var dbUsers = db.getUsersList();
            return Ok(dbUsers);
        }

        [HttpGet]
        public IHttpActionResult lockUser(string id)
        {
            var dbUser = db.AspNetUsers.Single(u => u.Id == id);
            if (dbUser.UserName != "eLvisH")
            {
                dbUser.IsDisable = true;
                db.SaveChanges();
            }
            return Ok();
        }

        [HttpPost]
        public IHttpActionResult UnLockUser(string id)
        {
            var dbUser = db.AspNetUsers.Single(u => u.Id == id);
            if (dbUser.UserName != "eLvisH")
            {
                dbUser.IsDisable = false;
                db.SaveChanges();
            }
            return Ok();
        }

    }
}
