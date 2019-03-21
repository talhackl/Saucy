using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using E_CommerceDbFirst.Models;
using System.Data.Entity;

namespace E_CommerceDbFirst.Controllers.Api
{
    public class OrdersController : ApiController
    {
        data_Base db;
        public OrdersController()
        {
            db = new data_Base();
        }
        public IHttpActionResult getOrders()
        {
            var orders = db.getOrderList();
            return Ok(orders);
        }
    }
}
