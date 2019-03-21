using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using E_CommerceDbFirst.Models;

namespace E_CommerceDbFirst.Controllers.Api
{
    public class IngredientsController : ApiController
    {
        data_Base db;
        public IngredientsController()
        {
            db = new data_Base();
        }



        [HttpGet]
        public IHttpActionResult getIngredients()
        {
            var ingredients = db.getIngredientsList();
            return Ok(ingredients);
        }


        //Basically it is being called from Index Page of Items And it is getting Ingredients on the base of CatId
        [HttpGet]
        public IHttpActionResult getIngredients(int id)
        {
            var ingredients = db.getIngredientsByCategoryId(id);
            if(ingredients != null)
                return Ok(ingredients);
            return Redirect("/items/index");
        }



    }
}
