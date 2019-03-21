using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using E_CommerceDbFirst.Models;

namespace E_CommerceDbFirst.Controllers.Api
{
    public class CategoriesController : ApiController
    {
        data_Base db;
        public CategoriesController()
        {
            db = new data_Base();
        }

        [HttpGet]
        public IHttpActionResult get()
        {
            var data = db.getCategories();
            return Ok(data);
        }

        [HttpPost]
        public IHttpActionResult post(Category category)
        {
            if (ModelState.IsValid)
            {
                db.Categories.Add(category);
                db.SaveChanges();
                return Ok();
            }
            return BadRequest("Model Is not Valid");
            
        }
    }

}
