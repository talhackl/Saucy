using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using E_CommerceDbFirst.Models;
using System.Data.Entity;
using System.Diagnostics;

namespace E_CommerceDbFirst.Controllers.Api
{
    public class CartsController : ApiController
    {
        data_Base db;
        public CartsController()
        {
            db = new data_Base();
        }
        [HttpGet]
        public IHttpActionResult getCarts(string Ids)
        {
            List<int> IdList = new List<int>();
            string[] IdsString = Ids.Split(',');
            foreach (var id in IdsString)
            {
                IdList.Add(Convert.ToInt32(id));
            }
            var data = db.Items.Where(m => IdList.Contains(m.ItemId) && m.IsDisable == false).Select(m => new { m.ItemId,m.ImageUrl,m.Name,m.Price}).ToList();
            return Ok(data);
        }


        [HttpPut]
        public IHttpActionResult delete(int id)
        {
            db.deleteCart(id);
            db.SaveChanges();
            return Ok();
        }

        [HttpPost]
        public IHttpActionResult save(Cart cart)
        {
            var dbcart = db.Carts.Where(c => c.ItemsId == cart.ItemsId && c.CustomerName == cart.CustomerName).SingleOrDefault();
            if (dbcart == null)
            {
                var dbuser = db.AspNetUsers.Single(usr => usr.UserName == cart.CustomerName);
                if (dbuser != null)
                {
                    cart.DateCreated = DateTime.Now.Date;
                    //System.Diagnostics.Debug.WriteLine(cart.DateCreated);
                    db.saveNewCart(cart.ItemsQunatity, cart.DateCreated, cart.ItemsId, cart.CustomerName);
                    db.SaveChanges();
                    return Ok();
                }
                return BadRequest("You Donot Have Permisions");
            }
            int quantity=dbcart.ItemsQunatity;
            quantity = quantity + cart.ItemsQunatity;
            db.updateCart(dbcart.CartId, quantity);
            db.SaveChanges();
            return Ok();

        }


    }
}
